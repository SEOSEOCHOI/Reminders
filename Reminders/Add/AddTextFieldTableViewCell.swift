//
//  AddTextFieldTableViewCell.swift
//  Reminders
//
//  Created by 최서경 on 2/14/24.
//

import UIKit

class AddTextFieldTableViewCell: BaseTableViewCell {

    let textView = UITextView()
    
    override func configureHierarchy() {
        contentView.addSubview(textView)
    }
    
    override func configureConstraints() {
        textView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    override func configureView() {
        textView.textColor = .white
        textView.font = .systemFont(ofSize: 15)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
