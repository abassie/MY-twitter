//
//  TwitterClient.swift
//  Twitter
//
//  Created by Abby  Bassie on 2/15/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
import AFNetworking


//These keys will be used throughout the class
let twitterConsumerKey = "m5o4zxZYBuHSqJ5SIEwdPDH9c"
let twitterConsumerSecret = "CbeunXt7TAl505ruKL4YWVLP6tFffeP33ep9bkEsbzXx489yhK"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {

    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
//Init method () instantiates objects
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        //statics always return the same object
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) ->  ()) {
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: NSURLSessionDataTask, response: AnyObject!) -> Void in
            //print("home timeline: \(response)")
            
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)
            
            for tweet in tweets {
                print("text: \(tweet.text), created: \(tweet.createdAt)")
            }
            
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("error getting home timeline!")
                completion(tweets: nil, error: error)
        })
        
    }
    
    
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        
        //Fetch request token & redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemoAbby://oauth"), scope: nil, success: {(requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the request token!")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            //opens URL where we authorize the app
            UIApplication.sharedApplication().openURL(authURL!)
            
            },
            failure: {(error: NSError!) -> Void in
                print("Failed to get request token.")
                self.loginCompletion?(user: nil, error: error)
                
        })
    }
    
        func openURL(url: NSURL) {
            fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: {(accessToken: BDBOAuth1Credential!) -> Void in
                print("Got the access token!")
                TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
                
                //acn exchange this key for "1.1/directmessages..." and direct messages will be shown
                TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: NSURLSessionDataTask!, response: AnyObject!) -> Void in
                    //print("user: \(response)")
                    
                    
                    var user = User(dictionary: response as! NSDictionary)
                    User.currentUser = user
                    print("user: \(user.name)")
                    self.loginCompletion?(user: user, error: nil)
                    }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                        print("error getting current user")
                        //tells the login that something went wrong
                        self.loginCompletion?(user: nil, error: error)
                })
                
           
                
                }, failure: {(error: NSError!) -> Void in
                    print("Failed to receieve access token.")
                    self.loginCompletion?(user: nil, error: error)
            })
            

            
        }
    
    //These fxns are from Chase McCoy.
    //this func is used in tweetdetailviewcontroller
    func favoriteTweetWithID(id: String, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        POST("1.1/favorites/create.json?id=\(id)",
            parameters: nil,
            constructingBodyWithBlock: nil,
            success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                let tweet = Tweet(dictionary: response as! NSDictionary)
                completion(tweet: tweet, error: nil)
            },
            failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                completion(tweet: nil, error: error)
        })
    }
    
    func retweetTweetWithID(id: String, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        POST("1.1/statuses/retweet/\(id).json",
            parameters: nil,
            constructingBodyWithBlock: nil,
            success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                let tweet = Tweet(dictionary: response as! NSDictionary)
                completion(tweet: tweet, error: nil)
            },
            failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                completion(tweet: nil, error: error)
        })
    }

    
    //may need to add these to rtbtnpressed and likebtnpressed
    func tweetWasRetweeted(tweetID: String, completion: (tweet: Tweet) -> ()) {
        TwitterClient.sharedInstance.retweetTweetWithID(tweetID) { (tweet, error) -> () in
            if let tweet = tweet {
                completion(tweet: tweet)
            }
        }
        
    }
    
    func tweetWasLiked(tweetID: String, completion: (tweet: Tweet) -> ()) {
        TwitterClient.sharedInstance.favoriteTweetWithID(tweetID) { (tweet, error) -> () in
            if let tweet = tweet {
                completion(tweet: tweet)
            }
        }
    }
    
    func createTweetWithText(tweetText: String, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        POST("1.1/statuses/update.json",
            parameters: ["status" : tweetText],
            constructingBodyWithBlock: nil,
            success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                let tweet = Tweet(dictionary: response as! NSDictionary)
                completion(tweet: tweet, error: nil)
            },
            failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                completion(tweet: nil, error: error)
        })
    }
    
}

        
    
        
        
    

