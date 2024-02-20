//
//  TagViewController.swift
//  Reminders
//
//  Created by 최서경 on 2/14/24.
//

import UIKit

class TagViewController: BaseViewController, UITextFieldDelegate {
    let mainView = TagView()
    
    var tagText: ((String) -> Void)?
    var tagInput: String = ""
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tagTextField.text = tagInput
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.tagTextField.becomeFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let text = mainView.tagTextField.text {
            tagText?(text)
        }
    }
}
