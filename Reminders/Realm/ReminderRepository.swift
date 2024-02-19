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

    func creatRecord(_ item: RemindersTable) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
    func fetch() -> Results<RemindersTable> {
        return realm.objects(RemindersTable.self)
    }

    func fetchEndDateFilter() -> Results<RemindersTable> {
        realm.objects(RemindersTable.self).sorted(byKeyPath: "endDate", ascending: true)
    }
    
    func fetchNameSortFilter() -> Results<RemindersTable> {
        realm.objects(RemindersTable.self).sorted(byKeyPath: "title", ascending: true)
    }
    
    func fetchPriorityFilter() -> Results<RemindersTable> {
        realm.objects(RemindersTable.self).sorted(byKeyPath: "priority", ascending: true)
    }
    
    func fetchDoneFilter(isDone: Bool) -> Results<RemindersTable> {
        realm.objects(RemindersTable.self).where {
            $0.isDone == true
        }
    }
    
    func fetchDoneEndDateFilter(isDone: Bool) -> Results<RemindersTable> {
        realm.objects(RemindersTable.self).where {
            $0.isDone == true
        }.sorted(byKeyPath: "endDate", ascending: true)
    }
    
    func fetchDoneNameSortFilter(isDone: Bool) -> Results<RemindersTable> {
        realm.objects(RemindersTable.self).where {
            $0.isDone == true
        }.sorted(byKeyPath: "title", ascending: true)
    }
    
    func fetchDonePriorityFilter(isDone: Bool) -> Results<RemindersTable> {
        realm.objects(RemindersTable.self).where{
            $0.isDone == true
        }.sorted(byKeyPath: "priority", ascending: true)
    }
    
    func delete(_ item: RemindersTable) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
    
    func updateDone(_ item: RemindersTable) {
        do {
            try realm.write {
                item.isDone.toggle()
            }
        } catch {
            print(error)
        }
    }
    
}
