//
//  MainCollectionViewCell.swift
//  Reminders
//
//  Created by 최서경 on 2/15/24.
//

import UIKit
import SnapKit

class MainCollectionViewCell: BaseCollectionViewCell {
    let statusLabel = UILabel()
    let countLabel = UILabel()
    let statusImageView = UIImageView()
    
    override func configureHierarchy() {
        addSubview(statusLabel)
        addSubview(countLabel)
        addSubview(statusImageView)
    }
    
    override func configureConstraints() {
        statusLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            make.top.equalTo(statusImageView.snp.bottom).offset(8)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(10)
        }
        
        countLabel.snp.makeConstraints { make in
            make.trailing.top.equalTo(safeAreaLayoutGuide).inset(10)
            make.height.equalTo(safeAreaLayoutGuide).dividedBy(2)
            make.width.equalTo(statusImageView.snp.height)
        }
        
        statusImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).inset(8)
            make.height.equalTo(safeAreaLayoutGuide).dividedBy(2)
            make.width.equalTo(statusImageView.snp.height)
        }
    }
    
    override func configureView() {
        statusLabel.textColor = .lightGray
        statusLabel.font = .boldSystemFont(ofSize: 15)
        
        countLabel.textColor = .white
        countLabel.font = .boldSystemFont(ofSize: 32)
        countLabel.textAlignment = .center
        
        statusImageView.tintColor = .white
        DispatchQueue.main.async {
            self.statusImageView.layer.cornerRadius = self.statusImageView.frame.width / 2
        }
        statusImageView.contentMode = .scaleAspectFit
        statusImageView.clipsToBounds = true
        // 이미지가 너무 꽉차는데,...ㅠ

    }
}
