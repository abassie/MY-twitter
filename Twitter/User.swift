//
//  User.swift
//  Twitter
//
//  Created by Abby  Bassie on 2/15/16.
//  Copyright © 2016 codepath. All rights reserved.
// current user ID stored in NSUser defaults

//adding code Chase used in coordinators to this file!!

import UIKit

//because we don't have class or type variables
var _currentUser: User?
let currentUserKey = "currentUser"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"


class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageURL: NSURL?
    var tagline: String?
    var dictionary: NSDictionary?
    var tweetCount: Int?
    var followersCount: Int?
    var followingCount: Int?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        //if let imageURL = dictionary["profile_image_url_https"] as? String {
            //profileImageURL = NSURL(string: url)
        
        let profileString = dictionary["profile_image_url_https"] as? String
        
        if let profileString = profileString{
            profileImageURL = NSURL(string: profileString)
        }
        tagline = dictionary["description"] as? String
        tweetCount = dictionary["statuses_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        followersCount = dictionary["followers_count"] as? Int
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        //NSNotification used to send out broadcasts for global events, like user login/logout
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
        //logged out or just booted up
            let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
            if data != nil {
        let dictionary: NSDictionary?
                do {
            try dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
            _currentUser = User(dictionary: dictionary!)
                } catch {
        print(error)
        }
       
        }
        }
        return _currentUser
        }
        
        set(user) {
        _currentUser = user
        //User need to implement NSCoding; but, JSON also serialized by default
        if let _ = _currentUser {
        var data: NSData?
        do {
        try data = NSJSONSerialization.dataWithJSONObject(user!.dictionary!, options: .PrettyPrinted)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
    } catch {
        print(error)
        }
        } else {
            NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
        }
    }

}