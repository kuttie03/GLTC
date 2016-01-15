//
//  Committee.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/12/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

import UIKit

class Committee {
    
    private var name: String!
    
    private var members: [CommitteeMember]!
    
    init(name: String, members: [CommitteeMember]){
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
    
    func getMembers() -> [CommitteeMember]{
        return self.members
    }
    
    func setMembers(members: [CommitteeMember]){
        self.members = members
    }
}
