//
//  SelectListViewController.swift
//  Reminders
//
//  Created by 최서경 on 2/21/24.
//

import UIKit
import RealmSwift

class SelectListViewController: BaseViewController {
    let mainView = SelectListView()
    
    let navigationTitle = ""
    var folderData: ((Folder) -> Void)?
    var selectedFolder: Folder?
    
    var folderList: Results<Folder>!
    let repository = ReminderRepository()
    
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        folderList = repository.fetchFolder()
    }
}
extension SelectListViewController {
    func configureNavigation() {
        let backButton = UIBarButtonItem(title: "세부사항", image: UIImage(systemName: "chevron.backward"), target: self, action: #selector(backButtonClicked))
        
        navigationItem.title = "목록"
        
        navigationItem.leftBarButtonItem = backButton

    }
    
    @objc func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SelectListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: (SelectListView.identifier + "Cell"), for: indexPath)
        let row = folderList[indexPath.row]
        cell.imageView?.image = UIImage(systemName: "star")
        cell.textLabel?.text = row.folderName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFolder = folderList[indexPath.row]
        
        if let selectedFolder = selectedFolder {
            folderData?(selectedFolder)
        }
        self.navigationController?.popViewController(animated: true)
    }
}
