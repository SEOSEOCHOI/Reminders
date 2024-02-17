//
//  ListTableViewCell.swift
//  Reminders
//
//  Created by 최서경 on 2/17/24.
//

import UIKit

class AllListTableViewCell: BaseTableViewCell {
    let doneButton = UIButton()
    let titleLabel = UILabel()
    let endDateLabel = UILabel()
    let memoLabel = UILabel()
    let priorityLabel = UILabel()
    let tagLabel = UILabel()
    
    override func configureHierarchy() {
        addSubview(doneButton)
        addSubview(titleLabel)
        addSubview(endDateLabel)
        addSubview(memoLabel)
        addSubview(priorityLabel)
        addSubview(tagLabel)
    }
    
    override func configureConstraints() {
        doneButton.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).inset(8)
            make.top.equalTo(safeAreaLayoutGuide).inset(4)
        }
    }
    
    override func configureView() {
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
