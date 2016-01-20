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
    
    var committees: [GLTCCommittee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        committees = GLTCDataLoader.sharedInstance.getCommittees()
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
    
    //Returns Number of Sections
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return committees.count
    }
    
    //Returns number of Rows in each section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let committee = committees[section]
        return committee.getMembers().count
    }
    
    //Called to load each row
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let committeeMemberCell = tableView.dequeueReusableCellWithIdentifier("committeeMemberCell") as? CommitteeMemberCell {
            let committee = committees[indexPath.section]
            let committeeMember = committee.getMembers()[indexPath.row]
            committeeMemberCell.memberImg.image = committeeMember.getMemberImage().image
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
