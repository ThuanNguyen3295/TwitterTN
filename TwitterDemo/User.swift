//
//  User.swift
//  TwitterDemo
//
//  Created by Thuan Nguyen on 2/21/17.
//  Copyright © 2017 Thuan Nguyen. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class User: NSObject {
    var name: String?
    var screenName: String?
    var profileURL: NSURL?
    var tagline: String?
    var dictionary: NSDictionary?
    var joinedDate: String?
    var tweetCount: Int?
    var likeCount: Int?
    var followingCount: Int?
    var followersCount: Int?
    var backgroundImageURL: NSURL?
        
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        tagline = dictionary["description"] as? String
        let profileURLString = dictionary["profile_image_url_https"] as? NSString
        if let profileURLString = profileURLString {
            profileURL = NSURL(string: profileURLString as String)
        }
        joinedDate = dictionary["created_at"] as? String
        tweetCount = dictionary["statuses_count"] as? Int
        likeCount = dictionary["favourites_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        followersCount = dictionary["followers_count"] as? Int
        
        let backgroundImageURLString = dictionary["profile_banner_url"] as? String
        if let backgroundImageURLString = backgroundImageURLString {
            backgroundImageURL = NSURL(string: backgroundImageURLString as String)
        }
        
    }
    static var _currentUser: User?
    
    class var currentUser: User? {
        get{
            if _currentUser == nil {
            let defaults = UserDefaults.standard
            let userData = defaults.object(forKey: "currentUserData") as? NSData
            
            if let userData = userData {
            let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
                return _currentUser
            }
        set(user) {
            _currentUser = user
            let defaults = UserDefaults.standard
            if  let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
                print("setting")
            }
            else {
                defaults.set(nil, forKey: "currentUserData")

            }
            defaults.synchronize()
        }
        
    }
    
}
