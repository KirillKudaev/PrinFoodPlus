//
//  DiningController.swift
//  PrinFoodPlus
//
//  Created by Kirill Kudaev on 10/14/17.
//  Copyright © 2017 Kirill Kudaev. All rights reserved.
//

import UIKit
import Firebase

class DiningController: UICollectionViewController, UICollectionViewDelegateFlowLayout, TodayTomorrowHeaderDelegate {
    
    private let cellId = "cellId"
    private let headerId = "headerId"
    private let headerHeight: CGFloat = 100.0
    private var isTomorrow = false
    
    func didChangeDay(tomorrow: Bool) {
        isTomorrow = tomorrow
        fetchTimes(tomorrow: tomorrow)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Dining Room"

        collectionView?.backgroundColor = .white
        collectionView?.isScrollEnabled = false
        
        collectionView?.backgroundView = UIImageView(image: UIImage(named: "smoothie"))
        collectionView?.backgroundView?.contentMode = .scaleAspectFill

        collectionView?.register(TodayTomorrowHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
        collectionView?.register(DiningCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchTimes(tomorrow: isTomorrow)
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
        Date.printEpochForNextDays(numberOfDays: 14)
    }
    
    var mealTimes = [String: Any]()
    fileprivate func fetchTimes(tomorrow: Bool) {
       
        guard let dayOfWeek = Date.getDayOfWeek(tomorrow: tomorrow) else { return }
        Database.database().reference().child("diningTimes").child(dayOfWeek).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let times = snapshot.value as? [String: Any] else { return }

            self.mealTimes = times
            self.collectionView?.reloadData()

        }) { (err) in
            if !tomorrow {
                print("Failed to fetch dining times for today:", err)
            } else {
                print("Failed to fetch dining times for tomorrow:", err)
            }
        }
    }
    
    @objc func willEnterForeground() {
        fetchTimes(tomorrow: isTomorrow)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (view.frame.height - UIApplication.shared.statusBarFrame.height -
            self.navigationController!.navigationBar.frame.height - headerHeight - (self.tabBarController?.tabBar.frame.height)!) / 3
        return CGSize(width: view.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DiningCell
                
        switch indexPath.item {
        case 0:
            cell.mealName = "Breakfast"
            guard let time = mealTimes["breakfast"] as? String else { break }
            cell.timesOpen = time
        case 1:
            cell.mealName = "Lunch"
            guard let time = mealTimes["lunch"] as? String else { break }
            cell.timesOpen = time
        case 2:
            cell.mealName = "Dinner"
            guard let time = mealTimes["dinner"] as? String else { break }
            cell.timesOpen = time
        default:
            break
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menuController = MenuController(collectionViewLayout: UICollectionViewFlowLayout())
        
        menuController.isTomorrow = isTomorrow
        menuController.mealPlace = .diningRoom

        switch indexPath.item {
        case 0:
            menuController.navigationItem.title = "Breakfast"
            menuController.mealName = "Breakfast"
        case 1:
            menuController.navigationItem.title = "Lunch"
            menuController.mealName = "Lunch"
        case 2:
            menuController.navigationItem.title = "Dinner"
            menuController.mealName = "Dinner"
        default:
            break
        }
        
        navigationController?.pushViewController(menuController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! TodayTomorrowHeader
        
        header.delegate = self
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: headerHeight)
    }
}
