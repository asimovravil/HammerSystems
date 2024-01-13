//
//  MainCell.swift
//  HammerSystems
//
//  Created by Ravil on 13.01.2024.
//

import UIKit

final class MainCell: UICollectionViewCell {
    
    static let reuseID = String(describing: MainCell.self)
    
    // MARK: - UI
    
    private lazy var mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pizzaImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.text = "Ветчина и грибы"
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-SemiBold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mainSubTitle: UILabel = {
        let label = UILabel()
        label.text = "Ветчина,шампиньоны, увеличинная порция моцареллы, томатный соус"
        label.textAlignment = .left
        label.textColor = UIColor(named: "grayCustom")
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-Regular", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cardView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .white
        uiView.layer.borderColor = UIColor(named: "pinkCustom")?.cgColor
        uiView.layer.borderWidth = 1
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "от 345 р"
        label.textAlignment = .center
        label.textColor = UIColor(named: "pinkCustom")
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-Regular", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        
        cardView.layer.cornerRadius = 6
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        [mainImage, mainTitle, mainSubTitle, cardView, priceLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            mainImage.heightAnchor.constraint(equalToConstant: 132),
            mainImage.widthAnchor.constraint(equalToConstant: 132),
            
            mainTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            mainTitle.leadingAnchor.constraint(equalTo: mainImage.trailingAnchor, constant: 32),
            
            mainSubTitle.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 8),
            mainSubTitle.leadingAnchor.constraint(equalTo: mainImage.trailingAnchor, constant: 32),
            mainSubTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            cardView.widthAnchor.constraint(equalToConstant: 87),
            cardView.heightAnchor.constraint(equalToConstant: 32),
            
            priceLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            priceLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
        ])
    }
}
