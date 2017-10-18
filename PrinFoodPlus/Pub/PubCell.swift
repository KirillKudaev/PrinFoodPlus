//
//  PubCell.swift
//  PrinFoodPlus
//
//  Created by Kirill Kudaev on 10/17/17.
//  Copyright © 2017 Kirill Kudaev. All rights reserved.
//

import UIKit

class PubCell: UICollectionViewCell {
    
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
        label.font = UIFont.systemFont(ofSize: 36)
        return label
    }()
    
    let timesOpenLabel: UILabel = {
        let label = UILabel()
        label.text = "Couldn't download the times"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabels()
        setupSeparatorView()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLabels() {
        let stackView = UIStackView(arrangedSubviews: [mealNameLabel, timesOpenLabel])
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        
        self.addSubview(stackView)
        stackView.anchor(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 40, paddingLeft: 15, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    fileprivate func setupSeparatorView() {
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        addSubview(separatorView)
        separatorView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
}
