//
//  NewsContentViewController.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/19/16.
//  Copyright © 2016 Darshan Labs. All rights reserved.
//

import UIKit

class NewsContentViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var newsImageView: UIImageView!
    
    @IBOutlet weak var newsDataLbl: UILabel!
    
    @IBOutlet weak var newsLbl: UILabel!
    
    @IBOutlet weak var signLabel: UILabel!
    
    var imageUrl: String!
    var newsTxt: String!
    var newsDate: String!
    var pageIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.startAnimating()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "stopActivityIndicator:", name: "imageDownloaded", object: nil)
        self.newsImageView.image  = UIImage()
        self.newsImageView.downloadImageFrom(link:imageUrl, contentMode: UIViewContentMode.ScaleAspectFit)
        self.newsDataLbl.text = newsDate
        self.newsLbl.text = newsTxt
    }
    
    func stopActivityIndicator(notif: AnyObject) {
        self.activityIndicator.stopAnimating()
    }

}
