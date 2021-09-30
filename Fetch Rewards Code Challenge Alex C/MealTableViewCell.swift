//
//  MealTableViewCell.swift
//  Fetch Rewards Code Challenge Alex C
//
//  Created by Alex Constancio on 9/28/21.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupViews()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    fileprivate func setupViews() {
        addSubview(categoryImg)
        addSubview(titleLabel)
        
        categoryImg.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, centerX: nil, centerY: centerYAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 40, height: 40, xPadding: 0, yPadding: 0)
        
        titleLabel.anchor(top: topAnchor, left: categoryImg.rightAnchor, bottom: nil, right: rightAnchor, centerX: nil, centerY: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0, xPadding: 0, yPadding: 0)
    }
    
    func configure(with meal: Meal) {
            
        titleLabel.text = meal.strMeal
        
        categoryImg.loadImage(urlString: meal.strMealThumb)
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let categoryImg: CustomImageView = {
        let img = CustomImageView()
        img.layer.cornerRadius = 40/2
        img.layer.masksToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
}
