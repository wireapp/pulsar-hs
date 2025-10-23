{-# OPTIONS_GHC -fno-warn-unused-imports #-}
#include <bindings.dsl.h>
#include <pulsar/c/client.h>
module Pulsar.Client.Internal.Foreign.Client where
import Pulsar.Client.Internal.Foreign.Result
import Pulsar.Client.Internal.Foreign.TableViewConfiguration
import Pulsar.Client.Internal.Foreign.ReaderConfiguration
import Pulsar.Client.Internal.Foreign.Reader
import Pulsar.Client.Internal.Foreign.Message
import Pulsar.Client.Internal.Foreign.ConsumerConfiguration
import Pulsar.Client.Internal.Foreign.Consumer
import Foreign.Ptr
#strict_import

{- typedef struct _pulsar_table_view pulsar_table_view_t; -}
#opaque_t struct _pulsar_table_view
#synonym_t pulsar_table_view_t , <struct _pulsar_table_view>

{- typedef struct _pulsar_client pulsar_client_t; -}
#opaque_t struct _pulsar_client
#synonym_t pulsar_client_t , <struct _pulsar_client>
{- typedef struct _pulsar_producer pulsar_producer_t; -}
#opaque_t struct _pulsar_producer
#synonym_t pulsar_producer_t , <struct _pulsar_producer>
{- typedef struct _pulsar_string_list pulsar_string_list_t; -}
#opaque_t struct _pulsar_string_list
#synonym_t pulsar_string_list_t , <struct _pulsar_string_list>
{- typedef struct _pulsar_client_configuration pulsar_client_configuration_t; -}
#opaque_t struct _pulsar_client_configuration
#synonym_t pulsar_client_configuration_t , <struct _pulsar_client_configuration>
{- typedef struct _pulsar_producer_configuration pulsar_producer_configuration_t; -}
#opaque_t struct _pulsar_producer_configuration
#synonym_t pulsar_producer_configuration_t , <struct _pulsar_producer_configuration>
#callback pulsar_create_producer_callback , <pulsar_result> -> Ptr <struct _pulsar_producer> -> Ptr () -> IO ()
#callback pulsar_subscribe_callback , <pulsar_result> -> Ptr <struct _pulsar_consumer> -> Ptr () -> IO ()
#callback pulsar_reader_callback , <pulsar_result> -> Ptr <struct _pulsar_reader> -> Ptr () -> IO ()
#callback pulsar_table_view_callback , <pulsar_result> -> Ptr <struct _pulsar_table_view> -> Ptr () -> IO ()
#callback pulsar_get_partitions_callback , <pulsar_result> -> Ptr <struct _pulsar_string_list> -> Ptr () -> IO ()
#callback pulsar_close_callback , <pulsar_result> -> Ptr () -> IO ()
#ccall pulsar_client_create , CString -> Ptr <struct _pulsar_client_configuration> -> IO (Ptr <struct _pulsar_client>)
#ccall pulsar_client_create_producer , Ptr <struct _pulsar_client> -> CString -> Ptr <struct _pulsar_producer_configuration> -> Ptr (Ptr <struct _pulsar_producer>) -> IO <pulsar_result>
#ccall pulsar_client_create_producer_async , Ptr <struct _pulsar_client> -> CString -> Ptr <struct _pulsar_producer_configuration> -> <pulsar_create_producer_callback> -> Ptr () -> IO ()
#ccall pulsar_client_subscribe , Ptr <struct _pulsar_client> -> CString -> CString -> Ptr <struct _pulsar_consumer_configuration> -> Ptr (Ptr <struct _pulsar_consumer>) -> IO <pulsar_result>
#ccall pulsar_client_subscribe_async , Ptr <struct _pulsar_client> -> CString -> CString -> Ptr <struct _pulsar_consumer_configuration> -> <pulsar_subscribe_callback> -> Ptr () -> IO ()
#ccall pulsar_client_subscribe_multi_topics , Ptr <struct _pulsar_client> -> Ptr CString -> CInt -> CString -> Ptr <struct _pulsar_consumer_configuration> -> Ptr (Ptr <struct _pulsar_consumer>) -> IO <pulsar_result>
#ccall pulsar_client_subscribe_multi_topics_async , Ptr <struct _pulsar_client> -> Ptr CString -> CInt -> CString -> Ptr <struct _pulsar_consumer_configuration> -> <pulsar_subscribe_callback> -> Ptr () -> IO ()
#ccall pulsar_client_subscribe_pattern , Ptr <struct _pulsar_client> -> CString -> CString -> Ptr <struct _pulsar_consumer_configuration> -> Ptr (Ptr <struct _pulsar_consumer>) -> IO <pulsar_result>
#ccall pulsar_client_subscribe_pattern_async , Ptr <struct _pulsar_client> -> CString -> CString -> Ptr <struct _pulsar_consumer_configuration> -> <pulsar_subscribe_callback> -> Ptr () -> IO ()
#ccall pulsar_client_create_reader , Ptr <struct _pulsar_client> -> CString -> Ptr <struct _pulsar_message_id> -> Ptr <struct _pulsar_reader_configuration> -> Ptr (Ptr <struct _pulsar_reader>) -> IO <pulsar_result>
#ccall pulsar_client_create_reader_async , Ptr <struct _pulsar_client> -> CString -> Ptr <struct _pulsar_message_id> -> Ptr <struct _pulsar_reader_configuration> -> <pulsar_reader_callback> -> Ptr () -> IO ()
#ccall pulsar_client_create_table_view , Ptr <struct _pulsar_client> -> CString -> Ptr <struct _pulsar_table_view_configuration> -> Ptr (Ptr <struct _pulsar_table_view>) -> IO <pulsar_result>
#ccall pulsar_client_create_table_view_async , Ptr <struct _pulsar_client> -> CString -> Ptr <struct _pulsar_table_view_configuration> -> <pulsar_table_view_callback> -> Ptr () -> IO ()
#ccall pulsar_client_get_topic_partitions , Ptr <struct _pulsar_client> -> CString -> Ptr (Ptr <struct _pulsar_string_list>) -> IO <pulsar_result>
#ccall pulsar_client_get_topic_partitions_async , Ptr <struct _pulsar_client> -> CString -> <pulsar_get_partitions_callback> -> Ptr () -> IO ()
#ccall pulsar_client_close , Ptr <struct _pulsar_client> -> IO <pulsar_result>
#ccall pulsar_client_close_async , Ptr <struct _pulsar_client> -> <pulsar_close_callback> -> Ptr () -> IO ()
#ccall pulsar_client_free , Ptr <struct _pulsar_client> -> IO ()
