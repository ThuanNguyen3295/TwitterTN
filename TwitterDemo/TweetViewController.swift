//
//  TweetViewController.swift
//  TwitterDemo
//
//  Created by Thuan Nguyen on 2/25/17.
//  Copyright © 2017 Thuan Nguyen. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TweetTableViewCellDelegate{
   
    
    var tweets: [Tweet]!

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
           refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)

        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.delegate = self
            self.tableView.dataSource = self
             self.tableView.reloadData()
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
    }
        func refreshControlAction(_ refreshControl: UIRefreshControl) {
            
           // let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
            
            TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
                self.tweets = tweets
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
                tableView.reloadData()
                refreshControl.endRefreshing()
        }
      
        
        
        

        // Do any additional setup after loading the view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.delegate = self
        let tweet = tweets[indexPath.row]
        cell.tweet = tweet
            
        cell.tweetLabel.text = tweet.text
        cell.nameLabel.text = tweet.name
        cell.retweetCount.text  = String(tweet.retweetCount)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        cell.timeLabel.text = dateFormatter.string(from: tweet.timestamp)
        cell.selectionStyle = .none
        cell.likeLabel.text = String(tweet.favoritesCount)
        if let imageURL = tweet.imageURL{
        cell.avatarImage.setImageWith(imageURL as URL)
            
        cell.tableView = self.tableView            
        }
        
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButton(_ sender: Any) {
     TwitterClient.sharedInstance?.logout()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    
    func profileImageViewTapped(cell: TweetCell, user: User) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let OUservc = storyboard.instantiateViewController(withIdentifier: "OUsersViewController") as? OUsersViewController{
            OUservc.user = user //set the profile user before your push
            self.navigationController?.pushViewController(OUservc, animated: true)
        }
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
