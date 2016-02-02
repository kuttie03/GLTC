//
//  SponsorsViewController.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/12/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

import UIKit

class SponsorsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var sponsorTableView: UITableView!
    
    var refreshControl:UIRefreshControl!
    var sponsors: [GLTCSponsor] = []
    var imageCache = Dictionary<String,UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sponsors = GLTCDataLoader.sharedInstance.getSponsors()
        sponsorTableView.delegate = self
        sponsorTableView.dataSource = self
        sponsorTableView.allowsSelection = false
        initiateSWRevealController()
        initiateRefreshControl()
    }
    
    //Returns Number of Sections
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if(sponsors.count > 0) {
            return 1
        }else{
            let messageLabel = GLTCUtil.getNoDataMessageLabel(CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
            self.sponsorTableView.backgroundView = messageLabel
        }
        return 0
    }
    
    //Returns number of Rows in each section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sponsors.count
    }
    
    //Called to load each row
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let sponsorCell = tableView.dequeueReusableCellWithIdentifier("sponsorCell") as? SponsorCell {
            let sponsor = sponsors[indexPath.row]
            sponsorCell.setSponsorName(sponsor.getName())
            let imageUrl = sponsor.getImageUrl()
            if let image = imageCache[imageUrl] {
                sponsorCell.sponsorImg.image = image
            }else{
                sponsorCell.sponsorImg.image = UIImage(named: "sponsor")
                NSURLSession.sharedSession().dataTaskWithURL( NSURL(string:imageUrl)!, completionHandler: {
                    (data, response, error) -> Void in
                    dispatch_async(dispatch_get_main_queue()) {
                        sponsorCell.sponsorImg.contentMode =  UIViewContentMode.ScaleAspectFit
                        if let data = data {
                            sponsorCell.sponsorImg.image = UIImage(data: data)
                            self.imageCache[imageUrl] = sponsorCell.sponsorImg.image
                        }
                    }
                }).resume()
            }
            return sponsorCell
        }else{
            return SponsorCell()
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
        self.sponsorTableView.addSubview(refreshControl)
    }
    
    func reloadData() {
        GLTCDataLoader.sharedInstance.loadGLTCJson(true)
        sponsors = GLTCDataLoader.sharedInstance.getSponsors()
        self.refreshControl.endRefreshing()
        self.sponsorTableView.reloadData()
    }
    
    /*func getAllVisibleCells() -> [UITableViewCell] {
        var cells = [UITableViewCell]()
        // assuming tableView is your self.tableView defined somewhere
        for i in 0...sponsorTableView.numberOfSections-1
        {
            for j in 0...sponsorTableView.numberOfRowsInSection(i)-1
            {
                if let cell = sponsorTableView.cellForRowAtIndexPath(NSIndexPath(forRow: j, inSection: i)) {
                    
                    cells.append(cell)
                }
                
            }
        }
        return cells
    }*/
}
