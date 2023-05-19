//
//  ResultModel.swift
//  Kevin
//
//  Created by heerucan on 2023/05/18.
//

import Foundation

struct ResultModel {
    let percent: Confidence
    let type: AnalysisType
    let date: String
    let content: String
    
    init(percent: Confidence,
         type: AnalysisType,
         date: Date,
         content: String
    ) {
        self.percent = percent
        self.type = AnalysisType(rawValue: type.rawValue) ?? .neutral
        self.date = DateFormatterUtil.format(date)
        self.content = content
    }
}
