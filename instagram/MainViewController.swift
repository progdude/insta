//
//  MainViewController.swift
//  instagram
//
//  Created by Archit Rathi on 2/22/16.
//  Copyright © 2016 Archit Rathi. All rights reserved.
//

import UIKit
import Parse


class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBAction func onClick(sender: AnyObject) {
        self.performSegueWithIdentifier("picSegue", sender: nil);
        
    }
    
    var refreshControl: UIRefreshControl!
    @IBOutlet var tableView: UITableView!
    
    var posts : [PFObject]!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        let query = PFQuery(className: "UserMedia")

        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        let media = PFObject(className: "UserMedia")
        media["author"] = PFUser.currentUser()
        
        
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            
            //self.tableView.reloadData()
            if let media = media {
                
                self.posts = media
                self.tableView.reloadData()
               
            } else {
                // handle error
            }
            
        }
        
    }
    
    func delay(delay:Double, closure:()->()) {
        self.tableView.reloadData()
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
        self.tableView.reloadData()
    }
    
    func onRefresh() {
        self.tableView.reloadData()
        delay(2, closure: {
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        })
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        //self.tableView.reloadData()
        if let posts = posts {
            
            return posts.count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("imageCell", forIndexPath: indexPath) as! imageCell
        
        let post = self.posts![indexPath.row]
        //let numLikes = post["likesCount"]
        
        cell.userName.text = post["author"].username
        cell.caption.text = post["caption"] as? String
        //cell.numLikes.text = numLikes as? String
        
        let pictureFile = post["media"] as! PFFile
        
        pictureFile.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    cell.im.image = image
                }
            }
            
        }
        
        return cell
        
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData();
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
