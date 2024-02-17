//
//  ListViewController.swift
//  Reminders
//
//  Created by 최서경 on 2/17/24.
//

import UIKit
import RealmSwift

class AllListViewController: BaseViewController {
    let mainView = AllListView()
    
    var navigationTitle: String = ""
    
    var reamList: Results<RemindersTable>!
    let repository = ReminderRepository()

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        mainView.tableView.register(AllListTableViewCell.self, forCellReuseIdentifier: AllListTableViewCell.identifier)
        
        reamList = repository.fetchNameSortFilter()
    }
    

}
extension AllListViewController {
    func configureNavigation() {
        navigationItem.title = navigationTitle

        let statusButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(statusButtonTapped))
        
        // 마감일순 / 제목순 / 우선순위 낮음
        let dueDate = UIAction(title: "마감일순", handler: { _ in print("마감일순") })
        let title = UIAction(title: "제목순", handler: { _ in print("제목순") })
        let priority = UIAction(title: "우선순위 낮음", handler: { _ in print("우선순위") })

        statusButton.menu = UIMenu(title: "정렬",
                             image: UIImage(systemName: "ellipsis.circle"),
                             identifier: nil,
                             options: .displayInline,
                                   children: [dueDate, title, priority])
        statusButton.changesSelectionAsPrimaryAction = false
                
        self.navigationItem.rightBarButtonItem = statusButton
    }
    @objc func statusButtonTapped() {
        print(#function)
    }
}
extension AllListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reamList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllListTableViewCell.identifier) as! AllListTableViewCell
        let data = reamList[indexPath.row]
        
        let doneImage = UIImage(systemName: "circle.inset.filled")
        let notDoneImage = UIImage(systemName: "circle")
        let isDoneImage = data.isDone ? doneImage : notDoneImage
        let priotyList = Priority.allCases


        cell.titleLabel.text = data.title
        cell.doneButton.setImage(isDoneImage, for: .normal)
        cell.endDateLabel.text
        if let memoText = data.memo {
            cell.memoLabel.text = memoText
        }
        cell.priorityLabel.text = priotyList[data.priority].priorityTitle
        cell.tagLabel.text = data.tag
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "삭제") { action, view, completionHandler in

            self.repository.delete(self.reamList[indexPath.row])
            tableView.reloadData()
            
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

