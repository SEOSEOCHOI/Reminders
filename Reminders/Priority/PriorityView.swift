//
//  PriorityView.swift
//  Reminders
//
//  Created by 최서경 on 2/14/24.
//

import UIKit
import SnapKit

class PriorityView: BaseView {

    lazy var prioritySegment = UISegmentedControl(items: priority)
    
    let priority: [String] = ["최고", "중간", "최저"]

    override func configureHierarchy() {
    addSubview(prioritySegment)
    }
    
    override func configureLayout() {
        prioritySegment.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        super.configureView()

    }
}
