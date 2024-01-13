//
//  BannerCell.swift
//  CubeStore
//
//  Created by Ravil on 26.07.2023.
//

import UIKit

final class BannerCell: UICollectionViewCell {
    
    static let reuseID = String(describing: BannerCell.self)
    
    // MARK: - UI
    
    public lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bannerImage1")
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        contentView.addSubview(bannerImageView)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bannerImageView.heightAnchor.constraint(equalToConstant: 112),
        ])
    }
}
