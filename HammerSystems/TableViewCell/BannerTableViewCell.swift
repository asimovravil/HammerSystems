//
//  BannerTableViewCell.swift
//  HammerSystems
//
//  Created by Ravil on 13.01.2024.
//

import UIKit

final class BannerTableViewCell: UITableViewCell {
    
    static let reuseID = String(describing: BannerTableViewCell.self)
    let collectionSection: [BannerSection] = [.bannerCollection]
    
    // MARK: - UI
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.reuseID)
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
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
        ])
    }
    
    // MARK: - Create Layout
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            let section = self?.collectionSection[sectionIndex] ?? .bannerCollection
            switch section {
            case .bannerCollection:
                return self?.bannerSectionLayout()
            }
        }
    }
    
    // MARK: - Section Layout
    
    private func bannerSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(300),
                heightDimension: .absolute(112)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
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

extension BannerTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = collectionSection[indexPath.section]
        switch section {
        case .bannerCollection:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BannerCell.reuseID,
                for: indexPath
            ) as? BannerCell else {
                fatalError("Could not cast to BannerCell")
            }
            if indexPath.item == 0 {
                cell.bannerImageView.image = UIImage(named: "bannerImage1")
            } else if indexPath.item == 1 {
                cell.bannerImageView.image = UIImage(named: "bannerImage2")
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = collectionSection[section]
        switch section {
        case .bannerCollection:
            return 2
        }
    }
}
