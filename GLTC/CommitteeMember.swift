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
    
    private var picture: UIImage!
    
    init(name: String, title: String, pictureName: String){
        self.name = name
        self.title = title
        if let image = UIImage(named: pictureName){
            self.picture = image
        }else{
            self.picture = UIImage(named: "userImg_medium")
        }
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
    
    func getPicture() -> UIImage {
        return self.picture
    }
    
    func setPicture(imageName: String){
        if let image = UIImage(named: imageName){
            self.picture = image
        }else{
            self.picture = UIImage(named: "userImg_medium")
        }
    }
    
}
