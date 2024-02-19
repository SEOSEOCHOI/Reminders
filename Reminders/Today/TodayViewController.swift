//
//  TodayViewController.swift
//  Reminders
//
//  Created by 최서경 on 2/19/24.
//

import UIKit
import RealmSwift

class TodayViewController: BaseViewController {
    let mainView = TodayView()
    var navigationTitle: String = ""
    let realm = try! Realm()
    let repository = ReminderRepository()

    var realmList: Results<RemindersTable>!
    
    
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        let start = Calendar.current.startOfDay(for: Date())
        
        // 내일 시작 날짜
        let end: Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date() // start 기준 + 1 <- 항상 다음날!
        
        // 쿼리 작성
        let TodayPredicate = NSPredicate(format: "endDate >= %@ && endDate < %@", start as NSDate, end as NSDate)
        


        realmList = realm.objects(RemindersTable.self).filter(TodayPredicate)
        mainView.countLabel.text = "\(realmList.count)개"
        


    }
}
extension TodayViewController {
    func configureNavigation() {
        navigationItem.title = navigationTitle
    }
}
