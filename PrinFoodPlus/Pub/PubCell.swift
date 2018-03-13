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
        label.font = UIFont.systemFont(ofSize: 36, weight: UIFont.Weight.light)
        label.textColor = .white
        return label
    }()
    
    let timesOpenLabel: UILabel = {
        let label = UILabel()
        label.text = "Couldn't download time"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)
        label.textColor = .white
        return label
    }()
    
    let arrowImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "arrow_right")
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLabels()
        setUpSeparatorView()
        setUpArrowImageView()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setUpArrowImageView() {
        addSubview(arrowImageView)
        
        arrowImageView.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 30, width: 30, height: 30)
        arrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    fileprivate func setUpLabels() {
        let stackView = UIStackView(arrangedSubviews: [mealNameLabel, timesOpenLabel])
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        
        self.addSubview(stackView)
        stackView.anchor(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 40, paddingLeft: 15, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    fileprivate func setUpSeparatorView() {
        let separatorView = UIView()
        separatorView.backgroundColor = .white
        addSubview(separatorView)
        separatorView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0.5)
    }
}
