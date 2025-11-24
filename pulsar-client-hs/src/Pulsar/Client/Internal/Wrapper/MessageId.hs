{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Pulsar.Client.Internal.Wrapper.MessageId
  ( MessageId (..),
    FetchedMessageId (..),
    messageIdEarliest,
    messageIdLatest,
    withMessageId,
    messageIdShow,
    withDeserializedMessageId,
    messageIdSerialize,
  )
where

import qualified Data.ByteString as BS
import Foreign
import Pulsar.Client.Internal.Foreign.MessageId
import Pulsar.Client.Internal.Wrapper.Pointers
import Pulsar.Client.Internal.Wrapper.Utils
import System.IO.Unsafe
import UnliftIO

withMessageId :: (MonadIO m) => FetchedMessageId s -> ReaderT (FetchedMessageId s) m a -> m a
withMessageId x f = do
  result <- runReaderT f x
  liftIO $ c'pulsar_message_id_free $ unMessageId $ unFetchedMessageId x
  return result

messageIdShow :: (MonadIO m, MonadReader (FetchedMessageId s) m) => m String
messageIdShow = ask >>= \x -> liftIO $ bracket (c'pulsar_message_id_str $ unMessageId $ unFetchedMessageId x) free peekCString

messageIdEarliest :: MessageId
messageIdEarliest = unsafePerformIO $ MessageId <$> c'pulsar_message_id_earliest
{-# NOINLINE messageIdEarliest #-}

messageIdLatest :: MessageId
messageIdLatest = unsafePerformIO $ MessageId <$> c'pulsar_message_id_latest
{-# NOINLINE messageIdLatest #-}

-- | Deserialize a serialized `MessageId`
--
-- WARNING: Currently, this function is not safe! It crashes badly (e.g. stops
-- the program) with invalid ids.
--
-- TODO: Fix this by catching exceptions in pulsar_message_id_deserialize() in
-- libpulsar.
withDeserializedMessageId ::
  forall s m a.
  (MonadIO m, MonadUnliftIO m) =>
  FetchedMessageLink s ->
  BS.ByteString ->
  ReaderT (FetchedMessageId s) m a ->
  m a
withDeserializedMessageId source str f =
  bracket
    fetchedMessageId
    (liftIO . c'pulsar_message_id_free . unMessageId . unFetchedMessageId)
    (runReaderT f)
  where
    fetchedMessageId :: m (FetchedMessageId s)
    fetchedMessageId = FetchedMessageId source <$> messageId

    messageId :: m MessageId
    messageId =
      liftIO $
        MessageId
          <$> BS.useAsCStringLen
            str
            ( \(cStr, len) -> do
                c'pulsar_message_id_deserialize (castPtr cStr) (fromIntegral len)
            )

-- | Serialize a `MessageId` to `String`
--
-- The main difference to `messageIdShow` is that the result `String` can be
-- de-serialized by `withDeserializedMessageId`.
messageIdSerialize :: (MonadIO m, MonadReader (FetchedMessageId s) m) => m BS.ByteString
messageIdSerialize =
  ask >>= \x ->
    liftIO . alloca $ \strLenPtr ->
      bracket
        (ffiCall strLenPtr x)
        free
        (convertResult strLenPtr)
  where
    ffiCall :: Ptr CInt -> FetchedMessageId s -> IO (Ptr CChar)
    ffiCall strLenPtr x = castPtr <$> c'pulsar_message_id_serialize (unMessageId $ unFetchedMessageId x) strLenPtr

    convertResult :: Ptr CInt -> Ptr CChar -> IO BS.ByteString
    convertResult strLenPtr strPtr = do
      len <- peek strLenPtr
      BS.packCStringLen (strPtr, fromIntegral len)
