//
//  ContactUsViewController.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/12/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class ContactUsViewController: UIViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!

    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var subjectText: UITextField!
    
    @IBOutlet weak var commentsText: UITextField!
    
    var name: String!
    var email: String!
    var subject: String!
    var comments: String!
    var activeField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameText.delegate = self
        self.emailText.delegate = self
        self.subjectText.delegate = self
        self.commentsText.delegate = self
        if self.revealViewController() != nil {
            var image = UIImage(named: "menu_white")
            image = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self.revealViewController(), action: "revealToggle:")
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    @IBAction func sendEmail(sendBtn: UIButton!) {
        name = nameText.text
        email = emailText.text
        subject = subjectText.text
        comments = commentsText.text
        if name != "" && email != "" && subject != "" && comments != ""{
            let mailComposeViewController = MFMailComposeViewController()
            mailComposeViewController.mailComposeDelegate = self
            mailComposeViewController.setToRecipients(["shravankumar.singireddy@gmail.com"])
            mailComposeViewController.setSubject(subject)
            mailComposeViewController.setMessageBody("Name: \(name) \nEmail: \(email) \nComments: \(comments)", isHTML: false)
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
        }else{
            print("Some or all of the required fields are Empty !!!!")
        }
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        nameText.text = ""
        emailText.text = ""
        subjectText.text = ""
        commentsText.text = ""
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if(textField == commentsText){
            scrollView.setContentOffset(CGPointMake(0, 400), animated: true)
        }else{
            scrollView.setContentOffset(CGPointMake(0, 250), animated: true)
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
