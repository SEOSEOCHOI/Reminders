//
//  Enumeration.swift
//  Reminders
//
//  Created by 최서경 on 2/16/24.
//

import Foundation
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
}
