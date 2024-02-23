//
//  MainView.swift
//  Reminders
//
//  Created by 최서경 on 2/14/24.
//

import UIKit
import SnapKit

class MainView: BaseView {
    let label = UILabel()
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: MainView.configureCollectionViewLayout())
        
        view.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        
        return view
    }()
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(label)
        addSubview(collectionView)
        addSubview(tableView)
    }
    
    override func configureLayout() {
        label.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(8)
        }
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(safeAreaLayoutGuide).dividedBy(2)
            make.top.equalTo(label.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(8)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        super.configureView()
        label.text = "전체"
        label.textColor = .lightGray
        label.font = .boldSystemFont(ofSize: 32)
    }

    static func configureCollectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 18
        let cellWidth = UIScreen.main.bounds.width - (spacing * 3)
        
        layout.itemSize = CGSize(width: cellWidth / 2, height: cellWidth / 4)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        layout.scrollDirection = .vertical
        
        return layout
    }
}
