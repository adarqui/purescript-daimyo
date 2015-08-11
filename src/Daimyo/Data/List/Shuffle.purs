module Daimyo.Data.List.Shuffle (
  shuffleEff,
  shuffleLCG_BSD,
  shuffleLCG_MS
) where

import Prelude
import Control.Monad.Eff
import Control.Monad.Eff.Random
import Control.Monad.State
import Control.Monad.State.Class
import Control.Monad.State.Trans
import Data.List
import Data.Tuple

import Daimyo.Control.Monad.List
import Daimyo.Random.LCG
import Daimyo.Random.LCG.BSD
import Daimyo.Random.LCG.MS

-- | shuffleEff
--
-- shuffle a list.
-- a pure version of this would be great but i need this asap ;f
--
-- >>> shuffleEff (Cons 1 (Cons 2 (Cons 3 Nil)))
-- Cons (2) (Cons (1) (Cons (3) (Nil)))
--
shuffleEff :: forall eff a. (Ord a) => List a -> Eff (random :: RANDOM | eff) (List a)
shuffleEff xs = (map snd <<< sort) <$> mapM (\x -> randomInt 0 99999999 >>= \i -> return $ Tuple i x) xs

-- | shuffleLCG_BSD
--
shuffleLCG_BSD :: forall a. (Ord a) => List a -> List a
shuffleLCG_BSD xs = xs

-- | shuffleLCG_MS
--
shuffleLCG_MS :: forall a. (Ord a) => Int -> List a -> List a
shuffleLCG_MS seed xs = map snd $ sort $ zip (lcgsMS seed (length xs)) xs
