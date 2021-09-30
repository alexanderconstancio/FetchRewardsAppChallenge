//
//  IngredientTableCell.swift
//  Fetch Rewards Code Challenge Alex C
//
//  Created by Alex Constancio on 9/29/21.
//

import Foundation
import UIKit

class IngredientTableCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupViews()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    fileprivate func setupViews() {
        addSubview(categoryImg)
        addSubview(measurementLabel)
        addSubview(titleLabel)
        
        categoryImg.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, centerX: nil, centerY: centerYAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 40, height: 40, xPadding: 0, yPadding: 0)
        
        measurementLabel.anchor(top: nil, left: leftAnchor, bottom: nil, right: centerXAnchor, centerX: nil, centerY: centerYAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 5, width: 0, height: 0, xPadding: 0, yPadding: 0)
        
        titleLabel.anchor(top: nil, left: measurementLabel.rightAnchor, bottom: nil, right: rightAnchor, centerX: nil, centerY: centerYAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 5, width: 0, height: 0, xPadding: 0, yPadding: 0)
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.numberOfLines = 0
        return label
    }()
    
    let measurementLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.numberOfLines = 0
        label.textAlignment = .right
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
