//
//  Joke.swift
//  Joker2
//
//  Created by Kameron Haramoto on 1/20/17.
//  Copyright © 2017 Kameron Haramoto. All rights reserved.
//

import Foundation

class Joke {
    var firstLine: String
    var secondLine: String
    var thirdLine: String
    var answerLine: String
    
    init (first: String? = "", second: String? = "", third: String? = "", answer: String? = "")
    {
        self.firstLine = first!
        self.secondLine = second!
        self.thirdLine = third!
        self.answerLine = answer!
    }
}
