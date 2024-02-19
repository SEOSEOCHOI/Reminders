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
    
    var sectionTitleList: [String] = ["마감일", "태그", "우선순위", "이미지 추가"]
    var subTitleList: [String] = ["", "", ""]
    var textViewTag: [Int] = []
    let placeholderText = ["제목", "메모"]
    let repository = ReminderRepository()
    
    var titleString: String = ""
    var memo: String?
    lazy var endDate = Date()
    var tag: String = ""
    var priorty: Int = 0
    var isDone:Bool = false
    var selectedImage: UIImage?
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        print(#function,realm.configuration.fileURL)
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.rightBarButtonItem?.isEnabled = isAddButtonEnable()
    }
}

extension AddViewController {
    func configureNavigation() {
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonClicked))
        let addButtom = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonClicked))
        
        navigationItem.title = "새로운 할 일"
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = addButtom
        navigationItem.rightBarButtonItem?.isEnabled = isAddButtonEnable()
    }
    
    @objc func cancelButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func addButtonClicked() {
        let data = RemindersTable(title: titleString, memo: memo, endDate: endDate, tag: tag, priority: priorty, isDone: isDone)
        repository.creatRecord(data)
        
        if let image = selectedImage {
            saveImageToDocument(image: image, fileName: "\(data.id)")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("TotalCountReceived"),
                                        object: nil,
                                        userInfo: ["reminders":repository.fetch(),
                                                   "isDone":repository.fetchDoneFilter()])
        if let customCell = mainView.tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as? AddTableViewCell {
            if let image = customCell.selectedImageView.image {
                saveImageToDocument(image: image, fileName: "\(data.id)")
            }
        }
        
        
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
    
    func isContainImage() -> Bool {
        if let customCell = mainView.tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as? AddTableViewCell {
            if customCell.selectedImageView.image != nil {
                return true
            }
        }
        return false
    }
}


extension AddViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
            } else {
                if inputString[indexPath.row] != nil {
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
            let section = indexPath.section - 1
            let row = indexPath.row
            
            if indexPath.section != 4 {
                cell.subTitleLabel.text = subTitleList[section]
                cell.selectedImageView.isHidden = true
            } else {
                cell.subTitleLabel.text = ""
                // 왜 이미지가 저장됐는데 뷰에 안 나오지..
                // 다행히 도큐먼트에는 저장이 된다!!!
                print("test!!!!!!!!!!!")
                if let selectedImage = selectedImage {
                    print(selectedImage)
                    cell.selectedImageView.image = selectedImage.withRenderingMode(.alwaysTemplate)

                } else {
                    cell.selectedImageView.image = UIImage(systemName: "star")
                }
            }
            
            cell.label.text = sectionTitleList[section]
            cell.accessoryType = .disclosureIndicator
            return cell
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            break
            
        default:
            let cell = tableView.cellForRow(at: indexPath) as! AddTableViewCell
            if indexPath.section == 1 { // delegate 값 전달
                let vc = DateViewController()
                vc.delegate = self
                transition(style: .push, viewController: vc)
                
            } else if indexPath.section == 2 { // closure 값 전달
                let vc = TagViewController()
                
                vc.money = { value in
                    self.subTitleList[1] = value
                    
                    cell.subTitleLabel.text = self.subTitleList[1]
                    self.tag = self.subTitleList[1]
                }
                
                transition(style: .push, viewController: vc)
                
            } else if indexPath.section == 3 { // delegate 값전달
                let vc = PriorityViewController()
                vc.delegate = self
                transition(style: .push, viewController: vc)
                
            } else {
                let vc = UIImagePickerController()
                vc.allowsEditing = true
                vc.delegate = self
                transition(style: .present, viewController: vc)
            }
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
        
        subTitleList[2] = priotyList[priorty].priorityTitle
        mainView.tableView.reloadData()
    }
    
    func dateReceived(text: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy / MM / dd"
        formatter.locale = Locale(identifier: "ko-KR")
        
        if let date = formatter.date(from: text) {
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
        }
        mainView.tableView.reloadData()
        dismiss(animated: true)
        
    }
}
