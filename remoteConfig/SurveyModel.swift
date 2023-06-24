//
//  SurveyModel.swift
//  remoteConfig
//
//  Created by Anastasia Nevodchikova on 22.06.2023.
//

import Foundation

// MARK: - SurveyModel
struct SurveyModel: Codable {
    let id: Int
    let title, description: String
    let questions: [Question]
}

// MARK: - Question
struct Question: Codable {
    let id: Int
    let title: String
    let answers: [Answer]
    let nextQuestionID, prevQuestionID: Int?

    enum CodingKeys: String, CodingKey {
        case id, title, answers
        case nextQuestionID = "nextQuestionId"
        case prevQuestionID = "prevQuestionId"
    }
}

// MARK: - Answer
struct Answer: Codable {
    let id: Int
    let title: String
    let nextQuestionID: Int?

    enum CodingKeys: String, CodingKey {
        case id, title
        case nextQuestionID = "nextQuestionId"
    }
}
