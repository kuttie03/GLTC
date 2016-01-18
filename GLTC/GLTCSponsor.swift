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
    
    private var imageUrl: String!
    
    init(name: String, imageUrl: String){
        self.name = name
        self.imageUrl = imageUrl
    }
    
    init() {
        
    }
    
    func getName() -> String {
        return self.name
    }
    
    func setName(name: String){
        self.name = name
    }
    
    func getImageUrl() -> String {
        return self.imageUrl
    }
    
    func setImageUrl(imageUrl: String){
        self.imageUrl = imageUrl
    }
}
