//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Abby  Bassie on 2/17/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //These protocols tell software that tableview is managed by this view controller; connects storyboard to this code
        tableView.delegate = self
        tableView.dataSource = self
       
        // Do any additional setup after loading the view.
        //must use Singleton here to access keys stored in TwitterClient
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            //tweet.favorite here will do a post instead of get
            
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
    
    func getIndex(sender: AnyObject) -> NSIndexPath? {
        let buttonPosition = sender.convertPoint(CGPointZero, toView: tableView)
        return tableView.indexPathForRowAtPoint(buttonPosition)
    }
    

    
 
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.tweet = tweets![indexPath.row]
        
        return cell
    }
    
    
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
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
