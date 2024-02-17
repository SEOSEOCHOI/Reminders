//
//  DateView.swift
//  Reminders
//
//  Created by 최서경 on 2/14/24.
//

import UIKit

class DateView: BaseView {
    let dateTextField = UITextField()
    let datePicker: UIDatePicker = {
       let view = UIDatePicker()
        view.datePickerMode = .date
        view.preferredDatePickerStyle = .inline
        view.locale = Locale(identifier: "ko-KR")

        return view
    }()

    override func configureHierarchy() {
        addSubview(dateTextField)        
    }
    
    override func configureLayout() {
        dateTextField.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        super.configureView()
        dateTextField.backgroundColor = .gray

        dateTextField.inputView = datePicker
    }
    
     func changeDateFormat (date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy / MM / dd"
        
         return formatter.string(from: datePicker.date)
    }
}
