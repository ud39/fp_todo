{-# LANGUAGE DataKinds #-}

import Network.Wai.Handler.Warp
import Servant

import API
import Server

app :: Application
app = serve (Proxy :: Proxy API) server

main :: IO ()
main = run 8080 app

