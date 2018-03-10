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
    var answer: String = ""
    var answerArray: [Character] = []
    var hintArray: [Character] = []
    
    init(answer: String, image: String) {
        self.answer = answer
        self.image = image
        
        for _ in answer
        {
            self.answerArray.append(".")
        }
        
        let numOfLetter = answer.count/2
        var temp: String = answer
        
        for _ in 0..<numOfLetter
        {
            let letter: String = String(Character.getARandomLetter())
            temp = temp + letter
        }
        
        //Adding all letter to "hint" from "temp" at random
        while !temp.isEmpty
        {
            let offset:Int = Int(arc4random_uniform(UInt32(temp.count)))
            let index: String.Index = temp.index(temp.startIndex, offsetBy: offset)
            hintArray.append(temp[index])
            temp.remove(at: index)
        }
    }
}
