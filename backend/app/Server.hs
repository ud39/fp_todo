{-# LANGUAGE DataKinds #-}

module Server (server) where

import Servant

import API

server :: Server API
server = return "Hello, World!"

