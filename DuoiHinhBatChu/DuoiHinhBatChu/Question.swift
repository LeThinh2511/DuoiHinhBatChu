//
//  Question.swift
//  DuoiHinhBatChu
//
//  Created by ThinhLe on 3/6/18.
//  Copyright © 2018 ThinhLe. All rights reserved.
//

import Foundation

class Question: Hashable, Equatable
{
    var hashValue: Int
    {
        return answear.hashValue
    }
    
    static func ==(lhs: Question, rhs: Question) -> Bool {
        return lhs.answear == rhs.answear
    }
    
    var image: String
    var answear: String = ""
    var hint: Dictionary<Int, Character> = [:]
    
    init(answear: String, image: String) {
        self.answear = answear
        self.image = image
        
        /* add all characters to the "hint" Set from "answear" */
        var count: Int = 0
        for i in self.answear
        {
            hint[count] = i
            count = count + 1
        }
        // Adding more character to the "hint" property
        let numOfChar: Int = self.answear.count/2
        
        for _ in 0..<numOfChar
        {
            hint[count] = Character.getARandomLetter()
            count = count + 1
        }
    }
}
