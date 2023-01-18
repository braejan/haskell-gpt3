
# :construction: Under Development :construction:
# Welcome to the Haskell OpenAI API library!

UNOFFICIAL: This library provides a wrapper for the OpenAI API, making it easy to implement services exposed by the OpenAI API in your Haskell projects. With this library, you can perform basic query operations on the OpenAI API with just a few lines of code.

## Installation

To install this library, you'll can use [Stack](https://docs.haskellstack.org/en/stable/README/):

```bash
stack install haskell-openai
```

## Usage

To use this library, you will need an OpenAI API key. You can sign up for a free API key at the OpenAI website.
It is important to note that it is recommended to export the necessary environment variables in order to establish a successful connection to the OpenAI API.
```bash
export OPENAI_API_KEY="YOUR_API_KEY_HERE"
export OPENAI_ORGANIZATION="YOUR_OPENAI_ORGANIZATION_HERE"
```
Once you have your API key variables set up, you can use the library like this:

```haskell
module Main where
import OpenAI.API.V1.Completion.Client (createCompletion)
import OpenAI.API.V1.Completion.Request (completionRequest, Request (..))
import qualified Data.Text as T
main :: IO ()
main = do
    result <- createCompletion completionRequest{
        model = "text-davinci-003",
        prompt = Just $ Left "Say this is a test",
        maxTokens = Just 256
    }
    case result of
        Left error -> putStrLn $ T.unpack ("😰 Error: \n" <> error)
        Right response -> putStrLn $ "🫡 Response: \n" <> show response
```

![](https://lift.sonatype.com/api/badge/github.com/braejan/haskell-openai)
