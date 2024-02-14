//
//  DateViewController.swift
//  Reminders
//
//  Created by 최서경 on 2/14/24.
//

import UIKit

class DateViewController: BaseViewController {
    let mainView = DateView()
    
    var delegate: PassDataDelegate?
    
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.datePicker.addTarget(self, action: #selector(dateValueChange), for: .valueChanged)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        delegate?.dateReceived(text: mainView.dateTextField.text!)
    }

    @objc func dateValueChange(_ sender: UIDatePicker) {
        mainView.dateTextField.text = mainView.changeDateFormat(date: sender.date)
    }
}
