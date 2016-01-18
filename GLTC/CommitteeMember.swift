//
//  CommitteeMember.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/12/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

import UIKit

class CommitteeMember {
    
    private var name: String!
    
    private var title: String!
    
    private var imageUrl: String!
    
    init(name: String, title: String, imageUrl: String){
        self.name = name
        self.title = title
        self.imageUrl = imageUrl
    }
    
    init(){
        
    }
    
    func getName() -> String {
        return self.name
    }
    
    func setName(name: String){
        self.name = name
    }
    
    func getTitle() -> String {
        return self.title
    }
    
    func setTitle(title: String){
        self.title = title
    }
    
    func getImageUrl() -> String {
        return self.imageUrl
    }
    
    func setImageUrl(imageUrl: String){
        self.imageUrl = imageUrl
    }
    
}
