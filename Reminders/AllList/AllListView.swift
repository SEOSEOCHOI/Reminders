//
//  List.swift
//  Reminders
//
//  Created by 최서경 on 2/17/24.
//

import UIKit
import SnapKit

class AllListView: BaseView {
    let tableView: UITableView = {
        let view = UITableView()
        view.register(AllListTableViewCell.self, forCellReuseIdentifier: AllListTableViewCell.identifier)
        
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
        tableView.backgroundColor = .purple
    }

}
