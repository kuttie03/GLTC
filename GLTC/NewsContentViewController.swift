//
//  NewsContentViewController.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/19/16.
//  Copyright © 2016 Darshan Labs. All rights reserved.
//

import UIKit

class NewsContentViewController: UIViewController {
    
    @IBOutlet weak var newsImageView: UIImageView!
    
    @IBOutlet weak var newsLbl: UILabel!
    
    @IBOutlet weak var signLabel: UILabel!
    
    var newsImage: UIImageView!
    var newsTxt: String!
    var pageIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newsLbl.text = newsTxt
        if let newsImage = newsImage {
            signLabel.hidden = false
            self.newsImageView.image = newsImage.image
        }
    }

}
