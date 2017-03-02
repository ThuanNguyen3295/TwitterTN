//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Thuan Nguyen on 2/25/17.
//  Copyright © 2017 Thuan Nguyen. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
class TwitterClient: BDBOAuth1SessionManager {
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "jAbULpwEpvtpVXaDkVUsG9fSQ", consumerSecret: "3ZpJlAzyFGlzx4Hnn9HL6R9u835f6fgQYdDHyHcNmYrWFR7lKS")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?

    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()){
        loginSuccess = success
        loginFailure = failure
        deauthorize()
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "tntwitterdemo://oauth") as URL!, scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")
            UIApplication.shared.openURL((url as? URL)!)
            
        }, failure: { (error: Error?) in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        })
    }
    func tweetStatus(status: String, success: ()->(), failure: (Error) -> ()){
        post("1.1/statuses/update.json?status=\(status)", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, respone: Any) in
        }) { (task: URLSessionDataTask?, error: Error) in
        print(error.localizedDescription)
        }
    
    }
    
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserDidLogout"), object: nil)
    }
    
    func handleOpenURL(url: NSURL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) -> Void in
            
            self.currentAccount(success: { (user: User) in
                User.currentUser = user
                print("saved")
                self.loginSuccess?()

            }, failure: { (error: Error) in
                self.loginFailure?(error)
            })
            
        }, failure: { (error: Error?) in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        })
    }
    
    
    
    
    func homeTimeline(success: @escaping ([Tweet])-> (), failure: @escaping (Error) -> ()){
    
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task:URLSessionDataTask?, response: Any?) in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
        
            success(tweets)
            
        }, failure: { (task: URLSessionDataTask?, error: Error?) in
            failure(error!)
        })
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: (Error) -> ()){
        
       get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            print("Account: \(response)")
            let userDictionary = response as! NSDictionary
            let user = User.init(dictionary: userDictionary)
           success(user)
        }
            , failure: { (task: URLSessionDataTask?, error: Error) in
                self.loginFailure?(error)
                
        })
    
    }
    func retweet (id: String?, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()){
        post("1.1/statuses/retweet/\(id!).json", parameters:
            nil, progress: nil, success: { (task: URLSessionDataTask, response: Any) in
                let tweetDictionary = response as! NSDictionary
                let tweet = Tweet.init(dictionary: tweetDictionary)
                success(tweet)
        }) { (task: URLSessionDataTask?, error: Error) in
            print(error.localizedDescription)
        }
          }
    
    func likeTweet (id: String?, success: @escaping (Bool) -> (), failure: @escaping (Error) -> ()) {
        post("1.1/favorites/create.json?id=\(id!)", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, Any) in
             success(true)
        }) { (task: URLSessionDataTask?, error: Error) in
            print("Error \(error.localizedDescription)")
            failure(error)
        }
    }
}
