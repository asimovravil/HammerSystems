//
//  CategoryTableViewCell.swift
//  HammerSystems
//
//  Created by Ravil on 13.01.2024.
//

import UIKit

final class CategoryTableViewCell: UITableViewCell {
    
    // MARK: - PROPERTY
    
    static let reuseID = String(describing: CategoryTableViewCell.self)
    var selectedCategoryIndex: IndexPath?
    let sections: [CategorySection] = [.categoryCollection]
    let categories = ["Recipes", "Products", "Menu Items", "Custom"]
    
    // MARK: - UI
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        contentView.addSubview(collectionView)
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    // MARK: - Create Layout
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            let section = self?.sections[sectionIndex] ?? .categoryCollection
            switch section {
            case .categoryCollection:
                return self?.categorySectionLayout()
            }
        }
    }
    
    // MARK: - Section Layout
    
    private func categorySectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(88),
                heightDimension: .absolute(32)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 16,
            bottom: 0,
            trailing: 16
        )
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
}

extension CategoryTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .categoryCollection:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCell.reuseID,
                for: indexPath
            ) as? CategoryCell else {
                fatalError("Could not cast to CategoryCell")
            }
            
            updateCellStyle(cell, for: indexPath)
            
            cell.categoryLabel.text = categories[indexPath.item]
            updateCellStyle(cell, for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .categoryCollection:
            return categories.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategoryIndex = indexPath
        collectionView.reloadData()
    }
    
    private func updateCellStyle(_ cell: CategoryCell, for indexPath: IndexPath) {
        if indexPath == selectedCategoryIndex {
            cell.cardView.backgroundColor = UIColor(named: "pinkCustom")?.withAlphaComponent(0.40)
            cell.categoryLabel.textColor = UIColor(named: "pinkCustom")
            cell.categoryLabel.font = UIFont(name: "SFProDisplay-Bold", size: 13)
            cell.cardView.layer.borderColor = UIColor(named: "pinkCustom")?.withAlphaComponent(0.40).cgColor
            cell.cardView.layer.borderWidth = 0
        } else {
            cell.cardView.backgroundColor = UIColor(named: "background")
            cell.categoryLabel.textColor = UIColor(named: "pinkCustom")?.withAlphaComponent(0.40)
            cell.categoryLabel.font = UIFont(name: "SFProDisplay-Regular", size: 13)
            cell.cardView.layer.borderColor = UIColor(named: "pinkCustom")?.withAlphaComponent(0.40).cgColor
            cell.cardView.layer.borderWidth = 1
        }
    }
}
