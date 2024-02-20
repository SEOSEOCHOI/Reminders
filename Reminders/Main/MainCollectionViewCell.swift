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
    var statusImageView = UIImageView(frame: .zero)
    
    // statusImageView는MainCollectionViewCell이 초기화되ㅏㄹ때만들어딤
    // 셀이초기화될떄 크기를 모름
    
    override func configureHierarchy() {
        addSubview(statusLabel)
        addSubview(countLabel)
        addSubview(statusImageView)
    }
    
    override func configureConstraints() {
        statusLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.top.equalTo(statusImageView.snp.bottom).offset(8)
//            make.bottom.equalToSuperview().inset(10)
        }
        
        countLabel.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(10)
            make.height.equalToSuperview().dividedBy(3)
            make.width.equalTo(countLabel.snp.height)
        }
        
        statusImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(10)
            make.height.equalToSuperview().dividedBy(3)
            make.width.equalTo(statusImageView.snp.height)
        }
    }
//
//    override func setNeedsDisplay() {
//        super.setNeedsDisplay()
//        print(#function, statusImageView.frame.size)
//
//    }
//    override func layoutIfNeeded() {
//        super.layoutIfNeeded()
//        print(#function, statusImageView.frame.size)
//    }
//    override func setNeedsLayout() {
//        super.setNeedsLayout()
//        print(#function, statusImageView.frame.size)
////        statusImageView.layer.cornerRadius = statusImageView.frame.height / 2
////        super.setNeedsLayout()
//    }
//    override func setNeedsUpdateConstraints() {
//        super.setNeedsUpdateConstraints()
//        print(#function, statusImageView.frame.size)
//
//    }
    
    
    override func configureView() {
        print(#function, statusImageView.frame.size)
        statusLabel.textColor = .lightGray
        statusLabel.font = .boldSystemFont(ofSize: 15)
        
        countLabel.textColor = .white
        countLabel.font = .boldSystemFont(ofSize: 32)
        countLabel.textAlignment = .center
        countLabel.backgroundColor = .red
        
        statusImageView.tintColor = .white
        
        print(1)
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
  
        

            print(2)
            print(3)
        statusImageView.contentMode = .center
        statusImageView.clipsToBounds = true
    }
}
