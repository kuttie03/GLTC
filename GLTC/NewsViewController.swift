//
//  NewsViewController.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 2/2/16.
//  Copyright © 2016 Darshan Labs. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var newsTableView: UITableView!
    
    var refreshControl:UIRefreshControl!
    var gltcNews: Dictionary<Int, GLTCNews> = [:]
    var imageCache = Dictionary<String,UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gltcNews = GLTCDataLoader.sharedInstance.getNews()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        initiateSWRevealController()
        initiateRefreshControl()
    }
    
    //Returns Number of Sections
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if(gltcNews.count > 0) {
            return 1
        }else{
            let messageLabel = GLTCUtil.getNoDataMessageLabel(CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
            self.newsTableView.backgroundView = messageLabel
        }
        return 0
    }
    
    //Returns number of Rows in each section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gltcNews.count
    }
    
    //Called to load each row
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let newsCell = tableView.dequeueReusableCellWithIdentifier("newsCell") as? NewsCell {
            let news = gltcNews[indexPath.row+1]
            newsCell.setNewsDate(news!.getNewsDate())
            newsCell.setNewsHeadline(news!.getNewsHeadline())
            let imageUrl = news!.getImageUrl()
            if let image = imageCache[imageUrl] {
                newsCell.newsImg.image = image
            }else{
                newsCell.newsImg.image = UIImage(named: "news")
                NSURLSession.sharedSession().dataTaskWithURL( NSURL(string:imageUrl)!, completionHandler: {
                    (data, response, error) -> Void in
                    dispatch_async(dispatch_get_main_queue()) {
                        newsCell.newsImg.contentMode =  UIViewContentMode.ScaleAspectFit
                        if let data = data {
                            newsCell.newsImg.image = UIImage(data: data)
                            self.imageCache[imageUrl] = newsCell.newsImg.image
                        }
                    }
                }).resume()
            }
            return newsCell
        }else{
            return NewsCell()
        }
    }
    
    //Called when a row is selected
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showNewsDetails", sender: indexPath.row)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showNewsDetails"){
            if let newsDetailsVC = segue.destinationViewController as? NewsDetailViewController {
                let rowId = sender as! Int
                let news = gltcNews[rowId+1]!
                newsDetailsVC.newsDate = news.getNewsDate()
                newsDetailsVC.newsText = news.getNewsText()
                newsDetailsVC.newsImage = imageCache[news.getImageUrl()]
            }
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if(self.refreshControl.refreshing) {
            reloadData()
        }
    }
    
    func initiateSWRevealController() {
        if self.revealViewController() != nil {
            var image = UIImage(named: "menu_white")
            image = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self.revealViewController(), action: "revealToggle:")
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func initiateRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = PULL_TO_REFRESH_TEXT
        //self.refreshControl.addTarget(self, action: "reloadData:", forControlEvents: UIControlEvents.ValueChanged)
        self.newsTableView.addSubview(refreshControl)
    }
    
    func reloadData() {
        GLTCDataLoader.sharedInstance.loadGLTCJson()
        gltcNews = GLTCDataLoader.sharedInstance.getNews()
        self.refreshControl.endRefreshing()
        self.newsTableView.reloadData()
    }
}
