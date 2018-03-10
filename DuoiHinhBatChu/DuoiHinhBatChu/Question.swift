//
//  Question.swift
//  DuoiHinhBatChu
//
//  Created by ThinhLe on 3/6/18.
//  Copyright © 2018 ThinhLe. All rights reserved.
//

import Foundation

class Question
{
    var image: String
    var answear: String = ""
    var hint: [Character] = []
    
    init(answear: String, image: String) {
        self.answear = answear
        self.image = image
        
        let numOfLetter = answear.count/2
        var temp: String = answear
        
        for _ in 0..<numOfLetter
        {
            let letter: String = String(Character.getARandomLetter())
            temp = temp + letter
        }
        
        while !temp.isEmpty
        {
            let offset:Int = Int(arc4random_uniform(UInt32(temp.count)))
            let index: String.Index = temp.index(temp.startIndex, offsetBy: offset)
            hint.append(temp[index])
            temp.remove(at: index)
        }
    }
}
