//
//  DetailView.swift
//  Reminders
//
//  Created by 최서경 on 2/18/24.
//

import UIKit

class DetailView: BaseView {
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.register(AddTableViewCell.self, forCellReuseIdentifier: AddTableViewCell.identifier)
        view.register(AddTextFieldTableViewCell.self, forCellReuseIdentifier: AddTextFieldTableViewCell.identifier)
        view.backgroundColor = .clear
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
