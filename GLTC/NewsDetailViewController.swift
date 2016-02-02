//
//  NewsDetailViewController.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/19/16.
//  Copyright © 2016 Darshan Labs. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    @IBOutlet weak var newsImageView: UIImageView!
    
    @IBOutlet weak var newsDateLbl: UILabel!
    
    @IBOutlet weak var newsTxtView: UITextView!
    
    var newsDate: String!
    var newsText: String!
    var newsImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newsDateLbl.text = newsDate
        self.newsTxtView.text = newsText
        self.newsImageView.image = newsImage
    }

}
