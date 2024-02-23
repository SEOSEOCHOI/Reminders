//
//  MainViewController.swift
//  Reminders
//
//  Created by 최서경 on 2/14/24.
//

import UIKit
import RealmSwift

class MainViewController: BaseViewController {
    let mainView = MainView()
    
    let list = ReminderList.allCases
    let repository = ReminderRepository() 
    
    var folderList: Results<Folder>! {
        didSet {
            print("didset")
            mainView.tableView.reloadData()
        }
    }
    var realmList: Results<RemindersTable>! {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    let realm = try! Realm()

    
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureToolBar()
        realmList = repository.fetch()
        folderList = repository.fetchFolder()
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
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
        vc.delegate = self
        transition(style: .presentNavigation, viewController: vc)
    }
    
    @objc func addListButtonClicked() {
        print(#function)
        let vc = AddListViewController()
        
        vc.folder = { value in
            self.repository.creatFolderRecord(value)
            self.mainView.tableView.reloadData()
        }
        
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
        
        switch indexPath.item {
        case 0:
            let start = Calendar.current.startOfDay(for: Date())
            
            // 내일 시작 날짜
            let end: Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date() // start 기준 + 1 <- 항상 다음날!
            
            // 쿼리 작성
            let TodayPredicate = NSPredicate(format: "endDate >= %@ && endDate < %@", start as NSDate, end as NSDate)
            
            realmList = repository.fetch().filter(TodayPredicate)
            cell.countLabel.text = "\(realmList.count)"
        case 1:
            realmList = repository.fetch()
            let start = Calendar.current.startOfDay(for: Date())
            // compactMap: Returns the non-nil results of mapping the given transformation over this sequence.
            let highestDate = realmList.compactMap {
                $0.endDate
            }.max()
            
            let end = highestDate

            let schedulePredicate = NSPredicate(format: "endDate >= %@ && endDate <= %@", start as NSDate, end! as NSDate)
            
            realmList = repository.fetch().filter(schedulePredicate)
                        
            cell.countLabel.text = "\(realmList.count)"
        case 2:
            realmList = repository.fetch()
            cell.countLabel.text = "\(realmList.count)"
        case 3:
            cell.countLabel.text = "0"
        case 4:
            realmList = repository.fetchDoneFilter()
            cell.countLabel.text = "\(realmList.count)"
        default: break
        }
        
        cell.statusLabel.text = item.todoList
        
        cell.statusImageView.tintColor = item.colorList
        cell.statusImageView.backgroundColor = .white
        //cell.statusImageView.layer.borderWidth = 5
        cell.statusImageView.layer.borderColor = item.colorList.cgColor
        // symbolConfiguration

        cell.statusImageView.image = UIImage(systemName: item.imageList)
        DispatchQueue.main.async {
            cell.statusImageView.layer.cornerRadius = cell.statusImageView.frame.height / 2
        }
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
extension MainViewController: PassDataDelegate {
    func priorityReceived(selectIndex: Int) {
        
    }
    
    func dateReceived(text: String) {
        
    }
    
    func ReminderReceived(data: RemindersTable, folder: Folder) {
        repository.creatRecord(data)
        repository.appendRecord(data, folder)
         
        mainView.tableView.reloadData()
        mainView.collectionView.reloadData()
    }

}
