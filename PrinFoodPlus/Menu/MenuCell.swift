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
            
            dishNameLabel.text = "\(dishName ?? "") \(dishEmoji ?? "")"
            
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
            
            dishNameLabel.text = "\(dishName ?? "") \(dishEmoji ?? "")"
        }
    }

    let dishNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSeparatorView()

        addSubview(dishNameLabel)
        
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
        separatorView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
}
