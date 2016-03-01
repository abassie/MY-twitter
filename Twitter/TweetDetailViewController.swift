//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Abby  Bassie on 2/22/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var likeBtn: UIButton!
    
    @IBOutlet weak var rtBtn: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var likeLabel: UILabel!

    @IBOutlet weak var rtCountLabel: UILabel!
    
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
    

    
    var tweet: Tweet!
    
    var indexPath: NSIndexPath!
    
    var delegate: TweetDelegate?
    var dataSource: TweetDataSource?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let dateFormatter: NSDateFormatter = {
            let format = NSDateFormatter()
            format.dateFormat = "h:mm"
            return format
        }()

        userLabel.text = tweet.user.name
        tweetLabel.text = tweet?.text
        thumbImageView.setImageWithURL((tweet?.user.profileImageURL)!)
        
        rtCountLabel.text = "\((tweet.retweetCount)!)"
        likeLabel.text = "\((tweet.favoritesCount)!)"
            dateLabel.text = dateFormatter.stringFromDate((tweet?.createdAt)!)
        
        setBtnStates()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
           //may need to delete
            rtBtn.setBackgroundImage(UIImage(named: "rt_on"), forState: .Disabled)
            likeBtn.setBackgroundImage(UIImage(named: "like_on"), forState: .Disabled)
            
            let btnTapped = UITapGestureRecognizer(target: self, action: "tappedUserImageView")
            btnTapped.numberOfTapsRequired = 1
            thumbImageView.addGestureRecognizer(btnTapped)
            
            
            // Configure the view for the selected state
        }
    }

    


