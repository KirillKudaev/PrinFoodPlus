//
//  MenuController.swift
//  PrinFoodPlus
//
//  Created by Kirill Kudaev on 10/16/17.
//  Copyright © 2017 Kirill Kudaev. All rights reserved.
//

import UIKit
import Firebase

enum MealPlace {
    case diningRoom
    case pub
}

class MenuController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"

    var isTomorrow = false
    var mealName: String?
    var mealPlace: MealPlace?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        collectionView?.backgroundColor = .white
        
        self.collectionView!.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchDishes()
    }
    
    var dishes = [Dish]()
    fileprivate func fetchDishes() {
        
        let mealPlaceDatabaseName: String
        
        guard let mealPlace = mealPlace  else { return }
        
        switch mealPlace {
        case .diningRoom:
            mealPlaceDatabaseName = "meals"
        case .pub:
            mealPlaceDatabaseName = "pubMeals"
        }
        
        guard var mealName = mealName else { return }
        mealName = mealName.lowercased()
        
        guard let epoch = Date.getEpochBeginningOfToday(isTomorrow: isTomorrow) else { return }
        Database.database().reference().child(mealPlaceDatabaseName).child(String(epoch)).child(mealName).observeSingleEvent(of: .value, with: { (snapshot) in
            
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
        if (dishes.count  == 0) {
            return 1
        } else {
           return dishes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        
        if (dishes.count  == 0) {
            cell.dishName = "Couldn't download menu 😔"
        } else {
            cell.dishName = dishes[indexPath.item].name
            cell.dishType = dishes[indexPath.item].type
        }
    
        return cell
    }
}
