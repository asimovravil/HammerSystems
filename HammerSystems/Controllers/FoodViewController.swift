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
    var allItems: [CategoryItem] = []
    let apiService = APIService()
    var categoryStartIndices: [String: Int] = [:]

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
        fetchData()
        loadDataFromLocalStorage()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.addSubview(tableView)
        view.backgroundColor = UIColor(named: "background")
        self.navigationController?.navigationBar.isHidden = true
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
    
    // MARK: - Fetch Data
    
    private func fetchData() {
        apiService.fetchSearchResults { [weak self] (result, error) in
            if let error = error {
                print("Ошибка при получении данных: \(error.localizedDescription)")
                print("Проверяем наличие сохраненных данных...")
                self?.loadDataFromLocalStorage()
                return
            }
            if let results = result?.searchResults {
                self?.allItems = results.flatMap { $0.results }
                self?.saveDataToLocalStorage(results: results)
                self?.prepareCategoryIndices(results: results)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    private func saveDataToLocalStorage(results: [CategoryResult]) {
        if let encoded = try? JSONEncoder().encode(results) {
            UserDefaults.standard.set(encoded, forKey: "cachedResults")
        }
    }

    private func loadDataFromLocalStorage() {
        if let savedResults = UserDefaults.standard.object(forKey: "cachedResults") as? Data {
            if let loadedResults = try? JSONDecoder().decode([CategoryResult].self, from: savedResults) {
                self.allItems = loadedResults.flatMap { $0.results }
                self.prepareCategoryIndices(results: loadedResults)
            }
        }
    }

    private func prepareCategoryIndices(results: [CategoryResult]) {
        var currentIndex = 0
        for categoryResult in results {
            categoryStartIndices[categoryResult.name] = currentIndex
            currentIndex += categoryResult.results.count
        }
    }
}

extension FoodViewController: UITableViewDataSource, UITableViewDelegate, CategoryTableViewCellDelegate {
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
        case .main:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.reuseID, for: indexPath) as? MainCell else {
                fatalError("Could not cast to MainCell")
            }
            let categoryItem = allItems[indexPath.row]
            cell.mainTitle.text = categoryItem.name
            cell.isFirstCell = indexPath.row == 0
            cell.backgroundColor = UIColor(named: "background")
            if let iconURL = URL(string: categoryItem.image) {
                cell.loadImage(from: iconURL)
            }
            return cell
        default:
            fatalError("Unexpected section")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = tableViewSection[section]
        switch sectionType {
        case .banner:
            return 1
        case .category:
            return 0
        case .main:
            return allItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = tableViewSection[indexPath.section]
        switch sectionType {
        case .banner:
            return 112.0
        case .category:
            return 32.0
        case .main:
            return 180.0
        }
    }
}

extension FoodViewController {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableViewSection[section] == .category {
            let headerView = CategoryTableViewCell()
            headerView.delegate = self
            return headerView
        }
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableViewSection[section] == .category {
            return 32.0
        }
        return 0
    }
    
    func didSelectCategory(atIndex index: Int) {
        let categoryNames = ["Recipes", "Products", "Menu Items"]
        guard index < categoryNames.count else { return }

        let categoryName = categoryNames[index]
        if let categoryIndex = categoryStartIndices[categoryName] {
            let indexPath = IndexPath(row: categoryIndex, section: 2)
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
}
