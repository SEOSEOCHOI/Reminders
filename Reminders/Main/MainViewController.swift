//
//  MainViewController.swift
//  Reminders
//
//  Created by 최서경 on 2/14/24.
//

import UIKit
import RealmSwift

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
            "calendar"
        case .schedule:
            "calendar"
        case .total:
            "pencil"
        case .flag:
            "flag.fill"
        case .done:
            "checkmark"
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

class MainViewController: BaseViewController {
    let mainView = MainView()
    
    let list = ReminderList.allCases
    let repository = ReminderRepository()
    // 한번만 가져온 뒤 필터링
    var folderList: Results<Folder>!
    var realmList: Results<RemindersTable>!
    let realm = try! Realm()

    
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureToolBar()
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        realmList = repository.fetch()
        folderList = repository.fetchFolder()
        //doneList = repository.fetchDoneFilter()
        
        NotificationCenter.default.addObserver(self, selector: #selector(totalCountReceivedNotification), name: NSNotification.Name("TotalCountReceived"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        realmList = repository.fetch()
        //doneList = repository.fetchDoneFilter()
        // 데이터 변경 시점에만 reloadData
        mainView.collectionView.reloadData()
        mainView.tableView.reloadData()
    }
    
    @objc func totalCountReceivedNotification(notification: NSNotification) {
        if notification.userInfo?["reminders"] is Results<RemindersTable> {
            realmList = repository.fetch()
            print(#function, realmList?.count)

            mainView.collectionView.reloadData()
        }
        
        if notification.userInfo?["isDone"] is Results<RemindersTable> {
            //doneList = repository.fetchDoneFilter()
            
           // print(#function, doneList?.count)

            mainView.collectionView.reloadData()
        }
    }
    
    
    func configureToolBar() {
        self.navigationController?.isToolbarHidden = false
        
        let plusButton = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(todoButtonClicked))
        let todoButton = UIBarButtonItem(title: "새로운 할 일", style: .plain, target: self, action: #selector(todoButtonClicked))
        let addListButtom = UIBarButtonItem(title: "목록 추가", style: .plain, target: self, action: #selector(addListButtonClicked))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        var items = [UIBarButtonItem]()

        [plusButton,todoButton, flexibleSpace, addListButtom].forEach {
            items.append($0)
        }
        
        self.toolbarItems = items
    }
    
    @objc func todoButtonClicked() {
        print(#function)
        let vc = AddViewController()
        vc.navigationTitle = "새로운 미리알림"

        transition(style: .presentNavigation, viewController: vc)
    }
    
    @objc func addListButtonClicked() {
        print(#function)
        let vc = AddListViewController()
        transition(style: .presentNavigation, viewController: vc)
        
    }
    
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
        
        let item = list[indexPath.item]

        if indexPath.item == 2 {
                cell.countLabel.text = "\(realmList.count)"
        } else if indexPath.item == 4 {
            //cell.countLabel.text = "\(doneList.count)"
        } else {
            cell.countLabel.text = "0"
        }
        cell.statusLabel.text = item.todoList
        
        cell.statusImageView.backgroundColor = item.colorList
        cell.statusImageView.image = UIImage(systemName: item.imageList)

        cell.backgroundColor = .darkGray
        cell.layer.cornerRadius = 12

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = list[indexPath.item]
        switch indexPath.item {
        case 0:
            let vc = TodayViewController()
            vc.navigationTitle = item.todoList
            transition(style: .push, viewController: vc)
        case 1:
            let vc = ScheduleViewController()
            vc.navigationTitle = item.todoList
            transition(style: .push, viewController: vc)
        case 2:
            let vc = AllListViewController()
            vc.navigationTitle = item.todoList
            transition(style: .push, viewController: vc)
        case 4:
            let vc = DoneViewController()
            vc.navigationTitle = item.todoList
            transition(style: .push, viewController: vc)
        default:
            print("A")
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        let row = indexPath.row
        let data = folderList[row]
        
        cell.todoImageView.image = UIImage(systemName: "star")
        cell.titleLabel.text = data.folderName
        cell.countLabel.text = "\(data.reminderList.count)"
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "목록"
    }
    
}
