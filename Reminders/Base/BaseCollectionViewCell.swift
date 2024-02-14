//
//  BaseCollectionViewCell.swift
//  Reminders
//
//  Created by 최서경 on 2/15/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureConstraints()
        configureView()
    }
    
    func configureHierarchy() {
    }
    
    func configureConstraints() {
    }
    
    func configureView() {
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
