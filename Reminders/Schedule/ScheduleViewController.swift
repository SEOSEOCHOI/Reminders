//
//  ScheduleViewController.swift
//  Reminders
//
//  Created by 최서경 on 2/19/24.
//

import UIKit
import RealmSwift

class ScheduleViewController: BaseViewController {

    let mainView = ScheduleView()
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
        realmList = repository.fetch()
        let start = Calendar.current.startOfDay(for: Date())
        // compactMap: Returns the non-nil results of mapping the given transformation over this sequence.
        let highestDate = realmList.compactMap {
            $0.endDate
        }.max()
        
        let end = highestDate

        
        print(start, end)
        let schedulePredicate = NSPredicate(format: "endDate >= %@ && endDate <= %@", start as NSDate, end! as NSDate)
        
        realmList = realm.objects(RemindersTable.self).filter(schedulePredicate)
        
        mainView.countLabel.text = "\(realmList.count)개"
    }
}
extension ScheduleViewController {
    func configureNavigation() {
        navigationItem.title = navigationTitle
    }
}
