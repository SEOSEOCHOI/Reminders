//
//  PriorityLabel.swift
//  Reminders
//
//  Created by 최서경 on 2/20/24.
//

import UIKit

class PriorityTextLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    func configureView() {
        self.font = .systemFont(ofSize: 11)
        textAlignment = .left
        numberOfLines = 2
        backgroundColor = .clear
        textColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
