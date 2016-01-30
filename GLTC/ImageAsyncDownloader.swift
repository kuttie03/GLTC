//
//  ImageAsyncDownloader.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/28/16.
//  Copyright © 2016 Darshan Labs. All rights reserved.
//

import Foundation

extension UIImageView {
    func downloadImageAndNotify(link link:String, contentMode: UIViewContentMode) {
        NSURLSession.sharedSession().dataTaskWithURL( NSURL(string:link)!, completionHandler: {
            (data, response, error) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                self.contentMode =  contentMode
                if let data = data {
                    NSNotificationCenter.defaultCenter().postNotificationName("imageDownloaded", object: nil)
                    self.image = UIImage(data: data)
                }
            }
        }).resume()
    }
}