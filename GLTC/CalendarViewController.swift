//
//  CalendarViewController.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/26/16.
//  Copyright © 2016 Darshan Labs. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "GLTC Calendar 2016"
        let path = NSBundle.mainBundle().pathForResource("gltc_calendar_2016", ofType: "pdf")
        let url = NSURL.fileURLWithPath(path!)
        self.webView.loadRequest(NSURLRequest(URL: url))
    }
    
}
