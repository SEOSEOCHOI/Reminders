//
//  AddListViewController.swift
//  Reminders
//
//  Created by 최서경 on 2/20/24.
//

import UIKit
import RealmSwift

class AddListViewController: BaseViewController {
    let mainView = AddListView()
    
    var folderName: String = ""
    var regDate = Date()
    
    let repository = ReminderRepository()
    let realm = try! Realm()
    
    override func loadView() {
        self.view = mainView
        print(realm.configuration.fileURL)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let customCell = mainView.tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? AddListTableViewCell {
            customCell.addTextField.becomeFirstResponder()
        }
    }
    
    override func configureView() {
        super.configureView()
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        self.view.endEditing(true)
        
        navigationItem.title = "새로운 목록"
        
        let cancleButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonClicked))
        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonClicked))
        
        
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = cancleButton
        navigationItem.rightBarButtonItem?.isEnabled = isAddButtonEnable()
    }
    
    func isAddButtonEnable() -> Bool {
        if folderName == "" {
            return false
        }
        return true
    }
    
    @objc func cancelButtonClicked() {
        print(#function)
        dismiss(animated: true)
    }
    @objc func doneButtonClicked() {
        print(#function)
        print(regDate)
        
        let data = Folder(folderName: folderName, regDate: regDate)
        repository.creatFolderRecord(data)
        dismiss(animated: true)
    }
}
extension AddListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddListTableViewCell.identifier, for: indexPath) as! AddListTableViewCell
            cell.addTextField.delegate = self
            cell.addTextField.addTarget(self, action: #selector(textFieldDidChanacge(_: )), for: .editingChanged)

            return cell

        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddDateTableViewCell.identifier, for: indexPath) as! AddDateTableViewCell
            return cell
        }
    }
    // TODO: 레이아웃 깨짐 확인
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension AddListViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(#function)
        navigationItem.rightBarButtonItem?.isEnabled =  isAddButtonEnable()  
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @objc func textFieldDidChanacge(_ sender: UITextField) {
        var inputText = sender.text
        if let inputText = inputText {
            print(#function, inputText)
            folderName = inputText
        }
        navigationItem.rightBarButtonItem?.isEnabled =  isAddButtonEnable()
    }
}
