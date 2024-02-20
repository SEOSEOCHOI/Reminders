//
//  AddViewController.swift
//  Reminders
//
//  Created by 최서경 on 2/14/24.
//

import UIKit
import RealmSwift

protocol PassDataDelegate {
    func priorityReceived(selectIndex: Int)
    func dateReceived(text: String)
}

class AddViewController: BaseViewController {
    
    let mainView = AddView()
    
    override func loadView() {
        self.view = mainView
    }
    
    var navigationTitle = ""
    
    // TODO: enum으로 관리해보기
    var sectionTitleList: [String] = ["마감일", "태그", "우선순위", "이미지 추가", "목록"]
    var subTitleList: [String] = ["", "", "", "dummy", ""] {
        didSet {
            navigationItem.rightBarButtonItem?.isEnabled = isAddButtonEnable()
        }
    }
    let placeholderText = ["제목", "메모"]
    
    let repository = ReminderRepository()
    let realm = try! Realm()
    var folder: Folder!
    var list: Results<RemindersTable>!
    var reminder: RemindersTable!
    

    
    var titleString: String = "" {
        didSet {
            navigationItem.rightBarButtonItem?.isEnabled = isAddButtonEnable()
        }
    }
    var memo: String?
    lazy var endDate = Date()
    var tag: String = ""
    var priorty: Int?
    var isDone:Bool = false
    var selectedImage: UIImage?
    var folderText: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        //print(#function,realm.configuration.fileURL)
        list = repository.fetch()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.rightBarButtonItem?.isEnabled = isAddButtonEnable()
    }
}

extension AddViewController {
    func configureNavigation() {

        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonClicked))
        let doneButton = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(doneButtonClicked))
        let addButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonClicked))
        navigationItem.title = navigationTitle
        
        navigationItem.leftBarButtonItem = cancelButton
        
        if let reminder = reminder {
            navigationItem.rightBarButtonItem = doneButton
        } else {
            navigationItem.rightBarButtonItem = addButton
        }
        navigationItem.rightBarButtonItem?.isEnabled = isAddButtonEnable()
    }
    
    @objc func cancelButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func addButtonClicked() {
        let data = RemindersTable(title: titleString, memo: memo, endDate: endDate, tag: tag, priority: priorty!, isDone: isDone)
        repository.creatRecord(data)
        
        NotificationCenter.default.post(name: NSNotification.Name("TotalCountReceived"),
                                        object: nil,
                                        userInfo: ["reminders":repository.fetch(),
                                                   "isDone":repository.fetchDoneFilter()])
        
        if let customCell = mainView.tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as? AddTableViewCell {
            if let image = customCell.selectedImageView.image {
                saveImageToDocument(image: image, fileName: "\(data.id)")
            }
        }
        
        do {
            try realm.write {
                // 1. DetailToDo에 바로 하위 항목 추가
                // realm.add(data)
                
                // 2. List를 통해 DetailToDo에 하위 항목 추가
                folder.reminderList.append(data)
            }
        } catch {
            print(error)
        }       
        
        dismiss(animated: true)
    }
    
    @objc func doneButtonClicked() {
        let data = RemindersTable(title: titleString, memo: memo, endDate: endDate, tag: tag, priority: priorty!, isDone: isDone)
        // TODO: 기능 구현
        dismiss(animated: true)
    }
    
    func isAddButtonEnable() -> Bool {
        if titleString == "" {
            return false
        }
        for list in subTitleList {
            if list == "" {
                return false
            }
        }
        
        return true
    }
}


