//
//  AddListTableViewCell.swift
//  Reminders
//
//  Created by 최서경 on 2/21/24.
//

import UIKit
import SnapKit

class AddListTableViewCell: BaseTableViewCell {
    var addImageView = UIImageView()
    let addTextField = UITextField()
    override func configureHierarchy() {
        contentView.addSubview(addImageView)
        contentView.addSubview(addTextField)
    }
    
    override func configureConstraints() {
        
        // TODO: 레이아웃이 왜 깨지지...ㅠ.ㅠㅠ.
        addImageView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalTo(addImageView.snp.height)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(16)
        }
        addTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.top.equalTo(addImageView.snp.bottom).offset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    
    override func configureView() {
        addImageView.backgroundColor = .lightGray
        addTextField.placeholder = "목록을 입력하세요"
        addTextField.borderStyle = .roundedRect
    }
    // TODO: 질문하기
//        override func setNeedsLayout() {
//            addImageView.layer.cornerRadius = addImageView.frame.width / 2
//            addImageView.clipsToBounds = true
//            super.setNeedsLayout()
//        }
    //    override func layoutIfNeeded() {
    //        addImageView.layer.cornerRadius = addImageView.frame.width / 2
    //        super.layoutIfNeeded()
    //    }
//        override func layoutSubviews() {
//            super.layoutSubviews()
//            addImageView.layer.cornerRadius = addImageView.frame.width / 2
//            addImageView.clipsToBounds = true
//        }
}
