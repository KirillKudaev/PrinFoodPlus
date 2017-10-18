//
//  PubController.swift
//  PrinFoodPlus
//
//  Created by Kirill Kudaev on 10/14/17.
//  Copyright © 2017 Kirill Kudaev. All rights reserved.
//


import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class PubController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Pub"
        
        collectionView?.backgroundColor = .white
        collectionView?.isScrollEnabled = false
        
        self.collectionView!.register(PubCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        fetchTimes(tomorrow: false)
        fetchTimes(tomorrow: true)
    }
    
    var todayTimes = [String: Any]()
    var tomorrowTimes = [String: Any]()
    fileprivate func fetchTimes(tomorrow: Bool) {
        
        guard let dayOfWeek = Date.getDayOfWeek(tomorrow: tomorrow) else { return }
        Database.database().reference().child("pubTimes").child(dayOfWeek).observeSingleEvent(of: .value, with: { (snapshot) in
            
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
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (view.frame.height - UIApplication.shared.statusBarFrame.height -
            self.navigationController!.navigationBar.frame.height - (self.tabBarController?.tabBar.frame.height)!) / 3
        return CGSize(width: view.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PubCell
        
        switch indexPath.item {
        case 0:
            cell.mealName = "Breakfast"
            guard let time = todayTimes["breakfast"] as? String else { break }
            cell.timesOpen = time
        case 1:
            cell.mealName = "Lunch"
            guard let time = todayTimes["lunch"] as? String else { break }
            cell.timesOpen = time
        case 2:
            cell.mealName = "Dinner"
            guard let time = todayTimes["dinner"] as? String else { break }
            cell.timesOpen = time
        default:
            break
        }
        
        return cell
    }
}
