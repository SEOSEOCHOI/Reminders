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
    
    var realmList: Results<RemindersTable>?
    
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureToolBar()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        //realm 두번 만들어도되나...??
        let realm = try! Realm()
        
        realmList = realm.objects(RemindersTable.self)

        
        NotificationCenter.default.addObserver(self, selector: #selector(totalCountReceivedNotification), name: NSNotification.Name("TotalCountReceived"), object: nil)
    }
    
    @objc func totalCountReceivedNotification(notification: NSNotification) {
        if let value = notification.userInfo?["reminders"] as? Realm {
            realmList = value.objects(RemindersTable.self)
            print(#function, realmList?.count)
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
            if let realmList = realmList {
                cell.countLabel.text = "\(realmList.count)"
            }
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
    
    
}
