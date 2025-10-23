{-# OPTIONS_GHC -fno-warn-unused-imports #-}
#include <bindings.dsl.h>
#include <pulsar/c/table_view_configuration.h>
module Pulsar.Client.Internal.Foreign.TableViewConfiguration where
import Foreign.Ptr
import Pulsar.Client.Internal.Foreign.ProducerConfiguration
import Pulsar.Client.Internal.Foreign.StringMap
#strict_import

{- typedef struct _pulsar_table_view_configuration pulsar_table_view_configuration_t; -}
#opaque_t struct _pulsar_table_view_configuration
#synonym_t pulsar_table_view_configuration_t , <struct _pulsar_table_view_configuration>
#ccall pulsar_table_view_configuration_create , IO (Ptr <struct _pulsar_table_view_configuration>)
#ccall pulsar_table_view_configuration_free , Ptr <struct _pulsar_table_view_configuration> -> IO ()
#ccall pulsar_table_view_configuration_set_schema_info , Ptr <struct _pulsar_table_view_configuration> -> <pulsar_schema_type> -> CString -> CString -> Ptr <struct _pulsar_string_map> -> IO ()
#ccall pulsar_table_view_configuration_set_subscription_name , Ptr <struct _pulsar_table_view_configuration> -> CString -> IO ()
#ccall pulsar_table_view_configuration_get_subscription_name , Ptr <struct _pulsar_table_view_configuration> -> IO CString
