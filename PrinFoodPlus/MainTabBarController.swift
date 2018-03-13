//
//  MainTabBarController.swift
//  PrinFoodPlus
//
//  Created by Kirill Kudaev on 10/14/17.
//  Copyright © 2017 Kirill Kudaev. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    func setupViewControllers() {
        
        let homeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "dining_unselected"), selectedImage: #imageLiteral(resourceName: "dining_selected"), rootViewController: DiningController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        let userProfileNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "burger_unselected"), selectedImage: #imageLiteral(resourceName: "burger_selected"), rootViewController: PubController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        let mealPlanNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "money_unselected"), selectedImage: #imageLiteral(resourceName: "money_selected"), rootViewController: MealPlanController())
        
        let feedbackNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "feedback_unselected"), selectedImage: #imageLiteral(resourceName: "feedback_selected"), rootViewController: FeedbackController())
        
        tabBar.tintColor = .white
        tabBar.barTintColor = UIColor.mainBlue()
        
        viewControllers = [homeNavController,
                           userProfileNavController,
                           /*mealPlanNavController,*/
                           feedbackNavController]
        
        let accessibilityLabels: [String] = ["Dining",
                                             "Pub",
                                             /*"Meal Plan Calculator",*/
                                             "Feedback"]
        
        guard let items = tabBar.items else { return }
        
        for (index, item) in items.enumerated() {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
            item.accessibilityLabel = accessibilityLabels[index]
        }
    }
    
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.barTintColor = UIColor.mainBlue()
        navController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navController.navigationBar.tintColor = .white
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}
