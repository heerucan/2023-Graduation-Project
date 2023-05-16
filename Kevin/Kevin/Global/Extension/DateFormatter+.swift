//
//  DateFormatterUtil+.swift
//  Kevin
//
//  Created by heerucan on 2023/05/17.
//

import UIKit

final class DateFormatterUtil {
    static func formateDate(_ date: Date?) -> String {
        guard let date = date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = StringLiteral.Calendar.fullDateFormat
        return dateFormatter.string(from: date)
    }
}
