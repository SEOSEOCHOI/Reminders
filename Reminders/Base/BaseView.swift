//
//  BaseView.swift
//  Reminders
//
//  Created by 최서경 on 2/14/24.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    func configureHierarchy() {  }
    func configureLayout() { }
    func configureView() {
        backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
