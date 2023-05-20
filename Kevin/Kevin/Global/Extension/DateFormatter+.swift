//
//  DateFormatterUtil+.swift
//  Kevin
//
//  Created by heerucan on 2023/05/17.
//

import UIKit

final class DateFormatterUtil {
    enum DateType: String {
        case yearMonth = "YYYY년 MM월"
        case fullKor = "yyyy년 MM월 dd일"
        case fullSlash = "yyyy-MM-dd"
        case monthDay = "MM월 dd일"
    }
    
    static func format(
        _ date: Date?,
        _ format: DateType = .fullSlash) -> String
    {
        guard let date = date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: date)
    }
}
