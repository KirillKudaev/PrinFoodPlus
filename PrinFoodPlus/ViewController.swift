//
//  ViewController.swift
//  PrinFoodPlus
//
//  Created by Kirill Kudaev on 10/14/17.
//  Copyright © 2017 Kirill Kudaev. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Database.database().reference().child("meals").observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let dics = snapshot.value as? [String: Any] else { return }
            
            dics.forEach({ (key, value) in
                print("Key: \(key),\n Value \(value)")
            })
            
        }) { (err) in
            print("Failed to fetch following user ids:", err)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

