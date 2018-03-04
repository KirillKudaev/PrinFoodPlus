//
//  TodayTomorrowHeader.swift
//  PrinFoodPlus
//
//  Created by Kirill Kudaev on 3/3/18.
//  Copyright © 2018 Kirill Kudaev. All rights reserved.
//

import UIKit
import Firebase

protocol TodayTomorrowHeaderDelegate {
    func didChangeDay(tomorrow: Bool)
}

class TodayTomorrowHeader: UICollectionViewCell {
    
    var delegate: TodayTomorrowHeaderDelegate?
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainBlue()
        label.text = Date.getFormattedDate(tomorrow: false)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 26, weight: UIFont.Weight.light)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSegmentedControl()
        
        addSubview(dateLabel)
        dateLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 60, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        backgroundColor = UIColor.mainLightBlue()
    }
    
    private func addSegmentedControl() {
        // Initialize
        let items = ["Today", "Tomorrow"]
        let customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0
        
        // Set up Frame and SegmentedControl
        let frame = UIScreen.main.bounds
        customSC.frame = CGRect(x: frame.minX + 30, y: 16, width: frame.width - 60, height: 34)
        
        // Style the Segmented Control
        customSC.layer.cornerRadius = 5.0  // Don't let background bleed
        customSC.backgroundColor = .mainLightBlue()
        customSC.tintColor = .white
        
        // Add target action method
        customSC.addTarget(self, action: #selector(updateInfo), for: .valueChanged)
        
        // Add this custom Segmented Control to our view
        self.addSubview(customSC)
    }
    
    @objc private func updateInfo(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            dateLabel.text = Date.getFormattedDate(tomorrow: false)
            delegate?.didChangeDay(tomorrow: false)
        case 1:
            dateLabel.text = Date.getFormattedDate(tomorrow: true)
            delegate?.didChangeDay(tomorrow: true)
        default:
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

