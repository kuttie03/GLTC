//
//  SponsorCell.swift
//  Custom-TableVC
//
//  Created by Shravan Kumar Singireddy on 1/11/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

import UIKit

class SponsorCell: UITableViewCell {

    @IBOutlet weak var sponsorImg: UIImageView!
    
    @IBOutlet weak var sponsorNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sponsorImg.layer.cornerRadius = 5.0
        sponsorImg.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setSponsorImage(sponsorImg: UIImageView){
        self.sponsorImg = sponsorImg
    }
    
    func setSponsorName(name: String) {
        self.sponsorNameLbl.text = name
    }
}

extension UIImageView {
    func downloadImageFrom(link link:String, contentMode: UIViewContentMode) {
        NSURLSession.sharedSession().dataTaskWithURL( NSURL(string:link)!, completionHandler: {
            (data, response, error) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                self.contentMode =  contentMode
                if let data = data {
                    self.image = UIImage(data: data)
                }
            }
        }).resume()
    }
}
