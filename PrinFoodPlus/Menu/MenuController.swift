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
       
            guard let epoch = Date.getEpochBeginningOfToday() else { return }
        Database.database().reference().child("meals").child(String(epoch)).child(mealName).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let dictionaries = snapshot.value as? [String: Any] else { return }
            
            dictionaries.forEach({ (key, value) in
                guard let dictionary = value as? [String: Any] else { return }
                let dish = Dish(name: key, dictionary: dictionary)
                self.dishes.append(dish)
            })
            
            self.dishes.sort(by: { (d1, d2) -> Bool in
                return d1.course < d2.course
            })
            
            self.dishes.append(Dish(name: "🌱 - Vegetarian  🌿 - Vegan", dictionary: [String: Any]()))

            self.collectionView?.reloadData()
        }) { (err) in
            print("Failed to fetch menu:", err)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 60)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MenuCell
                
        cell.dishName = dishes[indexPath.item].name
        cell.dishType = dishes[indexPath.item].type
        
        return cell
    }
}
