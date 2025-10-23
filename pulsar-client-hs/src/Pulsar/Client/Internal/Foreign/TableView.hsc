{-# OPTIONS_GHC -fno-warn-unused-imports #-}
#include <bindings.dsl.h>
#include <pulsar/c/table_view.h>
module Pulsar.Client.Internal.Foreign.TableView where
import Foreign.Ptr
import Pulsar.Client.Internal.Foreign.Message
import Pulsar.Client.Internal.Foreign.Messages
import Pulsar.Client.Internal.Foreign.Result
#strict_import
{- typedef struct _pulsar_table_view pulsar_table_view_t; -}
#opaque_t struct _pulsar_table_view
#synonym_t pulsar_table_view_t , <struct _pulsar_table_view>
#callback pulsar_table_view_action , CString -> Ptr () -> CSize -> Ptr () -> IO ()
#callback pulsar_result_callback , <pulsar_result> -> Ptr () -> IO ()
#ccall pulsar_table_view_retrieve_value , Ptr <struct _pulsar_table_view> -> CString -> Ptr (Ptr ()) -> Ptr CSize -> IO CInt
#ccall pulsar_table_view_get_value , Ptr <struct _pulsar_table_view> -> CString -> Ptr (Ptr ()) -> Ptr CSize -> IO CInt
#ccall pulsar_table_view_contain_key , Ptr <struct _pulsar_table_view> -> CString -> IO CInt
#ccall pulsar_table_view_size , Ptr <struct _pulsar_table_view> -> IO CInt
#ccall pulsar_table_view_for_each , Ptr <struct _pulsar_table_view> -> <pulsar_table_view_action> -> Ptr () -> IO ()
#ccall pulsar_table_view_for_each_add_listen , Ptr <struct _pulsar_table_view> -> <pulsar_table_view_action> -> Ptr () -> IO ()
#ccall pulsar_table_view_free , Ptr <struct _pulsar_table_view> -> IO ()
#ccall pulsar_table_view_close , Ptr <struct _pulsar_table_view> -> IO <pulsar_result>
#ccall pulsar_table_view_close_async , Ptr <struct _pulsar_table_view> -> <pulsar_result_callback> -> Ptr () -> IO ()
