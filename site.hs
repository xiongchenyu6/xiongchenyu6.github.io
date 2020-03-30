--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Default                   ( def )
import           Hakyll
import           Data.Eq
import           Control.Arrow

--------------------------------------------------------------------------------
main :: IO ()
main = hakyllWith config $ do
  match "static/css/*.hs" $ do
    route $ setExtension "css"
    compile $ getResourceString >>= withItemBody (unixFilter "stack" ["runghc"])

  match "static/*/*" $ do
    route idRoute
    compile copyFileCompiler

  match "posts/generated/*" $ do
    route idRoute
    compile copyFileCompiler

  match (fromList ["about.md", "contact.markdown"]) $ do
    route $ setExtension "html"
    compile
      $   pandocCompiler
      >>= loadAndApplyTemplate "templates/page.html"    siteCtx
      >>= loadAndApplyTemplate "templates/default.html" siteCtx
      >>= relativizeUrls

  tags <- buildTags "posts/*" (fromCapture "tags/*.html")

  tagsRules tags $ \tag pattern -> do
    let desc = "Posts tagged \"" ++ tag ++ "\""
    route idRoute
    compile $ do
      posts <- recentFirst =<< loadAll pattern
      let ctx =
            constField "title" tag
              <> listField "posts" (postCtx tags) (return posts)
              <> constField "desc" desc
              <> siteCtx

      makeItem ""
        >>= loadAndApplyTemplate "templates/archive.html" ctx
        >>= loadAndApplyTemplate "templates/default.html" ctx
        >>= relativizeUrls

  match "posts/*" $ do
    route $ setExtension "html"
    compile
      $   pandocCompiler
      >>= loadAndApplyTemplate "templates/post.html"    (postCtx tags)
      >>= loadAndApplyTemplate "templates/default.html" (postCtx tags)
      >>= relativizeUrls

  create ["archive.html"] $ do
    route idRoute
    compile $ do
      posts <- recentFirst =<< loadAll "posts/*"
      let archiveCtx =
            listField "posts" (postCtx tags) (return posts)
              <> constField "title" "Archives"
              <> constField "desc" "Here you can find all my previous posts:"
              <> siteCtx

      makeItem ""
        >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
        >>= loadAndApplyTemplate "templates/default.html" archiveCtx
        >>= relativizeUrls

  match "index.html" $ do
    route idRoute
    compile $ do
      posts <- recentFirst =<< loadAll "posts/*"
      let indexCtx =
            listField "posts" (postCtx tags) (return posts)
              <> field "tags" (\_ -> renderTagList tags)
              <> constField "title" "Home"
              <> siteCtx

      getResourceBody
        >>= applyAsTemplate indexCtx
        >>= loadAndApplyTemplate "templates/default.html" indexCtx
        >>= relativizeUrls

  match "templates/*" $ compile templateBodyCompiler

--------------------------------------------------------------------------------
postCtx :: Tags -> Context String
postCtx tags = tagsField "tags" tags <> dateField "date" "%B %e, %Y" <> siteCtx

siteCtx :: Context String
siteCtx =
  constField "baseurl" ""
    <> constField "twitter_username" "xiongchenyu"
    <> constField "github_username"  "xiongchenyu6"
    <> constField "site_description" "My persion website"
    <> defaultContext

config :: Configuration
config = def
  { deployCommand =
    "git branch -D master; git subtree split --prefix _site -b master;git push -f origin master:master"
  , inMemoryCache = True
  }
