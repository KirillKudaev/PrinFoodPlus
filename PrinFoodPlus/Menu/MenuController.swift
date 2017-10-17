//
//  MenuController.swift
//  PrinFoodPlus
//
//  Created by Kirill Kudaev on 10/16/17.
//  Copyright © 2017 Kirill Kudaev. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class MenuController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var mealName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        collectionView?.backgroundColor = .white
        
        self.collectionView!.register(MenuCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        fetchDishes()
    }
    
    var dishes = [Dish]()
    fileprivate func fetchDishes() {
        
        guard var mealName = mealName else { return }
        mealName = mealName.lowercased()
        Database.database().reference().child("meals").child(String(getEpochToday())).child(mealName).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let dictionaries = snapshot.value as? [String: Any] else { return }
            
            dictionaries.forEach({ (key, value) in
                guard let dictionary = value as? [String: Any] else { return }
                let dish = Dish(name: key, dictionary: dictionary)
                self.dishes.append(dish)
            })
            
            self.dishes.sort(by: { (d1, d2) -> Bool in
                return d1.course < d2.course
            })
            
            self.collectionView?.reloadData()
        }) { (err) in
            print("Failed to fetch menu:", err)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 60)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MenuCell
        
        cell.backgroundColor = .orange
        
        cell.dishName = "\(dishes[indexPath.item].name) (T:\(dishes[indexPath.item].type) C:\(dishes[indexPath.item].course))"
        
        cell.dishType = dishes[indexPath.item].type
        
        return cell
    }
    
    func getEpochToday() -> Int {
        let date = Date()
        let calendar = Calendar.current
        var dateComponents = DateComponents()

        dateComponents.day = calendar.component(.day, from: date)
        dateComponents.month = calendar.component(.month, from: date)
        dateComponents.year = calendar.component(.year, from: date)
        
        let dateTime = Calendar.current.date(from: dateComponents)
        
        guard let timeInterval = dateTime?.timeIntervalSince1970 else { return 0 }
        
        return Int((timeInterval * 1000.0).rounded())
    }
}
