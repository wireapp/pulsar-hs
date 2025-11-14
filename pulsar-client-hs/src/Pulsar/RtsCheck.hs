module Pulsar.RtsCheck where

import Control.Concurrent (rtsSupportsBoundThreads)
import Control.Monad (unless)
import System.Exit (exitFailure)
import System.IO (hPutStrLn, stderr)

-- | Checks if the program is running with the threaded RTS.
--
-- If not, prints an error message and exits with failure.
checkThreadedRTS :: IO ()
checkThreadedRTS = do
  unless rtsSupportsBoundThreads $ do
    hPutStrLn stderr "Error: pulsar-client-hs requires the -threaded RTS."
    exitFailure
