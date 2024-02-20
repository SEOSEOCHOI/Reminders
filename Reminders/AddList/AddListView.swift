//
//  AddListView.swift
//  Reminders
//
//  Created by 최서경 on 2/20/24.
//

import UIKit
import SnapKit

class AddListView: BaseView {
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.register(AddListTableViewCell.self, forCellReuseIdentifier: AddListTableViewCell.identifier)
        view.register(AddDateTableViewCell.self, forCellReuseIdentifier: AddDateTableViewCell.identifier)
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        super.configureView()
        backgroundColor = .systemGray6
    }

}
