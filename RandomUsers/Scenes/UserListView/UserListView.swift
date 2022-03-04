//
//  UserListView.swift
//  RandomUsers
//
//  Created by Martin Lukacs on 01/03/2022.
//

import UIKit
import SnapKit

final class UserListView: UIView {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    lazy var refreshControl = UIRefreshControl()
    
    init() {
        super.init(frame: .zero)
        
        addSubviews()
        setUpConstraints()
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        let subviews = [collectionView]

        subviews.forEach {
            addSubview($0)
        }
    }
    
    func startLoading() {
        collectionView.isUserInteractionEnabled = false
    }
    
    func finishLoading() {
        collectionView.isUserInteractionEnabled = true
    }
    
    private func setUpConstraints() {        
    
        collectionView.snp.makeConstraints { make in
          make.leading.equalToSuperview()
          make.top.equalToSuperview()
          make.trailing.equalToSuperview()
          make.bottom.equalToSuperview()
        }
    }
    
    private func setUpViews() {
        collectionView.backgroundColor = .systemBackground
        collectionView.refreshControl = refreshControl

        refreshControl.tintColor = .label
        let myString = "Fetching User Data ..."
        let myAttribute = [NSAttributedString.Key.foregroundColor: UIColor.label]
        let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
        refreshControl.attributedTitle = myAttrString
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(80))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
