//
//  AddTableViewCell.swift
//  Reminders
//
//  Created by 최서경 on 2/14/24.
//

import UIKit

class AddTableViewCell: BaseTableViewCell {
    let label = UILabel()
    let subTitleLabel = UILabel()
    let selectedImageView = UIImageView()
    
    override func configureHierarchy() {
        contentView.addSubview(label)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(selectedImageView)
    }
    
    override func configureConstraints() {
        label.snp.makeConstraints { make in
            make.leading.equalTo(contentView).inset(16)
            make.top.equalTo(contentView).inset(8)
            make.trailing.equalTo(selectedImageView.snp.leading).offset(-8)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).inset(16)
            make.top.equalTo(label.snp.bottom).offset(4)
            make.bottom.equalTo(contentView).inset(8)
            make.trailing.equalTo(selectedImageView.snp.leading).offset(-8)
            make.height.equalTo(20)
        }
        selectedImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(contentView.snp.trailing).inset(8)
            make.size.equalTo(20)
                //make.verticalEdges.equalTo(8)
        }
    }
    
    override func configureView() {
        super.configureView()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15)
        
        subTitleLabel.textColor = .white
        subTitleLabel.font = .systemFont(ofSize: 13)
        
        selectedImageView.clipsToBounds = true
        selectedImageView.contentMode = .scaleAspectFill
        self.accessoryType = .disclosureIndicator
    }


}
