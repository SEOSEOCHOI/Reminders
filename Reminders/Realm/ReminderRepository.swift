//
//  ReminderRepository.swift
//  Reminders
//
//  Created by 최서경 on 2/17/24.
//

import Foundation
import RealmSwift

final class ReminderRepository {
    private let realm = try! Realm()

    // 램 추가
    func creatRecord(_ item: RemindersTable) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
    func fetch() -> Results<RemindersTable> { // 전체 램 가져오기
        return realm.objects(RemindersTable.self)
    }

    func fetchEndDateFilter() -> Results<RemindersTable> { // 마감일 정렬
        realm.objects(RemindersTable.self).sorted(byKeyPath: "endDate", ascending: true)
    }
    
    func fetchNameSortFilter() -> Results<RemindersTable> { // 제목 정렬
        realm.objects(RemindersTable.self).sorted(byKeyPath: "title", ascending: true)
    }
    
    func fetchPriorityFilter() -> Results<RemindersTable> { // 우선순위 정렬
        realm.objects(RemindersTable.self).sorted(byKeyPath: "priority", ascending: true)
    }
    
    func fetchDoneFilter() -> Results<RemindersTable> { // 완료된 데이터
        realm.objects(RemindersTable.self).where {
            $0.isDone == true
        }
    }
    
    func fetchDoneEndDateFilter() -> Results<RemindersTable> { // 완료 마감일 정렬
        realm.objects(RemindersTable.self).where {
            $0.isDone == true
        }.sorted(byKeyPath: "endDate", ascending: true)
    }
    
    func fetchDoneNameSortFilter() -> Results<RemindersTable> { // 완료 이름순 정렬
        realm.objects(RemindersTable.self).where {
            $0.isDone == true
        }.sorted(byKeyPath: "title", ascending: true)
    }
    
    func fetchDonePriorityFilter() -> Results<RemindersTable> {
        realm.objects(RemindersTable.self).where{
            $0.isDone == true
        }.sorted(byKeyPath: "priority", ascending: true)
    }
    
    func delete(_ item: RemindersTable) { // 삭제
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
    
    func updateDone(_ item: RemindersTable) { // 완료 업데이트
        do {
            try realm.write {
                item.isDone.toggle()
            }
        } catch {
            print(error)
        }
    }
    
    func updateTitle(_ item: RemindersTable, title: String) { // 제목 업데이트
        do {
            try realm.write {
                item.title = title
            }
        } catch {
            print(error)
        }
    }
    
    func updateDone(_ item: RemindersTable, memo: String) { // 메모 업데이트
        do {
            try realm.write {
                item.memo = memo
            }
        } catch {
            print(error)
        }
    }
    
    func updateDone(_ item: RemindersTable, endDate: Date) { // 마감일 업데이트
        do {
            try realm.write {
                item.endDate = endDate
            }
        } catch {
            print(error)
        }
    }
    
    func updateDone(_ item: RemindersTable, tag: String) { // 태그 업데이트
        do {
            try realm.write {
                item.tag = tag
            }
        } catch {
            print(error)
        }
    }
    
    func updateDone(_ item: RemindersTable, priority: Int) { // 우선순위 업데이트
        do {
            try realm.write {
                item.priority = priority
            }
        } catch {
            print(error)
        }
    }
    
}
