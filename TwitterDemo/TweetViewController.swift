//
//  TweetViewController.swift
//  TwitterDemo
//
//  Created by Thuan Nguyen on 2/25/17.
//  Copyright © 2017 Thuan Nguyen. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    var tweets: [Tweet]!

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.delegate = self
            self.tableView.dataSource = self
             self.tableView.reloadData()
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
       

        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        let tweet = tweets[indexPath.row] as! Tweet
        cell.tweetLabel.text = tweet.text
        cell.nameLabel.text = tweet.name
        cell.retweetCount.text  = String(tweet.retweetCount)
       // cell.timeLabel.text = tweet.timestamp as? String
        return cell
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButton(_ sender: Any) {
     TwitterClient.sharedInstance?.logout()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
