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
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func getSponsorImage() -> UIImageView{
        return self.sponsorImg
    }
    
    func setSponsorImage(sponsorImg: UIImageView){
        self.sponsorImg = sponsorImg
    }
    
    func setSponsorName(name: String) {
        self.sponsorNameLbl.text = name
    }
}