//
//  GLTCEvent.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/20/16.
//  Copyright © 2016 Darshan Labs. All rights reserved.
//

import Foundation

class GLTCEvent {
    
    private var eventImage: UIImageView!
    
    init(eventImage: UIImageView){
        self.eventImage = eventImage
    }
    
    init() {
        
    }
    
    func getEventImage() -> UIImageView {
        return self.eventImage
    }
    
    func setEventImage(eventImage: UIImageView){
        self.eventImage = eventImage
    }
    
}