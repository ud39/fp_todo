{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}

module Database where

import qualified Data.ByteString.Char8 as BS
import Data.Maybe (fromMaybe)
import System.Environment (lookupEnv)
import Configuration.Dotenv (loadFile, defaultConfig)

import Control.Monad.Logger (runNoLoggingT)
import Control.Monad.IO.Class (liftIO)
import Database.Persist.TH
import Database.Persist.Sql
import Database.Persist.Postgresql

loadEnv :: IO ()
loadEnv = loadFile defaultConfig

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
ToDoList
    name String
    deriving Show
ToDoItem
    title String
    listId ToDoListId
    deriving Show
|]

constructConnectionString :: IO BS.ByteString
constructConnectionString = do
  host <- fromMaybe "localhost" <$> lookupEnv "HOST"
  dbname <- fromMaybe "todo" <$> lookupEnv "DBNAME"
  user <- fromMaybe "jutiboottawong" <$> lookupEnv "USER"
  password <- fromMaybe "" <$> lookupEnv "PASSWORD"
  return $ BS.pack $ "host=" ++ host ++ " dbname=" ++ dbname ++ " user=" ++ user ++ " password=" ++ password

connectToDatabase :: IO ()
connectToDatabase = do
  connectionString <- constructConnectionString
  runNoLoggingT $ withPostgresqlConn connectionString $ \conn -> do
    runSqlConn (runMigration migrateAll) conn
    liftIO $ putStrLn "Database migration completed."
    -- Perform other database operations here

