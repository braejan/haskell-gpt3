module OpenAI.API.V1.Completion.ResponseTest where

import Data.Aeson
import Data.ByteString.Lazy (ByteString)
import Data.Text(pack)
import GHC.Generics
import Test.Tasty (TestTree, testGroup)
import Test.Tasty.HUnit (assertEqual, testCase, assertBool)
import OpenAI.API.V1.Completion.Response(Response(..))
import qualified Data.ByteString.Lazy.Char8 as BS
import Data.Maybe (fromMaybe)
import Data.Either (isLeft)
import OpenAI.API.V1.Completion.ChoiceTest(createDefaultChoice, createEmptyChoice)
import OpenAI.API.V1.Completion.UsageTest(createDefaultUsage, createEmptyUsage)
import OpenAI.API.V1.Completion.Choice (Choice)
import OpenAI.API.V1.Completion.Usage (Usage)

jsonString :: String
jsonString = "{\"id\":\"cmpl-GERzeJQ4lvqPk8SkZu4XMIuR\",\"object\":\"text_completion\",\"created\":1586839808,\"model\":\"text-davinci:003\",\"choices\":[{\"text\":\"This is indeed a test\",\"index\":0,\"logprobs\":null,\"finish_reason\":\"length\"}],\"usage\":{\"prompt_tokens\":5,\"completion_tokens\":7,\"total_tokens\":12}}"

-- Test suite definition
allResponseTest :: TestTree
allResponseTest =
  testGroup "Test suite for Module openai-types: Response"
    [ testSerializationAnDeserialization,
      testStringSerialization,
      testEmptyStringSerialization,
      testDeSerialization
    ]

-- Test case 1:
testSerializationAnDeserialization :: TestTree
testSerializationAnDeserialization =
  testCase "Serialize and deserialize a Response JSON" $ do
    let expected = createDefaultResponse
        json = encode expected
        response' = decode json
    assertEqual "1=>Deserialized value should match original value" (Just expected) response'

-- Test case 2:
testStringSerialization :: TestTree
testStringSerialization = testCase "Serialization of String value" $ do
  let json = BS.pack jsonString
      expected = Right createDefaultResponse
      actual = eitherDecode json :: Either String Response
  assertEqual "2=>Parsed value should match expected value" expected actual

-- Test case 3:
testEmptyStringSerialization :: TestTree
testEmptyStringSerialization = testCase "Serialization of a Empty string value" $ do
  let json = BS.pack ""
      actual = eitherDecode json :: Either String Response
  assertBool "3=>Parsed value should match expected value" (isLeft actual)


-- Test case 4:
testDeSerialization :: TestTree
testDeSerialization = testCase "Deserialization of a default Response test to String." $ do
  let expected = BS.pack jsonString
  let response = createDefaultResponse
  let actual = encode response
  assertEqual "4=>Parsed value should match expected value" expected actual


createDefaultResponse :: Response
createDefaultResponse = 
  Response (pack "cmpl-GERzeJQ4lvqPk8SkZu4XMIuR") (pack "text_completion") 1586839808 (pack "text-davinci:003") [createDefaultChoice] createDefaultUsage


createEmptyResponse :: Response
createEmptyResponse = 
  Response (pack "") (pack "") 0 (pack "") [createEmptyChoice] createEmptyUsage