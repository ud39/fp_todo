{-# LANGUAGE DataKinds #-}

import Network.Wai.Handler.Warp
import Servant

import API
import Server
import Database

app :: Application
app = serve (Proxy :: Proxy API) server

main :: IO ()
main = do
    Database.test
    run 8080 app



