{-# OPTIONS_GHC -fno-warn-unused-imports #-}
#include <bindings.dsl.h>
#include <pulsar/c/messages.h>
module Pulsar.Client.Internal.Foreign.Messages where
import Foreign.Ptr
import Pulsar.Client.Internal.Foreign.Message
#strict_import

{- typedef struct _pulsar_messages pulsar_messages_t; -}
#opaque_t struct _pulsar_messages
#synonym_t pulsar_messages_t , <struct _pulsar_messages>
#ccall pulsar_messages_size , Ptr <struct _pulsar_messages> -> IO CSize
#ccall pulsar_messages_get , Ptr <struct _pulsar_messages> -> CSize -> IO (Ptr <struct _pulsar_message>)
#ccall pulsar_messages_free , Ptr <struct _pulsar_messages> -> IO ()
