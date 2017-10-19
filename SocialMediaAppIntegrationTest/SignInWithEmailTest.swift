//
//  SignInWithEmailTest.swift
//  SocialMediaApp
//
//  Created by Grzegorz on 19/10/2017.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

import KIF
import Nimble

class SignInWithEmailTest : BaseUITests {
    
    override func beforeAll() {
        tapButton(buttonName: Name.EMAIL_LOGIN_BUTTON)
        expectToSeeSigInWithEmailVC()
    }
    
    override func afterAll() {
        tapButton(buttonName: Name.BACK_BUTTON)
        expectToHideSigInWithEmailVC()
        expectToSeeSigInVC()
    }
    
    override func beforeEach() {
    }
    
    
    /**
     Test if warning alert will be shown when user will not provide ANY email login data on login screen
     */
    
    func testEmptyEmailAndPasswordField_ShowAlert() {
        tapButton(buttonName: Name.LOGIN_WITH_EMAIL_BUTTON)
        expectToSeeAlert(text: Name.ERROR_MESSAGE)
        tapButton(buttonName: Name.DISMISS_BUTTON)
        expectToSeeSigInWithEmailVC()
    }
    
    /**
     Test if warning alert will be shown when user will not provide INVALID    email login data on login screen
     */
    
    func testInvalidEmailAndPasswordData_ShowAlert() {
        clearOutAllFields()
        provideInvalidEmail()
        provideInvalidPassword()
        tapButton(buttonName: Name.LOGIN_WITH_EMAIL_BUTTON)
        expectToSeeAlert(text: Name.ERROR_MESSAGE)
        tapButton(buttonName: Name.DISMISS_BUTTON)
        expectToSeeSigInWithEmailVC()
    }
}
