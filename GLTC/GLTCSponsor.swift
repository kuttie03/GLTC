//
//  GLTCSponsor.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/15/16.
//  Copyright © 2016 Darshan Labs. All rights reserved.
//

import UIKit

class GLTCSponsor {
    
    private var name: String!
    
    private var picture: UIImage!
    
    init(name: String, pictureUrl: String){
        self.name = name
        let url = NSURL(string: pictureUrl)!
        if let data = NSData(contentsOfURL: url) {
            picture = UIImage(data: data)
        }else{
            picture = UIImage(named: "userImg_medium")
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
    
    func getPicture() -> UIImage {
        return self.picture
    }
    
    func setPicture(pictureUrl: String){
        let url = NSURL(string: pictureUrl)!
        if let data = NSData(contentsOfURL: url) {
            picture = UIImage(data: data)
        }else{
            picture = UIImage(named: "userImg_medium")
        }
    }
    
}
