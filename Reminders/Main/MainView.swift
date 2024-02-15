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
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        view.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(label)
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        label.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(8)
        }
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            
            make.top.equalTo(label.snp.bottom).offset(8)
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
        let spacing: CGFloat = 8
        let cellWidth = UIScreen.main.bounds.width - (spacing * 3)
        
        layout.itemSize = CGSize(width: cellWidth / 2, height: cellWidth / 4)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        layout.scrollDirection = .vertical
        
        return layout
    }
}
