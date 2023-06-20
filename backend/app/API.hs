{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}

module API (HELLO, ITEM, LIST, MyRequest, extractReq) where

import Servant
import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics (Generic)

type HELLO = "hello" :> Get '[PlainText] String

type ITEM = "item" :> Get '[JSON] [String]

type LIST = "list" :> ReqBody '[JSON] MyRequest :> Post '[PlainText] String

newtype MyRequest = MyRequest
  { input :: String
  }
  deriving (Generic, FromJSON, ToJSON)

extractReq :: MyRequest -> String
extractReq = input


