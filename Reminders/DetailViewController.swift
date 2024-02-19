//
//  DetailViewController.swift
//  Reminders
//
//  Created by 최서경 on 2/18/24.
//

import UIKit
import RealmSwift

class DetailViewController: BaseViewController {
    let mainView = DetailView()
    
    var navigationTitle: String = ""
    
    var reamList: Results<RemindersTable>!
    let repository = ReminderRepository()
    
    var sectionTitleList: [String] = ["마감일", "태그", "우선순위", "이미지 추가"]
    var subTitleList: [String] = ["", "", ""]
    var textViewTag: [Int] = []
    let placeholderText = ["제목", "메모"]

    var titleString: String = ""
    var memo: String?
    lazy var endDate = Date()
    var tag: String = ""
    var priorty: Int = 0
    var isDone:Bool = false
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reamList = repository.fetch()
    }

}
