{-# LANGUAGE DataKinds #-}

module Server (hello, getItem, storeList) where

import Servant
import API 

hello :: Server HELLO
hello = return "Where is my playstation 5"

getItem :: Server ITEM
getItem = getHandler

storeList :: Server LIST
storeList = storeHandler

getHandler :: Handler [String]
getHandler = do
  -- Handle the GET request and return a response
  let items = ["Item 1", "Item 2", "Item 3"]
  return items


storeHandler :: MyRequest -> Handler String
storeHandler req = return ("Received input: " ++ extractReq req)


