//
//  DetailsViewController.swift
//  Fetch Rewards Code Challenge Alex C
//
//  Created by Alex Constancio on 9/28/21.
//

import UIKit

class DetailsViewController: UIViewController {
    
    fileprivate var ingredientsTableView: UITableView = {
        return UITableView()
    }()
    
    fileprivate var ingredTVID = "ingredTVID"
    
    fileprivate var ingredientDict = [Int: String]()
    fileprivate var sortedIngredients = [String]()
    
    fileprivate var measurmentDict = [Int: String]()
    fileprivate var sortedMeasurments = [String]()
    
    var meal: Meal? {
        didSet {
            guard let meal = meal else { return }
            
            mealImg.loadImage(urlString: meal.strMealThumb)
            mealTitle.text = meal.strMeal
            
            DetailController.shared.mealID = meal.idMeal
            print(meal.idMeal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMealDetails()
    }
    
    fileprivate func setupViews() {
        view.addSubview(mealImg)
        view.backgroundColor = .white
        mealImg.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 150, xPadding: 0, yPadding: 0)
        
        view.addSubview(mealAreaLabel)
        mealAreaLabel.anchor(top: mealImg.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: mealImg.centerXAnchor, centerY: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, xPadding: 0, yPadding: 0)
        
        view.addSubview(mealTitle)
        mealTitle.anchor(top: mealImg.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 30, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 0, xPadding: 0, yPadding: 0)
        
        view.addSubview(ingredientsTableView)
        ingredientsTableView.anchor(top: mealTitle.bottomAnchor, left: view.centerXAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 30, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, xPadding: 0, yPadding: 0)
        
        view.addSubview(mealInstructions)
        mealInstructions.anchor(top: mealTitle.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: ingredientsTableView.leftAnchor, centerX: nil, centerY: nil, paddingTop: 40, paddingLeft: 10, paddingBottom: 20, paddingRight: -5, width: 0, height: 0, xPadding: 0, yPadding: 0)
        
        view.addSubview(instructionLabel)
        instructionLabel.anchor(top: nil, left: mealInstructions.leftAnchor, bottom: mealInstructions.topAnchor, right: nil, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, xPadding: 0, yPadding: 0)
    }
    
    fileprivate func setupTableView() {
        
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.register(IngredientTableCell.self, forCellReuseIdentifier: ingredTVID)
    }
    
    let mealImg: CustomImageView = {
        let img = CustomImageView()
        img.layer.cornerRadius = 150/2
        img.layer.masksToBounds = true
        return img
    }()
    
    let mealTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let mealAreaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let mealInstructions: UITextView = {
        let view = UITextView()
        view.isEditable = false
        return view
    }()
    
    let instructionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Instructions & Ingredients"
        return label
    }()
}

extension DetailsViewController {
    
    fileprivate func fetchMealDetails() {
        DetailController.shared.fetchCategoryJSON() { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    guard let details = DetailController.shared.details else { return }
                    self.layoutMealDetails(details: details)
                    
                    self.mealInstructions.text = details.strInstructions
                    self.mealAreaLabel.text = details.strArea
                    self.setupViews()
                }
            case .failure(_):
                print("Network fail")
            }
        }
    }
    
    fileprivate func layoutMealDetails(details: Details) {
        do {
            let detailList = try details.allProperties()
            
            detailList.forEach { key, value in
                
                if key.contains("strIngredient") {
                    guard let value = value as? String else { return }
                    if value != "" {
                        guard let orderNumber = Int(key.westernArabicNumeralsOnly) else { return }
                        ingredientDict[orderNumber] = value
                        setupTableView()
                    }
                }
                
                if key.contains("strMeasure") {
                    guard let value = value as? String else { return }
                    guard let orderNumber = Int(key.westernArabicNumeralsOnly) else { return }
                    measurmentDict[orderNumber] = value
                }
            }
            
            let sortedIngDicts = ingredientDict.sorted(by: { $0.0 < $1.0 })
            
            sortedIngDicts.forEach { key, value in
                sortedIngredients.append(value)
                ingredientsTableView.reloadData()
            }
            
            let sortedMeasDicts = measurmentDict.sorted(by: { $0.0 < $1.0 })
            
            sortedMeasDicts.forEach { key, value in
                sortedMeasurments.append(value)
                ingredientsTableView.reloadData()
            }
            
        } catch {
            print("List error")
        }
    }
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let ingredientCell = tableView.dequeueReusableCell(withIdentifier: ingredTVID) as? IngredientTableCell else { return UITableViewCell() }
        let ingredient = sortedIngredients[indexPath.row]
        let measurment = sortedMeasurments[indexPath.row]
        
        ingredientCell.titleLabel.text = ingredient
        ingredientCell.measurementLabel.text = measurment
        return ingredientCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
