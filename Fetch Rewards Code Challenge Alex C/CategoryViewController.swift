//
//  ViewController.swift
//  Fetch Rewards Code Challenge Alex C
//
//  Created by Alex Constancio on 9/27/21.
//

import UIKit

class CategoryViewController: UIViewController {
    
    fileprivate var categoryCellID = "categoryCellID"
    
    fileprivate var sortedCategories: [Category] = []
    fileprivate var searchedCategories: [Category] = []
    
    fileprivate var isSearching = false
    
    var searchBar: UISearchBar = {
        return UISearchBar()
    }()
        
    var tableView: UITableView = {
        return UITableView()
    }()
    
    let emptyTVLabel: UILabel = {
        let label = UILabel()
        label.text = "No recipes..."
        label.isHidden = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Recipes"
        
        setupTableView()
        setupSearchBar()
        fetchCategories()
        createSpinnerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    fileprivate func fetchCategories() {
        CategoryController.shared.fetchCategoryJSON() { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.sortedCategories = CategoryController.shared.categories.sorted(by: {$0.strCategory < $1.strCategory})
                    self.tableView.reloadData()
                }
            case .failure(_):
                print("Network fail")
            }
        }
    }
    
    fileprivate func setupTableView() {
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: categoryCellID)
        tableView.keyboardDismissMode = .interactive
        
        view.addSubview(tableView)
        
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, xPadding: 0, yPadding: 0)
        
        tableView.addSubview(emptyTVLabel)
        
        emptyTVLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: view.centerYAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, xPadding: 0, yPadding: 0)
    }
    
    func createSpinnerView() {
        let child = SpinnerViewController()

        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)

        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // then remove the spinner view controller
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
            
            self.tableView.isHidden = false
        }
    }
    
    fileprivate func setupSearchBar() {
        
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        
        navigationItem.titleView = searchBar
    }
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            
            if searchedCategories.count == 0 {
                emptyTVLabel.isHidden = false
            } else {
                emptyTVLabel.isHidden = true
            }
            
            return searchedCategories.count
        } else {
            return sortedCategories.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let recipeCell = tableView.dequeueReusableCell(withIdentifier: categoryCellID) as? CategoryTableViewCell else { return UITableViewCell() }
        recipeCell.selectionStyle = .none
        
        if isSearching {
            recipeCell.configure(with: searchedCategories[indexPath.row])
        } else {
            recipeCell.configure(with: sortedCategories[indexPath.row])
        }
        
        return recipeCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mealsVC = MealsViewController()
        
        if isSearching {
            let mealCategory = searchedCategories[indexPath.row]
            mealsVC.strCategory = mealCategory.strCategory
        } else {
            let mealCategory = sortedCategories[indexPath.row]
            mealsVC.strCategory = mealCategory.strCategory
        }
        
        navigationController?.pushViewController(mealsVC, animated: true)
    }
}

extension CategoryViewController: UISearchBarDelegate, UISearchDisplayDelegate, UISearchResultsUpdating {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        if searchBar.text == "" {
            isSearching = false
            searchedCategories.removeAll()
            tableView.reloadData()
        } else {
            isSearching = true
            searchedCategories = sortedCategories.filter({$0.strCategory.contains(searchBar.text ?? "")})
            tableView.reloadData()
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {}
}
