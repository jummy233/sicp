module Kyu5.Beeramid where
import           Test.Hspec

beeramid :: Double -> Double -> Int
beeramid bonus price
  | bonus < price && bonus < 0  = 0
  | otherwise = length
  $ takeWhile (<= bonus / price) (scanl (\acc y -> acc + y^2) 1 [2..])


-- testing --------------------------------------------------------------------
-- `spec` of type `Spec` must exist
spec :: Spec
spec = do
  it "finds the levels" $ do
    beeramid 9    2   `shouldBe` 1
    beeramid 10   2   `shouldBe` 2
    beeramid 11   2   `shouldBe` 2
    beeramid 21   1.5 `shouldBe` 3
    beeramid 454  5   `shouldBe` 5
    beeramid 455  5   `shouldBe` 6
    beeramid 4    4   `shouldBe` 1
    beeramid 3    4   `shouldBe` 0
    beeramid 0    4   `shouldBe` 0
    beeramid (-1) 4   `shouldBe` 0

-- the following line is optional for 8.2
main = hspec spec
