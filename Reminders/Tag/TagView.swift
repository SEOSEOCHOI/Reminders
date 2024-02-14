//
//  TagView.swift
//  Reminders
//
//  Created by 최서경 on 2/14/24.
//

import UIKit
import SnapKit

class TagView: BaseView {
    let tagTextField = UITextField()
    
    
    override func configureHierarchy() {
        self.addSubview(tagTextField)
    }
    
    override func configureLayout() {
        tagTextField.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        super.configureView()

        tagTextField.backgroundColor = .white
        tagTextField.textColor = .black
    }
}
