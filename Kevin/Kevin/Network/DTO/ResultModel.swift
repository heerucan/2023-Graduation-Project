//
//  ResultModel.swift
//  Kevin
//
//  Created by heerucan on 2023/05/18.
//

import Foundation

struct ResultModel {
    let percentage: Confidence?
    let type: AnalysisType
    let date: String
    let content: String
    
    init(percentage: Confidence?,
         type: AnalysisType,
         date: String,
         content: String
    ) {
        self.percentage = percentage
        self.type = AnalysisType(rawValue: type.rawValue) ?? .neutral
        self.date = date
        self.content = content
    }
}
