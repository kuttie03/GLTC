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
    
    private var imageUrl: String!
    
    init(newsText: String, imageUrl: String){
        self.newsText = newsText
        self.imageUrl = imageUrl
    }
    
    init() {
        
    }
    
    func getNewsText() -> String {
        return self.newsText
    }
    
    func setNewsText(newsText: String){
        self.newsText = newsText
    }
    
    func getImageUrl() -> String {
        return self.imageUrl
    }
    
    func setImageUrl(imageUrl: String){
        self.imageUrl = imageUrl
    }
}