extension AddViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: 상세화면과 재사용 코드 개선
        if let reminder = reminder {
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: AddTextFieldTableViewCell.identifier, for: indexPath) as! AddTextFieldTableViewCell
                    let inputString: [String?] = [titleString, memo]
                    let reminderString: [String?] = [reminder.title, reminder.memo]
                    
                    cell.textView.delegate = self
                    cell.textView.tag = indexPath.row
                    
                    if let inputText = inputString[indexPath.row] { // 제목
                        if inputText != "" { // 제목이 빈 문자열이 아닐 때
                            cell.textView.text = inputText
                            cell.textView.textColor = .white
                        } else { // 빈 문자열일 때
                            cell.textView.textColor = .lightGray
                            cell.textView.text = placeholderText[indexPath.row]
                        }
                    } else { // 메모
                        if inputString[indexPath.row] != nil && inputString[indexPath.row] != "" {
                            cell.textView.textColor = .white
                            cell.textView.text = inputString[indexPath.row]
                        } else {
                            cell.textView.textColor = .lightGray
                            cell.textView.text = placeholderText[indexPath.row]
                        }
                    }
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: AddTableViewCell.identifier, for: indexPath) as! AddTableViewCell
                
                if indexPath.section != 4 {
                    cell.subTitleLabel.text = subTitleList[indexPath.section - 1]
                    cell.selectedImageView.isHidden = true
                } else {
                    if let selectedImage = selectedImage {
                        cell.selectedImageView.isHidden = false
                        cell.selectedImageView.image = selectedImage
                        
                    }
                }
                
                cell.label.text = sectionTitleList[indexPath.section - 1]
                cell.accessoryType = .disclosureIndicator
                return cell
            }
        } else {
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: AddTextFieldTableViewCell.identifier, for: indexPath) as! AddTextFieldTableViewCell
                
                    let inputString: [String?] = [titleString, memo]
                    
                    cell.textView.delegate = self
                    cell.textView.tag = indexPath.row
                    
                    if let inputText = inputString[indexPath.row] { // 제목
                        if inputText != "" { // 제목이 빈 문자열이 아닐 때
                            cell.textView.text = inputText
                            cell.textView.textColor = .white
                        } else { // 빈 문자열일 때
                            cell.textView.textColor = .lightGray
                            cell.textView.text = placeholderText[indexPath.row]
                        }
                    } else { // 메모
                        if inputString[indexPath.row] != nil && inputString[indexPath.row] != "" {
                            cell.textView.textColor = .white
                            cell.textView.text = inputString[indexPath.row]
                        } else {
                            cell.textView.textColor = .lightGray
                            cell.textView.text = placeholderText[indexPath.row]
                        }
                    }
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: AddTableViewCell.identifier, for: indexPath) as! AddTableViewCell
                
                if indexPath.section != 4 {
                    cell.subTitleLabel.text = subTitleList[indexPath.section - 1]
                    cell.selectedImageView.isHidden = true
                } else {
                    if let selectedImage = selectedImage {
                        cell.selectedImageView.isHidden = false
                        cell.selectedImageView.image = selectedImage
                        
                    }
                }
                

                
                cell.label.text = sectionTitleList[indexPath.section - 1]
                cell.accessoryType = .disclosureIndicator
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            break
            
        default:
            // TODO: raw 밸류 들어가지 않게 수정
            let cell = tableView.cellForRow(at: indexPath) as! AddTableViewCell
            if indexPath.section == 1 { // delegate 값 전달
                let vc = DateViewController()
                vc.delegate = self
                vc.dateValue = subTitleList[0]
                transition(style: .push, viewController: vc)
                
            } else if indexPath.section == 2 { // closure 값 전달
                let vc = TagViewController()
                
                vc.tagText = { value in
                    self.subTitleList[1] = value
                    
                    cell.subTitleLabel.text = self.subTitleList[1]
                    self.tag = self.subTitleList[1]
                }
                vc.tagInput = tag
                
                transition(style: .push, viewController: vc)
                
            } else if indexPath.section == 3 { // delegate 값전달
                let vc = PriorityViewController()
                vc.delegate = self
                vc.selectedSegment = priorty
                transition(style: .push, viewController: vc)
                
            } else if indexPath.section == 4 {
                let vc = UIImagePickerController()
                vc.allowsEditing = true
                vc.delegate = self
                transition(style: .present, viewController: vc)
            } else {
                let vc = SelectListViewController()
                vc.folderData = { value in
                    self.folder = value
                    self.subTitleList[4] = value.folderName
                    
                    cell.subTitleLabel.text = self.subTitleList[4]
                    self.folderText = self.subTitleList[4]
                    print(value)
                }
                transition(style: .push, viewController: vc)
            }
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0{
                return UITableView.automaticDimension
            } else {
                return 100
            }
        } else {
            return UITableView.automaticDimension
        }
    }
}

extension AddViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            if textView.tag == 0 {
                textView.text = placeholderText[0]
            } else {
                textView.text = placeholderText[1]
            }
            textView.textColor = .lightGray
        }
    }
    
    // 텍스트 커서가 시작하는 순간. 편집이 시작될 때
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .white
        }
        print(#function, titleString, memo)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.textColor != .lightGray {
            if textView.tag == 0 {
                titleString = textView.text
                
            } else {
                if textView.text != "" {
                    memo = textView.text
                } else {
                    memo = nil
                }
            }
        }
        navigationItem.rightBarButtonItem?.isEnabled = isAddButtonEnable()
        print(titleString,memo)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // 키보드 숨기기
        return true
    }
}

extension AddViewController: PassDataDelegate {
    func priorityReceived(selectIndex: Int) {
        let priotyList = Priority.allCases
        priorty = selectIndex
        if let priorty = priorty {
            subTitleList[2] = priotyList[priorty].priorityTitle
            mainView.tableView.reloadData()
        }
    }
    
    func dateReceived(text: String) {
        if let date = DateFormatterManager.shared.StringToDate(text: text) {
            endDate = date
        }
        
        subTitleList[0] = text
        mainView.tableView.reloadData()
    }
}

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImage = pickedImage
            print(selectedImage)
            //mainView.tableView.reloadData()
        }
        dismiss(animated: true)
        
    }
}
