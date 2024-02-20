//
//  MainTableViewCell.swift
//  Reminders
//
//  Created by 최서경 on 2/20/24.
//

import UIKit
import SnapKit

class MainTableViewCell: BaseTableViewCell {
    let todoImageView = UIImageView()
    let titleLabel = TitleTextLabel()
    let countLabel = MemoTextLabel()
    
    override func configureHierarchy() {
        contentView.addSubview(todoImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
    }
    override func configureConstraints() {
        todoImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(15)
            make.height.equalTo(todoImageView.snp.width)
            make.leading.equalTo(contentView.snp.leading).inset(8)
            make.centerY.equalTo(titleLabel)
        }
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(16)
            make.leading.equalTo(todoImageView.snp.trailing).offset(8)
            make.trailing.equalTo(countLabel.snp.leading).offset(-8)
        }
        countLabel.snp.makeConstraints { make in
            make.size.equalTo(todoImageView)
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalTo(titleLabel)
        }
        setNeedsLayout()

    }
    override func setNeedsLayout() {
        todoImageView.layer.cornerRadius = todoImageView.frame.width / 2
        super.setNeedsLayout()
    }

    override func configureView() {
        todoImageView.backgroundColor = .systemPink
        todoImageView.contentMode = .scaleAspectFill
        self.accessoryType = .disclosureIndicator
    }
}
