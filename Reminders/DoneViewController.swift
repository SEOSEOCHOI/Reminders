//
//  DoneViewController.swift
//  Reminders
//
//  Created by 최서경 on 2/18/24.
//

import UIKit
import RealmSwift

class DoneViewController: BaseViewController {
    let mainView = DoneView()
    
    var navigationTitle: String = ""
    
    var doneList: Results<RemindersTable>!
    let repository = ReminderRepository()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        doneList = repository.fetchDoneFilter(isDone: true)
    }
}
// TODO: View Extension
extension DoneViewController {
    func configureNavigation() {
        navigationItem.title = navigationTitle

        let statusButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(statusButtonTapped))
        
        // 마감일순 / 제목순 / 우선순위 낮음
        let dueDate = UIAction(title: "마감일순", handler: { _ in
            self.doneList = self.repository.fetchDoneEndDateFilter(isDone: true)
            print(self.doneList)

            self.mainView.tableView.reloadData()
        })
        let title = UIAction(title: "제목순", handler: { _ in            
            self.doneList = self.repository.fetchDoneNameSortFilter(isDone: true)
            print(self.doneList)

            self.mainView.tableView.reloadData()
        })
        let priority = UIAction(title: "우선순위 낮음", handler: { _ in            
            self.doneList = self.repository.fetchDonePriorityFilter(isDone: true)
            print(self.doneList)
            self.mainView.tableView.reloadData()
        })

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

extension DoneViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doneList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllListTableViewCell.identifier) as! AllListTableViewCell
        let row = indexPath.row
        let data = doneList[indexPath.row]
        let dateFormatter = DateFormatter()
        
        let doneImage = UIImage(systemName: "circle.inset.filled")
        let notDoneImage = UIImage(systemName: "circle")
        let isDoneImage = data.isDone ? doneImage : notDoneImage
        let priotyList = Priority.allCases
        let priorityImage = priotyList[data.priority].priorityImage
        let date = data.endDate
        let dateString = dateFormatter.string(from: date)
        
        // TODO: 메모 콜렉션뷰로 해보기
        cell.titleLabel.text = data.title
        
        cell.doneButton.setImage(isDoneImage, for: .normal)
        cell.doneButton.tag = row
        cell.doneButton.addTarget(self, action: #selector(doneButtonClicked(_:)), for: .touchUpInside)
        
        cell.endDateLabel.text = dateString
        if let memoText = data.memo {
            cell.memoLabel.text = memoText
        }
        cell.priorityImageView.text = priorityImage
        
        cell.tagLabel.text = data.tag
        
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "삭제") { action, view, completionHandler in

            self.repository.delete(self.doneList[indexPath.row])
            tableView.reloadData()
            
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    @objc func doneButtonClicked(_ sender: UIButton) {
        repository.updateDone(doneList[sender.tag])
        mainView.tableView.reloadData()
        
        NotificationCenter.default.post(name: NSNotification.Name("TotalCountReceived"),
                                        object: nil,
                                        userInfo: ["isDone":repository.fetchDoneFilter(isDone: true)])
    }
}
