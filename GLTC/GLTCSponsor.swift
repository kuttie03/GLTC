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
    
    private var sponsorImage: UIImageView!
    
    init(name: String, sponsorImage: UIImageView){
        self.name = name
        self.sponsorImage = sponsorImage
    }
    
    init() {
        
    }
    
    func getName() -> String {
        return self.name
    }
    
    func setName(name: String){
        self.name = name
    }
    
    func getSponsorImage() -> UIImageView {
        return self.sponsorImage
    }
    
    func setSponsorImage(sponsorImage: UIImageView){
        self.sponsorImage = sponsorImage
    }
}
