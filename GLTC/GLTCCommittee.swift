//
//  GLTCCommittee.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/12/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

import UIKit

class GLTCCommittee {
    
    private var name: String!
    
    private var members: [GLTCCommitteeMember]!
    
    init(name: String, members: [GLTCCommitteeMember]){
        self.name = name
        self.members = members
    }
    
    init(){
        
    }
    
    func getName() -> String{
        return self.name
    }
    
    func setName(name: String){
        self.name = name
    }
    
    func getMembers() -> [GLTCCommitteeMember]{
        return self.members
    }
    
    func setMembers(members: [GLTCCommitteeMember]){
        self.members = members
    }
}
