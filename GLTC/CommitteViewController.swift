//
//  CommitteeViewController.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/12/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

import UIKit

class CommitteeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var committeeTableView: UITableView!
    
    var committees: [Committee] = []
    
    let COMMITTEE_JSON_URL = "http://1-dot-jsonloader-0834.appspot.com/jsonloader?jsonType=committeesJson"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCommittees()
        committeeTableView.delegate = self
        committeeTableView.dataSource = self
        committeeTableView.allowsSelection = false
        if self.revealViewController() != nil {
            var image = UIImage(named: "menu_white")
            image = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self.revealViewController(), action: "revealToggle:")
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
//    func loadCommitteejson(){
//        //let urlString = "http://swapi.co/api/people/1/"
//        //let urlString = "http://pokeapi.co/api/v1/pokemon/1/"
//        let urlString = "http://1-dot-iodevelopment-1190.appspot.com/iosdevelopment"
//        let session = NSURLSession.sharedSession()
//        let url = NSURL(string: urlString)!
//        
//        session.dataTaskWithURL(url) { (data:NSData?, response: NSURLResponse?, error: NSError?) -> Void in
//            if let responseData = data {
//                self.extractJsondata(responseData)
//            }
//        }.resume()
//    }
    
//    func loadCommitteejson(){
//        let path = NSBundle.mainBundle().pathForResource("committee", ofType: "json")
//        let fileData = NSData(contentsOfFile: path!)
//        if let data = fileData {
//            extractCommitteeJsondata(data)
//        }
//    }
    
    func loadCommittees(){
        let url:NSURL = NSURL(string: COMMITTEE_JSON_URL)!
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        let task = session.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error")
                return
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.extractCommitteeJsondata(data!)
                return
            })
        }
        task.resume()
    }
    
    func extractCommitteeJsondata(data:NSData){
        do {
            let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            if let jsonDict = jsonDictionary {
                let committeeJsonArray = jsonDict["committee"] as! NSArray
                print("Number of Committees: \(committeeJsonArray.count)")
                for committeeJson in committeeJsonArray {
                    let committee = Committee()
                    let committeeJsonElement = committeeJson as! NSDictionary
                    for (key, value) in committeeJsonElement {
                        if(key as! String == "name"){
                            print("Committee Name: \(value)")
                            committee.setName(value as! String)
                        }else if(key as! String == "members"){
                            var members: [CommitteeMember] = []
                            let committeeMemberJsonArray = value as! NSArray
                            print("Number of Committee Members: \(committeeJsonArray.count)")
                            for committeeMemberJson in committeeMemberJsonArray {
                                let committeeMember = CommitteeMember()
                                let committeeMemberJsonElement = committeeMemberJson as! NSDictionary
                                for (key,value) in committeeMemberJsonElement {
                                    if(key as! String == "name"){
                                        committeeMember.setName(value as! String)
                                    }else if(key as! String == "title"){
                                        committeeMember.setTitle(value as! String)
                                    }else if(key as! String == "picture"){
                                        committeeMember.setImageUrl(value as! String)
                                    }
                                }
                                members.append(committeeMember)
                            }
                            committee.setMembers(members)
                        }
                    }
                    self.committees.append(committee)
                }
            }
        }catch {
            print(error)
        }
        doTableRefresh()
    }
    
    func doTableRefresh(){
        dispatch_async(dispatch_get_main_queue(), {
            self.committeeTableView.reloadData()
            return
        })
    }
    
    //Returns Number of Sections
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        print("numberOfSectionsInTableView \(committees.count)")
        return committees.count
    }
    
    //Returns number of Rows in each section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfSectionsInTableView \(committees[section].getMembers().count)")
        let committee = committees[section]
        return committee.getMembers().count
    }
    
    //Called to load each row
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let committeeMemberCell = tableView.dequeueReusableCellWithIdentifier("committeeMemberCell") as? CommitteeMemberCell {
            let committee = committees[indexPath.section]
            let committeeMember = committee.getMembers()[indexPath.row]
            committeeMemberCell.memberImg.image = UIImage(named: "userImg_medium")
            committeeMemberCell.memberImg.downloadImageFrom(link:committeeMember.getImageUrl(), contentMode: UIViewContentMode.ScaleAspectFit)
            committeeMemberCell.nameLbl.text = committeeMember.getName()
            committeeMemberCell.titleLbl.text = committeeMember.getTitle()
            return committeeMemberCell
        }else{
            return CommitteeMemberCell()
        }
    }
    
    //Called to load each section's header
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let committee = committees[section]
        return committee.getName()
    }
    
    

}
