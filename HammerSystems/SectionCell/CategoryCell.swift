//
//  CategoryCell.swift
//  HammerSystems
//
//  Created by Ravil on 13.01.2024.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    
    static let reuseID = String(describing: CategoryCell.self)
    
    // MARK: - UI
    
    private lazy var cardView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(named: "background")
        uiView.layer.borderColor = UIColor(named: "pinkCustom")?.withAlphaComponent(0.40).cgColor
        uiView.layer.borderWidth = 1
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Пицца"
        label.textAlignment = .center
        label.textColor = UIColor(named: "pinkCustom")?.withAlphaComponent(0.40)
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
        
        cardView.layer.cornerRadius = 16
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        [cardView, categoryLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardView.widthAnchor.constraint(equalToConstant: 88),
            cardView.heightAnchor.constraint(equalToConstant: 32),
            
            categoryLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            categoryLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
        ])
    }
}
