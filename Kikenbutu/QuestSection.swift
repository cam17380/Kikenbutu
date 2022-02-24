//
//  QuestSection.swift
//  Kikenbutu
//
//  Created by dev on 2022/02/24.
//

import Foundation

struct QuestSection: Hashable, Codable, Identifiable {
    var id: Int
    var sectionname: String
    var questions: [Quest]
    var isComplete: Bool
    
    struct Quest: Hashable, Codable, Identifiable {
        var id: Int
        var isCorrect: Bool
        var question: String
        var ans1: String
        var ans2: String
        var ans3: String
        var ans4: String
        var hint: String
        var answer: Int
    }
}
