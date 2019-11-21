--------------------------------------------------------------------------------

{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

--------------------------------------------------------------------------------

module Main (main) where

--------------------------------------------------------------------------------

import           SFD

--------------------------------------------------------------------------------

import           Prelude
import           Test.Tasty
import           Test.Tasty.HUnit
import           Test.Tasty.QuickCheck as QC

--------------------------------------------------------------------------------

main :: IO ()
main = defaultMain tests

tests :: TestTree
tests = testGroup "SFD"
  [ unitTests
  , properties
  ]

--------------------------------------------------------------------------------

unitTests :: TestTree
unitTests
  = testGroup "Unit tests"
  [ testCase "transform CAT into DOG" $
    flap "CAT" [1, 13, 27] @?= "DOG"

  , testCase "calculate rotations from CAT to DOG" $
    rotations "CAT" "DOG" @?= [1, 13, 27]

  , testCase "transform KBP/TLV into KBP/FUE" $
    flap "PS 0779   18:55    TEL-AVIV         B7    ON TIME"
    [ 7, 52, 49, 33, 47, 0, 52, 30, 0, 0, 0, 52, 2, 51, 52, 5, 0, 0, 0, 40, 30
    , 31, 38, 42, 18, 30, 24, 4, 6, 1, 51, 37, 26, 0, 0, 0, 53, 49, 6, 0, 0, 0
    , 0, 0, 0, 0, 0, 0, 0
    ] @?= "WX XXXX   16:20    FUERTEVENTURA    A1    ON TIME"

  , testCase "calculate rotations from KBP/TLV to KBP/FUE" $
    rotations
    "PS 0779   18:55    TEL-AVIV         B7    ON TIME"
    "WX XXXX   16:20    FUERTEVENTURA    A1    ON TIME" @?=
    [ 7, 52, 49, 33, 47, 0, 52, 30, 0, 0, 0, 52, 2, 51, 52, 5, 0, 0, 0, 40, 30
    , 31, 38, 42, 18, 30, 24, 4, 6, 1, 51, 37, 26, 0, 0, 0, 53, 49, 6, 0, 0, 0
    , 0, 0, 0, 0, 0, 0, 0
    ]
  ]

--------------------------------------------------------------------------------

properties :: TestTree
properties
  = testGroup "Properties"
  [ QC.testProperty "flap input (rotations input target) == target" $ \d ->
      flap (flapInput d) (rotations (flapInput d) (flapTarget d)) == flapTarget d
  ]

data FlapData = FlapData
 { flapInput  :: String
 , flapTarget :: String
 } deriving (Show, Eq)

instance Arbitrary FlapData where
  arbitrary = sized $ \n -> FlapData <$> strGen n <*> strGen n
    where strGen n = vectorOf n (elements alphabet)

--------------------------------------------------------------------------------
