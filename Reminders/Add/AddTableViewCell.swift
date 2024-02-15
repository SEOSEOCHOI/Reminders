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
    
    override func configureHierarchy() {
        contentView.addSubview(label)
        contentView.addSubview(subTitleLabel)
    }
    
    override func configureConstraints() {
        label.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView).inset(16)
            make.top.equalTo(contentView).inset(8)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView).inset(16)
            make.top.equalTo(label.snp.bottom).offset(4)
            make.bottom.equalTo(contentView).inset(8)
            make.height.equalTo(20)
        }
    }
    
    override func configureView() {
        super.configureView()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15)
        
        subTitleLabel.textColor = .white
        subTitleLabel.font = .systemFont(ofSize: 13)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
