{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}

module Database where

import Database.PostgreSQL.Simple


localPG :: ConnectInfo
localPG = defaultConnectInfo
        { connectHost = "localhost"
        , connectDatabase = "todo"
        , connectUser = "jutiboottawong"
        , connectPassword = ""
        }


test :: IO ()
test = do
  conn <- connect localPG
  putStrLn "Connected to PostgreSQL database"
  close conn
