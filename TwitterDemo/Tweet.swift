//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Thuan Nguyen on 2/21/17.
//  Copyright © 2017 Thuan Nguyen. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: String?
    var timestamp: Date
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var name: String?
    var user: User?
    var imageURL: NSURL?
    
    var id_str: String?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int ) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int ) ?? 0
        if let userData = dictionary["user"] as? NSDictionary {
            user = User(dictionary: userData)
        }
        name = user?.name
        id_str = dictionary["id_str"] as? String
        
       imageURL = user?.profileURL
        
        let timestampString = dictionary["created_at"] as? String
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString!)!
        
        
    }
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets =  [Tweet]()
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
    

}
