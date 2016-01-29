//
//  EventsContentViewController.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/20/16.
//  Copyright © 2016 Darshan Labs. All rights reserved.
//

import UIKit

class EventsContentViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var eventImageView: UIImageView!

    var imageUrl: String!
    var pageIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "stopActivityIndicator:", name: "imageDownloaded", object: nil)
        self.eventImageView.image  = UIImage()
        if(imageUrl != nil && imageUrl != "") {
            self.eventImageView.downloadImageFrom(link:imageUrl, contentMode: UIViewContentMode.ScaleAspectFit)
        }
    }
    
    func stopActivityIndicator(notif: AnyObject) {
        self.activityIndicator.stopAnimating()
    }
}
