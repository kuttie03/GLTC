//
//  VideoViewController.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/19/16.
//  Copyright © 2016 Darshan Labs. All rights reserved.
//

import UIKit
import MediaPlayer

class VideoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var videTableView: UITableView!
    
    var refreshControl:UIRefreshControl!
    var videos: [GLTCVideo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videos = GLTCDataLoader.sharedInstance.getVideos()
        videTableView.delegate = self
        videTableView.dataSource = self
        videTableView.allowsSelection = false
        if self.revealViewController() != nil {
            var image = UIImage(named: "menu_white")
            image = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self.revealViewController(), action: "revealToggle:")
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // Initialize the refresh control
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = PULL_TO_REFRESH_TEXT
        self.refreshControl.addTarget(self, action: "reloadData:", forControlEvents: UIControlEvents.ValueChanged)
        self.videTableView.addSubview(refreshControl)
    }
    
    //Returns Number of Sections
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if(videos.count > 0) {
            return 1
        }else{
            let messageLabel = GLTCUtil.getNoDataMessageLabel(CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
            self.videTableView.backgroundView = messageLabel
        }
        return 0
    }
    
    //Returns number of Rows in each section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    //Called to load each row
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let videoCell = tableView.dequeueReusableCellWithIdentifier("videoCell") as? VideoCell {
            let video = videos[indexPath.row]
            videoCell.configureVideoCell(video.getVideoName(),videoUrl: video.getVideoUrl())
            return videoCell
        }else{
            return VideoCell()
        }
    }
    
    func reloadData(sender: AnyObject) {
        GLTCDataLoader.sharedInstance.loadGLTCJson()
        videos = GLTCDataLoader.sharedInstance.getVideos()
        self.refreshControl.endRefreshing()
        self.videTableView.reloadData()
    }
    
}
