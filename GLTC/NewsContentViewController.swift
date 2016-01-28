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
    
    @IBOutlet weak var newsDataLbl: UILabel!
    
    @IBOutlet weak var newsLbl: UILabel!
    
    @IBOutlet weak var signLabel: UILabel!
    
    var imageUrl: String!
    var newsTxt: String!
    var newsDate: String!
    var pageIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newsImageView.image  = UIImage(named: "news_green")
        self.newsImageView.downloadImageFrom(link:imageUrl, contentMode: UIViewContentMode.ScaleAspectFit)
        self.newsDataLbl.text = newsDate
        self.newsLbl.text = newsTxt
    }

}
