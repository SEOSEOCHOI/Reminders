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
    
    let list: [String] = ["오늘", "예정", "전체", "깃발 표사", "완료됨"]
    let colorList: [UIColor] = [.blue, .red, .gray, .yellow, .gray]
    let imageList: [String] = ["calendar",
                               "calendar",
                               "pencil",
                               "flag.fill",
                               "checkmark"]
    
    let repository = ReminderRepository()
    var realmList: Results<RemindersTable>!
    var doneList: Results<RemindersTable>!
    
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureToolBar()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        realmList = repository.fetch()
        doneList = repository.fetchDoneFilter(isDone: true)
         
        NotificationCenter.default.addObserver(self, selector: #selector(totalCountReceivedNotification), name: NSNotification.Name("TotalCountReceived"), object: nil)
    }
    
    @objc func totalCountReceivedNotification(notification: NSNotification) {
        if notification.userInfo?["reminders"] is Results<RemindersTable> {
            realmList = repository.fetch()
            print(#function, realmList?.count)

            mainView.collectionView.reloadData()
        }
        
        if notification.userInfo?["isDone"] is Results<RemindersTable> {
            doneList = repository.fetchDoneFilter(isDone: true)
            
            print(#function, doneList?.count)

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
        let nav = UINavigationController(rootViewController: vc)
        
        present(nav, animated: true)
    }
    
    @objc func addListButtonClicked() {
        print(#function)
    }
    
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell

        if indexPath.item == 2 {
                cell.countLabel.text = "\(realmList.count)"
        } else if indexPath.item == 4 {
            cell.countLabel.text = "\(doneList.count)"
        } else {
            cell.countLabel.text = "0"
        }
        
        
        cell.statusLabel.text = list[indexPath.item]
        
        cell.statusImageView.backgroundColor = colorList[indexPath.item]
        cell.statusImageView.image = UIImage(systemName: imageList[indexPath.item])

        cell.backgroundColor = .darkGray
        cell.layer.cornerRadius = 12

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 2:
            let vc = AllListViewController()
            vc.navigationTitle = list[indexPath.item]
            transition(style: .push, viewController: vc)
        case 4:
            let vc = DoneViewController()
            vc.navigationTitle = list[indexPath.item]
            transition(style: .push, viewController: vc)
        default:
            print("A")
        }
        
        let vc = AllListViewController()

    }
    
}
