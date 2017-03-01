//
//  TweetCell.swift
//  TwitterDemo
//
//  Created by Thuan Nguyen on 2/26/17.
//  Copyright © 2017 Thuan Nguyen. All rights reserved.
//

import UIKit

protocol TweetTableViewCellDelegate: class  {
    func profileImageViewTapped(cell: TweetCell, user: User)
}
class TweetCell: UITableViewCell {

    @IBOutlet weak var likeImage: UIButton!
    @IBOutlet weak var retweetCount: UILabel!
    
    @IBOutlet weak var avatarImage: UIImageView! {
        didSet{
            self.avatarImage.isUserInteractionEnabled = true //make sure this is enabled
            //tap for userImageView
            let userProfileTap = UITapGestureRecognizer(target: self, action: #selector(userProfileTapped(_:)))
            self.avatarImage.addGestureRecognizer(userProfileTap)
            
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    weak var delegate: TweetTableViewCellDelegate!
    var tweet: Tweet!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatarImage.layer.cornerRadius = 5
        avatarImage.clipsToBounds
            = true
    }
    func userProfileTapped(_ gesture: UITapGestureRecognizer){
        if let delegate = delegate{
            delegate.profileImageViewTapped(cell: self, user: self.tweet.user!)
        }
    }
    

    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
