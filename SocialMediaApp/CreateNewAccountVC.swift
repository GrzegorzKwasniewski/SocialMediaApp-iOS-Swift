//
//  CreateAccount.swift
//  SocialMediaApp
//
//  Created by Grzegorz on 17/09/2017.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

import UIKit

class CreateNewAccountVC: BaseVC {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordField.delegate = self
        emailField.delegate = self
        
        EmailLogin2.sharedInstance.popUpDelegate = self
    }
    
    @IBAction func createNewAccount(_ sender: Any) {
        EmailLogin2.sharedInstance.createUserWithEmail(emailField: emailField, passwordField: passwordField)
    }
    
    @IBAction func goBackToLoginScreen(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CreateNewAccountVC: ShowPopUp {
    
    func authenticationFailed(withMessage message: String? = "") {
        
        //let authenticationFailedPopUp = self.instantiatePopUpView(fromStoryboard: PopUpSettings.popUpStoryboardID.rawValue, withIdentifier: PopUpSettings.customPopUpID.rawValue) as! Custom_PopUp
        
        //self.addPopUpView(popUpView: authenticationFailedPopUp)
        
        //authenticationFailedPopUp.customMessage.text = message
    }
    
    func authenticationSuccess() {
        
        //let authenticationSuccessPopUp = self.instantiatePopUpView(fromStoryboard: PopUpSettings.popUpStoryboardID.rawValue, withIdentifier: PopUpSettings.successAuthenticationPopUpID.rawValue) as! SuccessAuthentication_PopUp
        
        //self.addPopUpView(popUpView: authenticationSuccessPopUp)
        
        //authenticationSuccessPopUp.delegate = self
        
    }
    
    func dismissSuperView() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CreateNewAccountVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // only call if password text field was used
        if textField.tag == 1 {
            self.createNewAccount(UIButton())
        }
        
        self.view.endEditing(true)
        return true
    }
}

