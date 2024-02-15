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
    var statusImageView = UIImageView()
    
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
            make.width.equalTo(countLabel.snp.height)
        }
        
        statusImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).inset(8)
            print(4)
            make.height.equalTo(50)
            print(5)
            make.width.equalTo(50)
            print(6)
        }
    }
    
    override func configureView() {
        statusLabel.textColor = .lightGray
        statusLabel.font = .boldSystemFont(ofSize: 15)
        
        countLabel.textColor = .white
        countLabel.font = .boldSystemFont(ofSize: 32)
        countLabel.textAlignment = .center
        countLabel.backgroundColor = .red
        
        statusImageView.tintColor = .white
        print(1)
        /*
         contentsize가 모두 잡힌 이후에...
         layout 시점
         draw시점
         constraints시점
         어느 시점에 실행되는지
         */

            print(2)
            print(3)
        statusImageView.contentMode = .center
        statusImageView.clipsToBounds = true

        
        let config = UIImage.SymbolConfiguration(scale: .large)
        statusImageView.preferredSymbolConfiguration = config
    }
}
