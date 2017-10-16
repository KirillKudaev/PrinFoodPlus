//
//  DiningCell.swift
//  PrinFoodPlus
//
//  Created by Kirill Kudaev on 10/16/17.
//  Copyright © 2017 Kirill Kudaev. All rights reserved.
//

import UIKit

class DiningCell: UICollectionViewCell {
    
    var mealName: String? {
        didSet {
            mealNameLabel.text = mealName
        }
    }
    
    var timesOpen: String? {
        didSet {
            timesOpenLabel.text = timesOpen
        }
    }
    
    let mealNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let timesOpenLabel: UILabel = {
        let label = UILabel()
        label.text = "Couldn't download the times"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(mealNameLabel)
        addSubview(timesOpenLabel)
        
        mealNameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 60, paddingLeft: 80, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        timesOpenLabel.anchor(top: mealNameLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 30, paddingLeft: 80, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
