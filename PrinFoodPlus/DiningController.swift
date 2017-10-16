//
//  DiningController.swift
//  PrinFoodPlus
//
//  Created by Kirill Kudaev on 10/14/17.
//  Copyright © 2017 Kirill Kudaev. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class DiningController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Dining"

        collectionView?.backgroundColor = .white
        collectionView?.isScrollEnabled = false

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        fetchTimes(tomorrow: false)
        fetchTimes(tomorrow: true)
    }
    
    var todayTimes = [String: Any]()
    var tomorrowTimes = [String: Any]()
    fileprivate func fetchTimes(tomorrow: Bool) {
       
        guard let dayOfWeek = getDayOfWeek(tomorrow: tomorrow) else { return }
        Database.database().reference().child("diningTimes").child(dayOfWeek).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let times = snapshot.value as? [String: Any] else { return }
            if !tomorrow {
                self.todayTimes = times
            } else {
                self.tomorrowTimes = times
            }
            
            self.collectionView?.reloadData()

        }) { (err) in
            if !tomorrow {
                print("Failed to fetch dining times for today:", err)
            } else {
                print("Failed to fetch dining times for tomorrow:", err)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (view.frame.height - 98 - 2) / 3
        return CGSize(width: view.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        cell.backgroundColor = .orange
        
        return cell
    }
    
    fileprivate func getDayOfWeek(tomorrow :Bool)->String? {
        
        let weekDays: [Int: String] = [1: "Sunday",
                                       2: "Monday",
                                       3: "Tuesday",
                                       4: "Wednesday",
                                       5: "Thursday",
                                       6: "Friday",
                                       7: "Saturday"]
        
        let todayDate = NSDate()
        let myCalendar = Calendar(identifier: .gregorian)
        var weekDay = myCalendar.component(.weekday, from: todayDate as Date)
        
        if tomorrow {
            if (weekDay == 7){
                weekDay = 1
            } else {
                weekDay += 1
            }
        }
        
        return weekDays[weekDay]
    }
}
