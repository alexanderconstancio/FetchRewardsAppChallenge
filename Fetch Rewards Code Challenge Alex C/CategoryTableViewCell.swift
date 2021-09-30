//
//  RecipeTableViewCell.swift
//  Fetch Rewards Code Challenge Alex C
//
//  Created by Alex Constancio on 9/27/21.
//

import Foundation
import UIKit

class CategoryTableViewCell: UITableViewCell {
    
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
        addSubview(arrowIcon)
        
        categoryImg.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, centerX: nil, centerY: centerYAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 40, height: 40, xPadding: 0, yPadding: 0)
        
        titleLabel.anchor(top: topAnchor, left: categoryImg.rightAnchor, bottom: nil, right: rightAnchor, centerX: nil, centerY: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0, xPadding: 0, yPadding: 0)
        
        arrowIcon.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, centerX: nil, centerY: centerYAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 15, height: 15, xPadding: 0, yPadding: 0)
    }
    
    func configure(with category: Category) {
            
        titleLabel.text = category.strCategory
        
        categoryImg.loadImage(urlString: category.strCategoryThumb)
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
    
    let arrowIcon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "right-arrow")
        return img
    }()
}
