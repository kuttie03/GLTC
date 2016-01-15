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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sponsorImg.layer.cornerRadius = 5.0
        sponsorImg.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(memberImg: UIImage){
        self.sponsorImg.image = memberImg
    }

}
