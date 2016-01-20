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
    
    var imageUrl: String!
    var newsTxt: String!
    var pageIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: imageUrl)
        if let data = NSData(contentsOfURL: url!) {
            self.newsImageView.image = UIImage(data: data)
            self.newsImageView.layer.cornerRadius = 5.0
        }
        self.newsLbl.text = newsTxt
    }

}
