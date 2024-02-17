//
//  RealmModel.swift
//  Reminders
//
//  Created by 최서경 on 2/15/24.
//

import Foundation
import RealmSwift

class RemindersTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String // 제목
    @Persisted var memo: String? // 메모
    @Persisted var endDate: Date // 마감일
    @Persisted var tag: String // 태그
    @Persisted var priority: Int // 우선순위
    @Persisted var isDone: Bool
    
    convenience init(title: String, memo: String? = nil, endDate: Date, tag: String, priority: Int, isDone: Bool) {
        self.init()
        self.title = title
        self.memo = memo
        self.endDate = endDate
        self.tag = tag
        self.priority = priority
        self.isDone = false
    }
}

