//
//  HomeViewController.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/14/16.
//  Copyright © 2016 Darshan Labs. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            //self.revealViewController().rearViewRevealWidth = 300
            var image = UIImage(named: "menu_white")
            image = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            //self.navigationItem.titleView = UIImageView(image: UIImage(named: "gltcBanner"))
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
}

