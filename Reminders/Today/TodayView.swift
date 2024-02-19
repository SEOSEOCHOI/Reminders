//
//  TodayView.swift
//  Reminders
//
//  Created by 최서경 on 2/19/24.
//

import UIKit
import SnapKit

class TodayView: BaseView {
    let countLabel = UILabel()
    override func configureHierarchy() {
        addSubview(countLabel)
    }
    
    override func configureLayout() {
        countLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(300)
        }
    }
    
    override func configureView() {
    }
}
