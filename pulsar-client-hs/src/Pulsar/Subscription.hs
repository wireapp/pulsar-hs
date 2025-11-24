module Pulsar.Subscription where

import Control.Monad.Reader
import Data.Functor
import Foreign (newArray)
import Foreign.Marshal (free)
import Pulsar.Client
import Pulsar.Client.Internal.Foreign.Client
import Pulsar.Client.Internal.Foreign.Consumer
import Pulsar.Client.Internal.Wrapper.ConsumerConfiguration
import Pulsar.Client.Internal.Wrapper.Utils
import UnliftIO.Resource

-- | Create a subscription
--
-- The strategy is to subscribe to topic(s), but not unsubscribe.
createSubscription :: (MonadUnliftIO m) => ConsumerConfiguration -> String -> TopicsSelection -> (RawResult -> m ()) -> ReaderT Client m ()
createSubscription configuration subscriptionName topicsSelection onFailed = do
  Client client <- ask
  lift $
    runResourceT $ do
      subscriptionName' <- toCString subscriptionName
      ptrConfig <- mkConsumerConfiguration configuration
      subscribe <-
        case topicsSelection of
          Topic (TopicName topic) -> toCString topic <&> \topic' -> c'pulsar_client_subscribe client topic' subscriptionName' ptrConfig
          Topics topics -> do
            topics' <- mapM (toCString . topicName) topics
            ptrTopics <- new (newArray topics') free
            return $ c'pulsar_client_subscribe_multi_topics client ptrTopics (fromIntegral $ length topics) subscriptionName' ptrConfig
          TopicsPattern topicsPattern -> toCString topicsPattern <&> \topicsPattern' -> c'pulsar_client_subscribe_pattern client topicsPattern' subscriptionName' ptrConfig
      withPtrPtr $ \ptrConsumer -> do
        result <- liftIO $ subscribe ptrConsumer
        peekOn (isOk $ RawResult result) ptrConsumer (onFailed $ RawResult result) closeConsumer
  where
    closeConsumer :: (MonadIO m) => Ptr C'_pulsar_consumer -> m ()
    closeConsumer ptrConsumer = do
      liftIO $ c'pulsar_consumer_close ptrConsumer
      liftIO $ c'pulsar_consumer_free ptrConsumer
