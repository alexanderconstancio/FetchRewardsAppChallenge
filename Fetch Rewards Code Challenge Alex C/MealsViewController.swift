//
//  MealsViewController.swift
//  Fetch Rewards Code Challenge Alex C
//
//  Created by Alex Constancio on 9/28/21.
//

import UIKit

class MealsViewController: UIViewController {
    
    var strCategory: String? {
        didSet {
            guard let strCategory = strCategory else {
                return
            }
            title = "\(strCategory) Recipes"
            
            MealController.shared.strCategory = strCategory
        }
    }
    
    fileprivate var mealCellID = "mealCellID"
    
    fileprivate var sortedMeals: [Meal] = []
    fileprivate var searchedMeals: [Meal] = []
    
    var searchBar: UISearchBar = {
        return UISearchBar()
    }()
        
    fileprivate var tableView: UITableView = {
        return UITableView()
    }()
    
    fileprivate var isSearching = false
    
    let emptyTVLabel: UILabel = {
        let label = UILabel()
        label.text = "No recipes..."
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        fetchMeals()
    }
    
    fileprivate func fetchMeals() {
        sortedMeals = []
        MealController.shared.fetchMealJSON() { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.sortedMeals = MealController.shared.meals.sorted(by: {$0.strMeal < $1.strMeal})
                    self.tableView.reloadData()
                }
            case .failure(_):
                print("Network fail")
            }
        }
    }
    
    fileprivate func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MealTableViewCell.self, forCellReuseIdentifier: mealCellID)
        
        view.addSubview(tableView)
        
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, xPadding: 0, yPadding: 0)
        
        tableView.addSubview(emptyTVLabel)
        
        emptyTVLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: view.centerYAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, xPadding: 0, yPadding: 0)
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

extension MealsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {

            if searchedMeals.count == 0 {
                emptyTVLabel.isHidden = false
            } else {
                emptyTVLabel.isHidden = true
            }

            return searchedMeals.count
        } else {
            return sortedMeals.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let mealCell = tableView.dequeueReusableCell(withIdentifier: mealCellID) as? MealTableViewCell else { return UITableViewCell() }
        mealCell.selectionStyle = .none
        if isSearching {
            mealCell.configure(with: searchedMeals[indexPath.row])
        } else {
            mealCell.configure(with: sortedMeals[indexPath.row])
        }

        return mealCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController()
        if isSearching {
            detailsVC.meal = searchedMeals[indexPath.row]
        } else {
            detailsVC.meal = sortedMeals[indexPath.row]
        }
        
        navigationController?.present(detailsVC, animated: true)
    }
}

extension MealsViewController: UISearchBarDelegate, UISearchDisplayDelegate, UISearchResultsUpdating {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        if searchBar.text == "" {
            isSearching = false
            tableView.reloadData()
        } else {
            isSearching = true
            searchedMeals = sortedMeals.filter({$0.strMeal.contains(searchBar.text ?? "")})
            tableView.reloadData()
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
