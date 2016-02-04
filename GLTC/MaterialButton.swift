//
//  RoundedButton.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/15/16.
//  Copyright © 2016 Darshan Labs. All rights reserved.
//

import UIKit

class MaterialButton: UIButton {

    override func awakeFromNib() {
        layer.cornerRadius = 5.0
        layer.shadowColor = GLTCUtil.getColorWithHexString(NAVBAR_TINT_HEX_COLOR).CGColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
    }
    
}
