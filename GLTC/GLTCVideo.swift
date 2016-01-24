//
//  GLTCVideo.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/24/16.
//  Copyright © 2016 Darshan Labs. All rights reserved.
//

import UIKit

class GLTCVideo {
    
    private var videoName: String!
    
    private var videoUrl: String!
    
    func getVideoName() -> String {
        return self.videoName
    }
    
    func setVideoName(videoName: String) {
        self.videoName = videoName
    }
    
    func getVideoUrl() -> String {
        return self.videoUrl
    }
    
    func setVideoUrl(videoUrl: String) {
        self.videoUrl = videoUrl
    }
    
}
