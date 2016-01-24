//
//  GLTCNews.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/19/16.
//  Copyright © 2016 Darshan Labs. All rights reserved.
//

import UIKit

class GLTCNews {
    
    private var newsText: String!
    
    private var newsDate: String!
    
    private var newsImage: UIImageView!
    
    init(newsText: String, newsDate: String, newsImage: UIImageView){
        self.newsText = newsText
        self.newsDate = newsDate
        self.newsImage = newsImage
    }
    
    init() {
        
    }
    
    func getNewsText() -> String {
        return self.newsText
    }
    
    func setNewsText(newsText: String){
        self.newsText = newsText
    }
    
    func getNewsDate() -> String {
        return self.newsDate
    }
    
    func setNewsDate(newsDate: String){
        self.newsDate = newsDate
    }
    
    func getNewsImage() -> UIImageView {
        return self.newsImage
    }
    
    func setNewsImage(newsImage: UIImageView){
        self.newsImage = newsImage
    }
}
