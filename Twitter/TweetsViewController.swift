//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Abby  Bassie on 2/17/16.
//  Copyright © 2016 codepath. All rights reserved.
// Structure for this code from Chase McCoy

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    // MAY BE INTERFERING 
    var tweets: [Tweet]?
    var tweetsDataSource = TweetsDataSource()
    var delegate: TweetDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //These protocols tell software that tableview is managed by this view controller; connects storyboard to this code
        tableView.delegate = self
        tableView.dataSource = self
       
        
        //must use Singleton here to access keys stored in TwitterClient
        //COULD USE TO CREATE TWEETS LIST 
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //initializing the protocols allows us to use this code
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
        
        return 0
        }
        
    }
    

 
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.tweet = tweets![indexPath.row]
        
        return cell
    }
    
    func getIndexPathForTappedObject(sender: AnyObject) -> NSIndexPath? {
        let buttonPosition = sender.convertPoint(CGPointZero, toView: tableView)
        return tableView.indexPathForRowAtPoint(buttonPosition)
    }
    
    func getTweetForTappedObject(sender: AnyObject) -> Tweet? {
        return tweetsDataSource.tweetForIndex(getIndexPathForTappedObject(sender)!)
    }
    
    //not opening user profile page
    func tappedUserImageView(sender: UITapGestureRecognizer) {
        let tappedPoint = sender.locationInView(tableView)
        let indexPath = tableView.indexPathForRowAtPoint(tappedPoint)
        let user = tweetsDataSource.tweets![(indexPath?.row)!].user
        delegate?.userImageViewPressed(user)
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }

    @IBAction func newTweetBtnPressed(sender: UIBarButtonItem) {
        delegate?.newTweetButtonPressed()
    }
    
    //An error occurs when these buttons are pressed
    @IBAction func likeBtnPressed(sender: AnyObject) {
        let tweet = getTweetForTappedObject(sender)!
        delegate?.tweetWasLiked(tweet.id, completion: { (tweet) -> () in
            self.tweetsDataSource.tweets![self.getIndexPathForTappedObject(sender)!.row].liked = true
            self.tableView.reloadData()
        })
    }
    
    //An error occurs when these buttons are pressed
    @IBAction func rtBtnPressed(sender: AnyObject) {
        let tweet = getTweetForTappedObject(sender)!
        delegate?.tweetWasRetweeted(tweet.id, completion: { (tweet) -> () in
            self.tweetsDataSource.tweets![self.getIndexPathForTappedObject(sender)!.row].retweeted = true
            self.tableView.reloadData()
        })
    }
    
    func tappedThumbImageView(sender: UITapGestureRecognizer) {
        let tappedPoint = sender.locationInView(tableView)
        let indexPath = tableView.indexPathForRowAtPoint(tappedPoint)
        let user = tweetsDataSource.tweets![(indexPath?.row)!].user
        delegate?.userImageViewPressed(user)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TweetDetailView" {
            
           
            //when we click in the white space in the cell, the segue will be activated
            let cell = sender as! TweetCell
            let tweet = cell.tweet
            
             //use this subclass of UIViewcontroller so we can access tweet properties
            let destinationViewController = segue.destinationViewController as! TweetDetailViewController
            destinationViewController.tweet = tweet
         
        }
    }
    
}
