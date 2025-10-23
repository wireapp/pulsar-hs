{-# OPTIONS_GHC -fno-warn-unused-imports #-}
#include <bindings.dsl.h>
#include <pulsar/c/reader.h>
#include <pulsar/c/result.h>
module Pulsar.Client.Internal.Foreign.Reader where
import Foreign.Ptr
import Pulsar.Client.Internal.Foreign.Message
import Pulsar.Client.Internal.Foreign.MessageId
import Pulsar.Client.Internal.Foreign.Result
#strict_import

{- typedef struct _pulsar_reader pulsar_reader_t; -}
#opaque_t struct _pulsar_reader
#synonym_t pulsar_reader_t , <struct _pulsar_reader>
#callback pulsar_result_callback , <pulsar_result> -> Ptr () -> IO ()
#ccall pulsar_reader_get_topic , Ptr <struct _pulsar_reader> -> IO CString
#ccall pulsar_reader_read_next , Ptr <struct _pulsar_reader> -> Ptr (Ptr <struct _pulsar_message>) -> IO <pulsar_result>
#ccall pulsar_reader_read_next_with_timeout , Ptr <struct _pulsar_reader> -> Ptr (Ptr <struct _pulsar_message>) -> CInt -> IO <pulsar_result>
#ccall pulsar_reader_seek_async , Ptr <struct _pulsar_reader> -> Ptr <struct _pulsar_message_id> -> <pulsar_result_callback> -> Ptr () -> IO ()
#ccall pulsar_reader_seek , Ptr <struct _pulsar_reader> -> Ptr <struct _pulsar_message_id> -> IO <pulsar_result>
#ccall pulsar_reader_seek_by_timestamp_async , Ptr <struct _pulsar_reader> -> CULong -> <pulsar_result_callback> -> Ptr () -> IO ()
#ccall pulsar_reader_seek_by_timestamp , Ptr <struct _pulsar_reader> -> CULong -> IO <pulsar_result>
#ccall pulsar_reader_close , Ptr <struct _pulsar_reader> -> IO <pulsar_result>
#ccall pulsar_reader_close_async , Ptr <struct _pulsar_reader> -> <pulsar_result_callback> -> Ptr () -> IO ()
#ccall pulsar_reader_free , Ptr <struct _pulsar_reader> -> IO ()
#ccall pulsar_reader_has_message_available , Ptr <struct _pulsar_reader> -> Ptr CInt -> IO <pulsar_result>
#ccall pulsar_reader_is_connected , Ptr <struct _pulsar_reader> -> IO CInt
