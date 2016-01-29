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
    
    var sponsors: [GLTCSponsor] = []
    var imageCache = Dictionary<String,UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sponsors = GLTCDataLoader.sharedInstance.getSponsors()
        sponsorTableView.delegate = self
        sponsorTableView.dataSource = self
        sponsorTableView.allowsSelection = false
        
        /*var calendarImage = UIImage(named: "calendar")
        calendarImage = calendarImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: calendarImage, style: UIBarButtonItemStyle.Plain, target: self, action: nil)*/
    
        if self.revealViewController() != nil {
            var image = UIImage(named: "menu_white")
            image = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self.revealViewController(), action: "revealToggle:")
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
    //Returns Number of Sections
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
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
                sponsorCell.sponsorImg.image = UIImage(named: "sponsor_medium_green")
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
}
