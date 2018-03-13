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
    var answer: [Character]
    var hint: [Character]
    
    init(answer: String, image: String) {
        self.answer = Array(answer)
        self.image = image
        
        let numOfLetter = answer.count/2
        var temp: String = answer
        
        for _ in 0..<numOfLetter
        {
            let letter: String = String(Character.getARandomLetter())
            temp = temp + letter
        }
        hint = []
        while !temp.isEmpty
        {
            let offset:Int = Int(arc4random_uniform(UInt32(temp.count)))
            let index: String.Index = temp.index(temp.startIndex, offsetBy: offset)
            hint.append(temp[index])
            temp.remove(at: index)
        }
    }
}
