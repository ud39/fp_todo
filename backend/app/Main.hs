{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

import Network.Wai.Handler.Warp
import Servant

import API
import Server
import Database

type CombinedAPI = HELLO :<|> ITEM :<|> LIST

combinedAPI :: Proxy CombinedAPI
combinedAPI = Proxy

app :: Application
app = serve combinedAPI server

server :: Server CombinedAPI
server = hello :<|> getItem :<|> storeList

main :: IO ()
main = do
    Database.connectToDatabase
    run 8080 app

