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
    
    private let configureDateformmater: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy / MM / dd"
        formatter.locale = Locale(identifier: "ko-KR")
        
        return formatter
    }()

//    func DateString(from date: Date) -> String{
//        }


    
}
