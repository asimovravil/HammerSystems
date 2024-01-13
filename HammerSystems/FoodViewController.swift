//
//  ViewController.swift
//  HammerSystems
//
//  Created by Ravil on 13.01.2024.
//

import UIKit

final class FoodViewController: UIViewController {
    
    // MARK: - PROPERTY
    
    let sections: [SectionType] = [.banner, .category, .main]
    
    // MARK: - UI
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.reuseID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.addSubview(collectionView)
        view.backgroundColor = UIColor(named: "background")
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    // MARK: - Create Layout
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            let section = self?.sections[sectionIndex] ?? .banner
            switch section {
            case .banner:
                return self?.bannerSectionLayout()
            case .category:
                return self?.categorySectionLayout()
            case .main:
                return self?.mainSectionLayout()
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
                heightDimension: .absolute(160)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 16,
            bottom: 15,
            trailing: 16
        )
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        return section
    }
    
    private func categorySectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(300),
                heightDimension: .absolute(160)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 16,
            bottom: 15,
            trailing: 16
        )
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        return section
    }
    
    private func mainSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .absolute(296)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(296)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item, item]
        )
        
        group.interItemSpacing = .fixed(15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 16,
            bottom: 15,
            trailing: 16
        )
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        return section
    }
    
    // MARK: - Supplementary Header Item
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(43)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
    }
}

extension FoodViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .banner:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BannerCollectionViewCell.reuseID,
                for: indexPath
            ) as? BannerCollectionViewCell else {
                fatalError("Could not cast to BannerCollectionViewCell")
            }
            return cell
        case .category:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BannerCollectionViewCell.reuseID,
                for: indexPath
            ) as? BannerCollectionViewCell else {
                fatalError("Could not cast to BannerCollectionViewCell")
            }
            return cell
        case .main:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BannerCollectionViewCell.reuseID,
                for: indexPath
            ) as? BannerCollectionViewCell else {
                fatalError("Could not cast to BannerCollectionViewCell")
            }
            return cell
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .banner:
            return 3
        case .category:
            return 5
        case .main:
            return 10
        }
    }
}


