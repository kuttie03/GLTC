//
//  WondersCell.swift
//  Custom-TableVC
//
//  Created by Shravan Kumar Singireddy on 1/11/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

import UIKit

class CommitteeMemberCell: UITableViewCell {

    @IBOutlet weak var memberImg: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        memberImg.layer.cornerRadius = 5.0
        memberImg.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(memberImg: UIImage, name: String, title: String){
        self.memberImg.image = memberImg
        self.nameLbl.text = name
        self.titleLbl.text = title
    }

}
