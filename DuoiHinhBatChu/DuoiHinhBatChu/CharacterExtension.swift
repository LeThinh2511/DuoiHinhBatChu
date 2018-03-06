//
//  CharacterExtension.swift
//  DuoiHinhBatChu
//
//  Created by ThinhLe on 3/6/18.
//  Copyright © 2018 ThinhLe. All rights reserved.
//

import Foundation

extension Character
{
    static func getARandomLetter() -> Character
    {
        let base: String = "ABCDEGHIKLMNOPQRSTUVXY"
        let offset: Int = Int(arc4random_uniform(22))
        let index: String.Index = base.index(base.startIndex, offsetBy: offset)
        return base[index]
    }
}
