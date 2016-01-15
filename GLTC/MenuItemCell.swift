//
//  WondersCell.swift
//  Custom-TableVC
//
//  Created by Shravan Kumar Singireddy on 1/11/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

import UIKit

class MenuItemCell: UITableViewCell {

    @IBOutlet weak var menuImg: UIImageView!
    
    @IBOutlet weak var menuText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(menuImg: UIImage, menuText: String){
        self.menuImg.image = menuImg
        self.menuText.text = menuText
    }

}
