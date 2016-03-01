//
//  UserDetailViewController.swift
//  Twitter
//
//  Created by Abby  Bassie on 2/28/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit



class UserDetailViewController: UIViewController {

    @IBOutlet weak var bannerLabel: UIImageView!
    
    @IBOutlet weak var thumbImageView: UIImageView!
    
    @IBOutlet weak var userLabel: UILabel!
    
    
    @IBOutlet weak var followersCount: UILabel!
    
    @IBOutlet weak var followingCount: UILabel!
    
    
    @IBOutlet weak var tweetsCount: UILabel!
    
    var tweet: Tweet!
    
    var indexPath: NSIndexPath!
    
    var delegate: TweetDelegate?
    var dataSource: TweetDataSource?

    var user: User! {
        didSet {
            navigationItem.title = user.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        thumbImageView.setImageWithURL((tweet?.user.profileImageURL)!)
        followersCount.text = "\((tweet?.user.followersCount)!)"
        followingCount.text = "\((tweet?.user.followingCount)!)"
        tweetsCount.text = "\((tweet?.user.tweetCount)!)"
        userLabel.text = tweet.user.name
        bannerLabel.setImageWithURL((tweet?.user.bannerImageURL)!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
