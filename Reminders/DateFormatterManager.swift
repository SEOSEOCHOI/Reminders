//
//  DateFormatterManager.swift
//  Reminders
//
//  Created by 최서경 on 2/18/24.
//

import Foundation

// TODO: 싱글톰으로 학습해 보기
class DateFormatterManager {
    static let shared = DateFormatterManager()
    
    private init() {}
    
    private let dateformmater: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy / MM / dd"
        formatter.locale = Locale(identifier: "ko-KR")
        
        return formatter
    }()
    
    func DateToString(from date: Date) -> String {
        return dateformmater.string(from: date)
    }
    
    func StringToDate(text: String) -> Date? {
        guard let date = dateformmater.date(from: text) else { return nil }
        return date
    }
}
