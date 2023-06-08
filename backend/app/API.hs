{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module API (API) where

import Servant

type API = "hello" :> Get '[PlainText] String

