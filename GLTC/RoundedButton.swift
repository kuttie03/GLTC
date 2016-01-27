//
//  RoundedButton.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/15/16.
//  Copyright © 2016 Darshan Labs. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
    
}
