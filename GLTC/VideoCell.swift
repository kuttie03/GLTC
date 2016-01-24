//
//  VideoCell.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/24/16.
//  Copyright © 2016 Darshan Labs. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {

    @IBOutlet weak var videoWebView: UIWebView!
    
    @IBOutlet weak var videoLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        videoWebView.layer.cornerRadius = 5.0
        videoWebView.clipsToBounds = true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureVideoCell(videoName: String, videoUrl: String) {
        self.videoLbl.text = videoName
        self.videoWebView.loadHTMLString("<iframe width=\"\(self.videoWebView.frame.size.width)\" height=\"\(self.videoWebView.frame.size.height)\" src=\"\(videoUrl)\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
    }
}
