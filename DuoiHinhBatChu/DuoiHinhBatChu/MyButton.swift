//
//  UIButtonExtension.swift
//  DuoiHinhBatChu
//
//  Created by ThinhLe on 3/12/18.
//  Copyright © 2018 ThinhLe. All rights reserved.
//

import UIKit

class MyButton: UIButton
{
    var hintButton: UIButton? = nil
    var index = 0
    var returnIndex = 0
    
    func setTextFrom(button: UIButton){
        self.setTitle(button.titleLabel?.text, for: .normal)
        hintButton = button
        hintButton?.isHidden = true
    }
}
