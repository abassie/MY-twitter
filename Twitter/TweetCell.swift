//
//  TweetCell.swift
//  Twitter
//
//  Created by Abby  Bassie on 2/20/16.
//  Copyright © 2016 codepath. All rights reserved.
// HUGE thanks to Chase McCoy for helping me get this portion of the project working!

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var tweetLabel: UILabel!
    
    
    @IBOutlet weak var likeBtn: UIButton!
    
    @IBOutlet weak var rtBtn: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var rtCountLabel: UILabel!
    
    let dateFormatter: NSDateFormatter = {
        let format = NSDateFormatter()
        format.dateFormat = "h:mm"
        return format
    }()
    
    var indexPath: NSIndexPath!
    
    var tweet: Tweet! {
        didSet {
            //ask Chase about this syntax
            userLabel.text = tweet.user.name
            tweetLabel.text = tweet?.text
            thumbImageView.setImageWithURL((tweet?.user.profileImageURL)!)
            dateLabel.text = dateFormatter.stringFromDate((tweet?.createdAt)!)
            
            rtCountLabel.text = "\((tweet.retweetCount)!)"
            likeLabel.text = "\((tweet.favoritesCount)!)"
            
            setBtnStates()
            
        }
    }
    
    @IBAction func likeBtnPressed(sender: AnyObject) {
        self.tweet.liked = true
        self.tweet.favoritesCount! += 1
        self.likeLabel.text = "\((self.tweet.favoritesCount)!)"
        self.setBtnStates()
        
        
    }
    
    
    @IBAction func rtBtnPressed(sender: AnyObject) {
        
        
        self.tweet.retweeted = true
        self.tweet.retweetCount! += 1
        self.rtCountLabel.text = "\((self.tweet.retweetCount)!)"
        self.setBtnStates()
        
    }
    
    
    
    func setBtnStates() {
        if let retweeted = tweet?.retweeted {
            if retweeted {
                rtBtn.setBackgroundImage(UIImage(named: "rt_on"), forState: .Normal)
                rtBtn.enabled = false
            }
            else {
                rtBtn.setBackgroundImage(UIImage(named: "rt_off"), forState: .Normal)
                rtBtn.enabled = true
            }
            
        }
    
    
    if let liked = tweet?.liked {
        if liked {
            likeBtn.setBackgroundImage(UIImage(named: "like_on"), forState: .Normal)
            likeBtn.enabled = false
        }
        else {
            likeBtn.setBackgroundImage(UIImage(named: "like_off"), forState: .Normal)
            likeBtn.enabled = true
        }
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        rtBtn.setBackgroundImage(UIImage(named: "rt_on"), forState: .Disabled)
        likeBtn.setBackgroundImage(UIImage(named: "like_on"), forState: .Disabled)
    }
    
    func tappedUserImageView() {
        
    }
    
    override func prepareForReuse() {
        thumbImageView.image = nil
        setBtnStates()
    }
}