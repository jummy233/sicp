-- <Ones and Zeros>
module Kyu7.OnesAndZeros (toNumber) where
import Test.Hspec
import Test.QuickCheck


-- 2019-11-18
-----------------------------------------------
-- first version
-----------------------------------------------
toNumber' :: [Int] -> Int
toNumber' list =
  let rl = reverse list
      go sum exp (x:xs) =
        if x == 0
           then go sum (exp + 1) xs
        else go (sum + 2^exp) (exp + 1) xs
      go sum _ [] = sum
   in go 0 0 rl

-- whenever got a sum as accumulatory try to use fold

-----------------------------------------------
-- Good practise
-----------------------------------------------
toNumber :: [Int] -> Int
toNumber = foldl f 0
  where f acc n = 2*acc + n

-- NOTE:
-- Say we have [a, b, c]
-- think foldl as:
-- (f (f (f 0 a)
--    b)
--  c)

-- foldr:
-- (f a
--   (f b
--     (f c 0)))

-- Lazy eval, so the outmost expression will be evaluated first.
-- This is also why we don't need reverse.

-----------------------------------------------
-- side notes
-----------------------------------------------
-- NOTE:
-- foldl avoid thunk generated by lazy eval,
-- save some stack space when processing long list.

foldl'' _ z [] = z
foldl'' f z (x:xs) =
  let z' = f z x
   in seq z' $ foldl'' f z' xs  -- seq a -> b -> b will reduce a then return b

-- NOTE:
-- foldr is better for f that is lazy on the second arg.
-- foldl will not start to eval till reach the end of the list, create huge thunk.

-- testing --------------------------------------------------------------------

spec :: Spec
spec =
  it "example tests" $ do
    toNumber [0, 0, 0, 1] `shouldBe` 1
    toNumber [0, 0, 1, 0] `shouldBe` 2
    toNumber [1, 1, 1, 1] `shouldBe` 15
    toNumber [0, 1, 1, 0] `shouldBe` 6
