//
//  SelectListView.swift
//  Reminders
//
//  Created by 최서경 on 2/21/24.
//

import UIKit
import SnapKit

class SelectListView: BaseView {
    let tableView: UITableView = {
        let view = UITableView()
        view.register(UITableViewCell.self, forCellReuseIdentifier: (SelectListView.identifier + "Cell"))
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(tableView)
    }
    override func configureView() {
super.configureView()
    }
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
