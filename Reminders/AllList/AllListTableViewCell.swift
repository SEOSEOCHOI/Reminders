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
    let priorityImageView = UILabel()
    let tagLabel = UILabel()
    
    
    override func configureHierarchy() {
        addSubview(contentView)
        contentView.addSubview(doneButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priorityImageView)
        contentView.addSubview(endDateLabel)
        contentView.addSubview(memoLabel)
        contentView.addSubview(tagLabel)
        
        doneButton.backgroundColor = .lightGray
        titleLabel.backgroundColor = .red
        endDateLabel.backgroundColor = .blue
        memoLabel.backgroundColor = .green
        priorityImageView.backgroundColor = .brown
        tagLabel.backgroundColor = .purple
        
    }
    
    override func configureConstraints() {
        let horizentalSpacing = CGFloat(8)
        let verticalSpacing = CGFloat(4)
        let ineerSpacing = CGFloat(4)
        doneButton.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(horizentalSpacing)
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(verticalSpacing)
            make.size.equalTo(30)
        }
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(priorityImageView.snp.trailing).offset(ineerSpacing)
            make.trailing.equalToSuperview().inset(horizentalSpacing)
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(verticalSpacing)
            make.height.equalTo(30)
        }
        memoLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(horizentalSpacing)
            make.top.equalTo(titleLabel.snp.bottom).offset(verticalSpacing)
        }
        endDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(horizentalSpacing)
            make.top.equalTo(memoLabel.snp.bottom).offset(verticalSpacing)

        }
        // TODO: Hugging 적용
        priorityImageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        priorityImageView.snp.makeConstraints { make in
            make.leading.equalTo(doneButton.snp.trailing).offset(4)
            make.size.equalTo(24)
            make.centerY.equalTo(titleLabel)
        }
        tagLabel.snp.makeConstraints { make in
            make.leading.equalTo(memoLabel.snp.leading)
            make.top.equalTo(memoLabel.snp.bottom).offset(ineerSpacing)
            make.bottom.equalToSuperview().inset(verticalSpacing)
        }
    }
    
    override func configureView() {
        priorityImageView.contentMode = .scaleAspectFit
        titleLabel.numberOfLines = 0
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
