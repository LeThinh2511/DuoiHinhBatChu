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
    

    var hint: Set<Character> = []
    
    init(answear: String, image: String) {
        self.answear = answear
        self.image = image
        
        /* add all characters to the "hint" Set from "answear" */
        for i in self.answear
        {
            self.hint.insert(i)
            print(self.hint)
        }
        // Adding more character to the "hint" property
        let numOfChar: Int = self.answear.count/2 + 1
        
        for _ in 0..<numOfChar
        {
            self.hint.insert(Character.getARandomLetter())
        }
    }
}
