//
//  GLTCNews.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/19/16.
//  Copyright © 2016 Darshan Labs. All rights reserved.
//

import UIKit

class GLTCNews {
    
    private var newsId: Int!
    
    private var newsHeadline: String!
    
    private var newsText: String!
    
    private var newsDate: String!
    
    private var imageUrl: String!
    
    func getNewsId() -> Int {
        return self.newsId
    }
    
    func setNewsId(newsId: Int){
        self.newsId = newsId
    }
    
    func getNewsHeadline() -> String {
        return self.newsHeadline
    }
    
    func setNewsHeadline(newsHeadline: String){
        self.newsHeadline = newsHeadline
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
    
    func getImageUrl() -> String {
        return self.imageUrl
    }
    
    func setImageUrl(imageUrl: String){
        self.imageUrl = imageUrl
    }
}
