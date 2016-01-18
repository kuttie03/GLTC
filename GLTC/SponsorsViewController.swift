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
    
    var loadingView = UIView()
    
    var sponsors: [GLTCSponsor] = []
    
    let SPONSORS_JSON_URL = "http://1-dot-jsonloader-0834.appspot.com/jsonloader?jsonType=sponsorsJson"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sponsorTableView.delegate = self
        sponsorTableView.dataSource = self
        sponsorTableView.allowsSelection = false
        loadSponsors()
        if self.revealViewController() != nil {
            var image = UIImage(named: "menu_white")
            image = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self.revealViewController(), action: "revealToggle:")
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
    func loadSponsors(){
        let url:NSURL = NSURL(string: SPONSORS_JSON_URL)!
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        let task = session.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print(error)
                return
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.extractSponsorJsondata(data!)
                return
            })
        }
        task.resume()
    }
    
    func extractSponsorJsondata(data:NSData){
        do {
            let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            if let jsonDict = jsonDictionary {
                let sponsorJsonArray = jsonDict["sponsors"] as! NSArray
                print("Number of Sponsors: \(sponsorJsonArray.count)")
                for sponsorJson in sponsorJsonArray {
                    let sponsor = GLTCSponsor()
                    let sponsorJsonElement = sponsorJson as! NSDictionary
                    for (key, value) in sponsorJsonElement {
                        if(key as! String == "name"){
                            sponsor.setName(value as! String)
                        }else if(key as! String == "pictureUrl"){
                            sponsor.setImageUrl(value as! String)
                        }
                    }
                    self.sponsors.append(sponsor)
                }
            }
        }catch {
            print(error)
        }
        doTableRefresh()
    }
    
    func doTableRefresh(){
        dispatch_async(dispatch_get_main_queue(), {
            self.sponsorTableView.reloadData()
            return
        })
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
            sponsorCell.sponsorImg.image = UIImage(named: "sponsorImg")
            sponsorCell.sponsorImg.downloadImageFrom(link:sponsor.getImageUrl(), contentMode: UIViewContentMode.ScaleAspectFit)
            return sponsorCell
        }else{
            return SponsorCell()
        }
    }
}
