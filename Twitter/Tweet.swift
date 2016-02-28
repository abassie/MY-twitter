//
//  Tweet.swift
//  Twitter
//
//  Created by Abby  Bassie on 2/15/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var dictionary: NSDictionary
    var favoritesCount: Int?
    var retweetCount: Int?
    var liked: Bool
    var retweeted: Bool
    var id: String
    
    //dictionary is initialized; we get data from dictionary
    init(dictionary: NSDictionary) {
        
        self.dictionary = dictionary
        
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
        favoritesCount = dictionary["favorite_count"] as? Int
        retweetCount = dictionary["retweet_count"] as? Int
        liked = dictionary["favorited"] as! Bool
        retweeted = dictionary["retweeted"] as! Bool
        
        id = dictionary["id_str"] as! String
        
        
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            
            //for each dictionary in array of dictionary, get tweet
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
    
}
