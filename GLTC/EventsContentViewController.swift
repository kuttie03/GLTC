//
//  EventsContentViewController.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/20/16.
//  Copyright © 2016 Darshan Labs. All rights reserved.
//

import UIKit

class EventsContentViewController: UIViewController {

    @IBOutlet weak var eventImageView: UIImageView!

    var eventImage: UIImageView!
    var pageIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let eventImage = eventImage {
            self.eventImageView.image = eventImage.image
        }else{
            print("No image found")
        }
    }
    
//    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
//        let app = UIApplication.sharedApplication()
//        if(app.statusBarOrientation.isLandscape) {
//            self.eventImageView.contentMode = .ScaleAspectFit
//        }else{
//            self.eventImageView.contentMode = .ScaleToFill
//        }
//    }
    
}
