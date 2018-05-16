//
//  MenuCell.swift
//  PrinFoodPlus
//
//  Created by Kirill Kudaev on 10/16/17.
//  Copyright © 2017 Kirill Kudaev. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    var dishName: String? {
        didSet {
            var dishEmoji: String?
            
            switch dishType {
            case .vegetarian?:
                dishEmoji = "🌱"
            case .vegan?:
                dishEmoji = "🌿"
            default:
                break
            }
            
            dishNameLabel.text = "\(dishEmoji ?? "") \(dishName ?? "")"
        }
    }
    
    var dishType: DishType? {
        didSet {
            var dishEmoji: String?
            
            switch dishType {
            case .vegetarian?:
                dishEmoji = "🌱"
            case .vegan?:
                dishEmoji = "🌿"
            default:
                break
            }
            
            dishNameLabel.text = "\(dishEmoji ?? "") \(dishName ?? "")"
        }
    }

    let dishNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSeparatorView()

        addSubview(dishNameLabel)
        
        setUpDishLabelToAutoAdjustFontSize()
        
        dishNameLabel.anchor(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
        dishNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSeparatorView() {
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        addSubview(separatorView)
        separatorView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 14, paddingBottom: 0, paddingRight: 14, width: 0, height: 0.5)
    }
    
    fileprivate func setUpDishLabelToAutoAdjustFontSize() {
        dishNameLabel.numberOfLines = 1
        dishNameLabel.adjustsFontSizeToFitWidth = true
        dishNameLabel.minimumScaleFactor = 0.2
    }
}
