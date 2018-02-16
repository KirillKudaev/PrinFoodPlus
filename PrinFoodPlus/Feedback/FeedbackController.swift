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
    private var placeholderLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feedbackTextView.delegate = self

        self.navigationItem.title = "Feedback"
        getNavBarTitleFromFirebase()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send", style: .plain, target: self, action: #selector(sendFeedback))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        
        self.emailTextField.becomeFirstResponder()
        self.hideKeyboardWhenTappedAround()
        
        setUpPlaceholderLabel()
    }
    
    private func setUpPlaceholderLabel() {
        
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
            
        }) { (err) in
            print(err)
        }
    }
    
    internal func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    @objc private func sendFeedback() {
        self.view.endEditing(true)
        
        guard let feedbackContent = feedbackTextView.text, feedbackTextView.text.count > 0 else {
            
            self.createOkAlert(title: "Error in form", message: "Can't send an empty message")
            return
        }
        
        let feedback = Feedback(content: feedbackContent, email: emailTextField.text)
        
        let values: [String: String]
        
        if (feedback.email != nil) {
            values = ["content": feedback.content, "email": feedback.email!]
        } else {
            values = ["content": feedback.content]
        }
        
        let feedbackRef = Database.database().reference().child("posts")
        let ref = feedbackRef.childByAutoId()
        
        ref.updateChildValues(values) { (err, ref) in
            if err != nil {
                self.createOkAlert(title: "Uh-oh...", message: "Couldn't send feedback")
            } else {
                self.clearForm()
                self.createOkAlert(title: "Thank you!", message: "We received your feedback")
            }
        }
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
