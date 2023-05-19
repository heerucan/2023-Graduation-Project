//
//  DateFormatterUtil+.swift
//  Kevin
//
//  Created by heerucan on 2023/05/17.
//

import UIKit

final class DateFormatterUtil {
    enum DateType: String {
        case yearMonth = "YYYY년 M월"
        case fullKor = "yyyy년 M월 d일"
        case fullSlash = "yyyy-MM-dd"
        case monthDay = "M월 d일"
    }
    
    static func format(
        _ date: Date?,
        _ format: DateType = .fullKor) -> String
    {
        guard let date = date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: date)
    }
}
