//
//  BannerCollectionViewCell.swift
//  CubeStore
//
//  Created by Ravil on 26.07.2023.
//

import UIKit

final class BannerCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = String(describing: BannerCollectionViewCell.self)
    
    // MARK: - UI
    
    private lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bannerImage")
        imageView.contentMode = .scaleAspectFill 
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        contentView.addSubview(bannerImageView)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bannerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
