//
//  AddTableViewCell.swift
//  Reminders
//
//  Created by 최서경 on 2/14/24.
//

import UIKit

class AddTableViewCell: BaseTableViewCell {
    let label = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(label)
    }
    
    override func configureConstraints() {
        label.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(20)
        }
    }
    
    override func configureView() {
        label.textColor = .white
        label.font = .systemFont(ofSize: 10)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
