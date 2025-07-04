
{-# LANGUAGE OverloadedStrings #-}

module API 
  ( valToNumber
  , winInnerWidth
  , winInnerHeight
  , myNewWebGLRenderer
  , appendInBody
  ) where

import Control.Monad (void)
import Control.Lens hiding ((#))
import Language.Javascript.JSaddle as JS

import THREE.Internal hiding ((^.))
import THREE.PointLight
import THREE.WebGLRenderer

instance FromJSVal PointLight where
  fromJSVal = pure . Just . PointLight

appendInBody :: JSVal -> JSM ()
appendInBody v = void $ jsg "document" ^. js "body" ^. js1 "appendChild" v

winInnerWidth :: JSM Double
winInnerWidth = valToNumber =<< jsg "window"  ^. js "innerWidth"

winInnerHeight :: JSM Double
winInnerHeight = valToNumber =<< jsg "window"  ^. js "innerHeight"

myNewWebGLRenderer :: JSVal -> THREE.Internal.Three WebGLRenderer
myNewWebGLRenderer canvasId = do
  o <- obj
  setProp "canvas" canvasId o
  THREE.Internal.new WebGLRenderer "WebGLRenderer" o

