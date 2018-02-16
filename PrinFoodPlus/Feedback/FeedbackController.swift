//
//  FeedbackController.swift
//  PrinFoodPlus
//
//  Created by Kirill Kudaev on 2/15/18.
//  Copyright © 2018 Kirill Kudaev. All rights reserved.
//

import UIKit
import Firebase

class FeedbackController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var feedbackTextView: UITextView!
    var placeholderLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Feedback"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send", style: .plain, target: self, action: #selector(sendFeedback))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        
        self.emailTextField.becomeFirstResponder()
        
        self.hideKeyboardWhenTappedAround()
        
        feedbackTextView.delegate = self
        
        getNavBarTitleFromFirebase()
        
        placeholderLabel = UILabel()
        placeholderLabel.text = "Tell us what you think!"
        placeholderLabel.font = UIFont.systemFont(ofSize: (feedbackTextView.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        feedbackTextView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (feedbackTextView.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !feedbackTextView.text.isEmpty
    }
    
    private func getNavBarTitleFromFirebase() {
        Database.database().reference().child("feedbackScreenTitle").observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String: String] else { return }
            
            self.navigationItem.title = dictionary["title"]
            
            self.clearForm()
            
        }) { (err) in
            
            self.createOkAlert(title: "Error", message: "Try again")
            
            self.clearForm()
        }
    }
    
    internal func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    @objc private func sendFeedback() {
        self.view.endEditing(true)
        
        
        
    }
    
    private func clearForm() {
        emailTextField.text = ""
        feedbackTextView.text = ""
        placeholderLabel.isHidden = false
    }
    
    @objc private func cancel() {
        self.view.endEditing(true)
    }
}
