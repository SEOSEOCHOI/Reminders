//
//  Enumeration.swift
//  Reminders
//
//  Created by 최서경 on 2/16/24.
//

import Foundation
import UIKit
enum Priority: Int, CaseIterable {
    case top
    case middle
    case low
    
    var priorityTitle: String {
        switch self {
        case .top:
            return "높음"
        case .middle:
            return "낮음"
        case .low:
            return "중간"
        }
    }
    
    var priorityImage: String {
        switch self {
        case .top:
            return "!!!"
            //return "exclamationmark.3"
        case .middle:
            return "!!"
            //return "exclamationmark.2"
        case .low:
            return "!"
            //return "exclamationmark"        }
        }
    }
}

enum ReminderList: String, CaseIterable {
    case today
    case schedule
    case total
    case flag
    case done
    
    var todoList: String {
        switch self {
        case .today:
            return "오늘"
        case .schedule:
            return "예정"
        case .total:
            return "전체"
        case .flag:
            return "깃발 표시"
        case .done:
            return "완료됨"
        }
    }
    
    var imageList: String {
        switch self {
        case .today:
            "calendar.circle.fill"
        case .schedule:
            "calendar.circle.fill"
        case .total:
            "pencil.circle.fill"
        case .flag:
            "flag.circle.fill"
        case .done:
            "checkmark.circle.fill"
        }
    }
    
    var colorList: UIColor {
        switch self {
        case .today:
            return .blue
        case .schedule:
            return .red
        case .total:
            return .gray
        case .flag:
            return .yellow
        case .done:
            return .gray
        }
    }
}
