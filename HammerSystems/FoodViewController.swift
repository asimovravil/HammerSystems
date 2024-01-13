//
//  ViewController.swift
//  HammerSystems
//
//  Created by Ravil on 13.01.2024.
//

import UIKit

final class FoodViewController: UIViewController {
    
    // MARK: - PROPERTY
    
    let tableViewSection: [TableViewSection] = [.banner, .category, .main]
    
    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reuseID)
        tableView.register(BannerTableViewCell.self, forCellReuseIdentifier: BannerTableViewCell.reuseID)
        tableView.register(MainCell.self, forCellReuseIdentifier: MainCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(named: "background")
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.addSubview(tableView)
        view.backgroundColor = UIColor(named: "background")
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension FoodViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewSection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = tableViewSection[indexPath.section]
        switch section {
        case .banner:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BannerTableViewCell.reuseID, for: indexPath) as? BannerTableViewCell else {
                fatalError("Could not cast to BannerTableViewCell")
            }
            cell.backgroundColor = UIColor(named: "background")
            return cell
        case .category:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reuseID, for: indexPath) as? CategoryTableViewCell else {
                fatalError("Could not cast to CategoryTableViewCell")
            }
            cell.backgroundColor = UIColor(named: "background")
            return cell
        case .main:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.reuseID, for: indexPath) as? MainCell else {
                fatalError("Could not cast to MainCell")
            }
            cell.backgroundColor = UIColor(named: "background")
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = tableViewSection[section]
        switch sectionType {
        case .banner:
            return 1
        case .category:
            return 1
        case .main:
            return 20
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = tableViewSection[indexPath.section]
        switch sectionType {
        case .banner:
            return 136.0
        case .category:
            return 56.0
        case .main:
            return 180.0
        }
    }
}
