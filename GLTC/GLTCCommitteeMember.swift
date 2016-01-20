//
//  GLTCCommitteeMember.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/12/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

import UIKit

class GLTCCommitteeMember {
    
    private var name: String!
    
    private var title: String!
    
    private var memberImage: UIImageView!
    
    init(name: String, title: String, memberImage: UIImageView){
        self.name = name
        self.title = title
        self.memberImage = memberImage
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
    
    func getMemberImage() -> UIImageView {
        return self.memberImage
    }
    
    func setMemberImage(memberImage: UIImageView){
        self.memberImage = memberImage
    }
    
}
