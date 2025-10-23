{-# OPTIONS_GHC -fno-warn-unused-imports #-}
#include <bindings.dsl.h>
#include <pulsar/c/consumer.h>
module Pulsar.Client.Internal.Foreign.Consumer where
import Foreign.Ptr
import Pulsar.Client.Internal.Foreign.Message
import Pulsar.Client.Internal.Foreign.MessageId
import Pulsar.Client.Internal.Foreign.Messages
import Pulsar.Client.Internal.Foreign.Result
#strict_import
{- typedef struct _pulsar_consumer pulsar_consumer_t; -}
#opaque_t struct _pulsar_consumer
#synonym_t pulsar_consumer_t , <struct _pulsar_consumer>
#callback pulsar_result_callback , <pulsar_result> -> Ptr () -> IO ()
#callback pulsar_receive_callback , <pulsar_result> -> Ptr <struct _pulsar_message> -> Ptr () -> IO ()
#callback pulsar_batch_receive_callback , <pulsar_result> -> Ptr <struct _pulsar_messages> -> Ptr () -> IO ()
#ccall pulsar_consumer_get_topic , Ptr <struct _pulsar_consumer> -> IO CString
#ccall pulsar_consumer_get_subscription_name , Ptr <struct _pulsar_consumer> -> IO CString
#ccall pulsar_consumer_unsubscribe , Ptr <struct _pulsar_consumer> -> IO <pulsar_result>
#ccall pulsar_consumer_unsubscribe_async , Ptr <struct _pulsar_consumer> -> <pulsar_result_callback> -> Ptr () -> IO ()
#ccall pulsar_consumer_receive , Ptr <struct _pulsar_consumer> -> Ptr (Ptr <struct _pulsar_message>) -> IO <pulsar_result>
#ccall pulsar_consumer_receive_with_timeout , Ptr <struct _pulsar_consumer> -> Ptr (Ptr <struct _pulsar_message>) -> CInt -> IO <pulsar_result>
#ccall pulsar_consumer_receive_async , Ptr <struct _pulsar_consumer> -> <pulsar_receive_callback> -> Ptr () -> IO ()
#ccall pulsar_consumer_batch_receive , Ptr <struct _pulsar_consumer> -> Ptr (Ptr <struct _pulsar_messages>) -> IO <pulsar_result>
#ccall pulsar_consumer_batch_receive_async , Ptr <struct _pulsar_consumer> -> <pulsar_batch_receive_callback> -> Ptr () -> IO ()
#ccall pulsar_consumer_acknowledge , Ptr <struct _pulsar_consumer> -> Ptr <struct _pulsar_message> -> IO <pulsar_result>
#ccall pulsar_consumer_acknowledge_id , Ptr <struct _pulsar_consumer> -> Ptr <struct _pulsar_message_id> -> IO <pulsar_result>
#ccall pulsar_consumer_acknowledge_async , Ptr <struct _pulsar_consumer> -> Ptr <struct _pulsar_message> -> <pulsar_result_callback> -> Ptr () -> IO ()
#ccall pulsar_consumer_acknowledge_async_id , Ptr <struct _pulsar_consumer> -> Ptr <struct _pulsar_message_id> -> <pulsar_result_callback> -> Ptr () -> IO ()
#ccall pulsar_consumer_acknowledge_cumulative , Ptr <struct _pulsar_consumer> -> Ptr <struct _pulsar_message> -> IO <pulsar_result>
#ccall pulsar_consumer_acknowledge_cumulative_id , Ptr <struct _pulsar_consumer> -> Ptr <struct _pulsar_message_id> -> IO <pulsar_result>
#ccall pulsar_consumer_acknowledge_cumulative_async , Ptr <struct _pulsar_consumer> -> Ptr <struct _pulsar_message> -> <pulsar_result_callback> -> Ptr () -> IO ()
#ccall pulsar_consumer_acknowledge_cumulative_async_id , Ptr <struct _pulsar_consumer> -> Ptr <struct _pulsar_message_id> -> <pulsar_result_callback> -> Ptr () -> IO ()
#ccall pulsar_consumer_negative_acknowledge , Ptr <struct _pulsar_consumer> -> Ptr <struct _pulsar_message> -> IO ()
#ccall pulsar_consumer_negative_acknowledge_id , Ptr <struct _pulsar_consumer> -> Ptr <struct _pulsar_message_id> -> IO ()
#ccall pulsar_consumer_close , Ptr <struct _pulsar_consumer> -> IO <pulsar_result>
#ccall pulsar_consumer_close_async , Ptr <struct _pulsar_consumer> -> <pulsar_result_callback> -> Ptr () -> IO ()
#ccall pulsar_consumer_free , Ptr <struct _pulsar_consumer> -> IO ()
#ccall pulsar_consumer_pause_message_listener , Ptr <struct _pulsar_consumer> -> IO <pulsar_result>
#ccall resume_message_listener , Ptr <struct _pulsar_consumer> -> IO <pulsar_result>
#ccall pulsar_consumer_redeliver_unacknowledged_messages , Ptr <struct _pulsar_consumer> -> IO ()
#ccall pulsar_consumer_seek_async , Ptr <struct _pulsar_consumer> -> Ptr <struct _pulsar_message_id> -> <pulsar_result_callback> -> Ptr () -> IO ()
#ccall pulsar_consumer_seek , Ptr <struct _pulsar_consumer> -> Ptr <struct _pulsar_message_id> -> IO <pulsar_result>
#ccall pulsar_consumer_seek_by_timestamp_async , Ptr <struct _pulsar_consumer> -> CULong -> <pulsar_result_callback> -> Ptr () -> IO ()
#ccall pulsar_consumer_seek_by_timestamp , Ptr <struct _pulsar_consumer> -> CULong -> IO <pulsar_result>
#ccall pulsar_consumer_is_connected , Ptr <struct _pulsar_consumer> -> IO CInt
#ccall pulsar_consumer_get_last_message_id , Ptr <struct _pulsar_consumer> -> Ptr <struct _pulsar_message_id> -> IO <pulsar_result>
