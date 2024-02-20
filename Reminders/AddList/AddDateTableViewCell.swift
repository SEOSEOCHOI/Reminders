//
//  AddDateTableViewCell.swift
//  Reminders
//
//  Created by 최서경 on 2/21/24.
//

import UIKit
import SnapKit

class AddDateTableViewCell: BaseTableViewCell {
    let datePicker = UIDatePicker()

    override func configureHierarchy() {
        contentView.addSubview(datePicker)
    }
    override func configureConstraints() {
        datePicker.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(16)
            make.horizontalEdges.equalToSuperview().inset(16)

            make.centerX.equalToSuperview()
        }
    }
    override func configureView() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .automatic
    }
    

}
