//
//  VideoViewController.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/19/16.
//  Copyright © 2016 Darshan Labs. All rights reserved.
//

import UIKit
import MediaPlayer

class VideoViewController: UIViewController {
    
    var player = AVPlayer()
    
    override func viewDidLoad() {
        let myBaseUrl = "http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v"
        
        guard let url = NSURL(string: myBaseUrl) else {
            print("movie trailer not found")
            return
        }
        player = AVPlayer(URL: url)
        
        player.play()
    }
    
}
