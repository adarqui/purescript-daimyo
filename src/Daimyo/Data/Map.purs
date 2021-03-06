module Daimyo.Data.Map (
  toArray,
  elems,
  indices,
  filterElems,
  filterElems',
  filterIndices,
  filterIndices',
  filter,
  filter'
) where

import Prelude
import Data.Tuple
import qualified Data.List as L
import qualified Data.Map as M

import Daimyo.Data.ArrayList

-- | toArray
--
-- M.toList to an array
toArray :: forall k v. M.Map k v -> Array (Tuple k v)
toArray = listToArray <<< M.toList

-- | elems
--
elems :: forall k v. M.Map k v -> L.List v
elems = map snd <<< M.toList

-- | indices
--
indices :: forall k v. M.Map k v -> L.List k
indices = map fst <<< M.toList

-- | filterElems
--
filterElems :: forall k v. (v -> Boolean) -> M.Map k v -> L.List (Tuple k v)
filterElems f = filter (const f)

-- | filterElems'
--
filterElems' :: forall k v. (v -> Boolean) -> M.Map k v -> L.List v
filterElems' f m = map snd $ filterElems f m

-- | filterIndices
--
filterIndices :: forall k v. (k -> Boolean) -> M.Map k v -> L.List (Tuple k v)
filterIndices f = filter (\k v -> f k)

-- | filterIndices'
--
filterIndices' :: forall k v. (k -> Boolean) -> M.Map k v -> L.List v
filterIndices' f m = map snd $ filterIndices f m

-- | filter
--
filter :: forall k v. (k -> v -> Boolean) -> M.Map k v -> L.List (Tuple k v)
filter f = L.filter (uncurry f) <<< M.toList

-- | filter'
--
filter' :: forall k v. (k -> v -> Boolean) -> M.Map k v -> L.List v
filter' f m = map snd $ filter f m
