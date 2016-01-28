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

    var imageUrl: String!
    var pageIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventImageView.image  = UIImage(named: "events_green")
        self.eventImageView.downloadImageFrom(link:imageUrl, contentMode: UIViewContentMode.ScaleAspectFit)
    }
}
