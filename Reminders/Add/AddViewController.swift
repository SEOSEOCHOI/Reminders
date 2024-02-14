//
//  AddViewController.swift
//  Reminders
//
//  Created by 최서경 on 2/14/24.
//

import UIKit

protocol PassDataDelegate {
    func priorityReceived(text: String)
    func dateReceived(text: String)
}

class AddViewController: BaseViewController {

    
    let mainView = AddView()

    override func loadView() {
        self.view = mainView
    }
    // var addList = ["마감일","태그", "우선 순위", "이미지 추가"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
    }
    
    func configureNavigation() {
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonClicked))
        let addButtom = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonClicked))

        navigationItem.title = "새로운 할 일"
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = addButtom
    }
    
    @objc func cancelButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func addButtonClicked() {
        print(#function)
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
            cell.textView.delegate = self
            
            cell.backgroundColor = .lightGray
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddTableViewCell.identifier, for: indexPath) as! AddTableViewCell
            
            cell.accessoryType = .disclosureIndicator

            if indexPath.section == 1 {
                cell.label.text = "마감일"
            } else if indexPath.section == 2 {
                cell.label.text = "태그"
            } else if indexPath.section == 3 {
                cell.label.text = "우선순위"
            } else {
                cell.label.text = "이미지 추가"
            }
            
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
        let cell = tableView.cellForRow(at: indexPath)
        switch indexPath.section {
        case 0:
            break
            
        default:
            if indexPath.section == 1 { // delegate 값 전달
                let vc = DateViewController()
                
                vc.delegate = self
                
                transition(style: .push, viewController: vc)
                
            } else if indexPath.section == 2 { // closure 값 전달 왜 안되지
                let vc = TagViewController()
                
                vc.money = { value in
                    print(value)
            }
            
            transition(style: .push, viewController: vc)
                
            } else if indexPath.section == 3 { // delegate 값전달
                let vc = PriorityViewController()
                vc.delegate = self
                transition(style: .push, viewController: vc)
                
            } else {
                transition(style: .push, viewController: AddImageViewController())
            }
        }
    }
}

// TODO: TextViewPlaceHolder
extension AddViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "내용을 입력해 주세요"
            textView.textColor = .lightGray
        }
    }
    
    // 텍스트 커서가 시작하는 순간. 편집이 시작될 때
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
}

extension AddViewController: PassDataDelegate {
    func priorityReceived(text: String) {
        print(text)
    }
    
    func dateReceived(text: String) {
        print(text)
    }
}
