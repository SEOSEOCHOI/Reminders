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
    
    // statusImageView는MainCollectionViewCell이 초기화되ㅏㄹ때만들어딤
    // 셀이초기화될떄 크기를 모름
    
    override func configureHierarchy() {
        contentView.addSubview(statusLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(statusImageView)
    }
    
    override func configureConstraints() {
        statusImageView.snp.makeConstraints { make in
            make.height.equalToSuperview().dividedBy(3)
            make.width.equalTo(statusImageView.snp.height)
            make.top.leading.equalToSuperview().inset(10)
            print("1",statusImageView.frame.size)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.top.equalTo(statusImageView.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(10)
        }
        
        countLabel.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(10)
            make.height.equalToSuperview().multipliedBy(0.3)
            make.leading.equalTo(statusImageView.snp.trailing).offset(10)
        }
    }

    override func configureView() {
        statusLabel.textColor = .lightGray
        statusLabel.font = .boldSystemFont(ofSize: 15)
        statusLabel.textAlignment = .left
        
        countLabel.textColor = .white
        countLabel.font = .boldSystemFont(ofSize: 32)
        countLabel.textAlignment = .right
        
        statusImageView.tintColor = .white
        statusImageView.clipsToBounds = true
        statusImageView.contentMode = .scaleAspectFill
                /*
         Constraints -> Layout -> Draw
         
         Constraints: configurelayout NSConstraints
         
         
         contentsize가 모두 잡힌 이후에...
         layout 시점
         draw시점
         constraints시점
         어느 시점에 실행되는지
         */
        // 유동적인 사이즈를 잡는 게 아니라서.... 정해진 수치에서 그려주니까......
    }
}
