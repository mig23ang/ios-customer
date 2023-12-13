//
//  LoginViewController.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 27/11/23.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    
    @IBOutlet weak var buttonCreateAccount: UIButton!
    @IBOutlet weak var labelDoNotHaveAUser: UILabel!
    @IBOutlet weak var viewCustomTextfieldTypeDocument: CustomTextFieldView!
    @IBOutlet weak var viewCustomTextfieldNumberDocument: CustomTextFieldView!
    @IBOutlet weak var viewCustomTextfieldPassword: CustomTextFieldView!
    
    @IBOutlet weak var buttonHidenTextfieldPassword: UIButton!
    @IBOutlet weak var buttonArrowTextfieldSelectDocument: UIButton!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonForgotPassword: UIButton!
    
    @IBOutlet weak var labelDescriptionTextfieldPassword: UILabel!
    @IBOutlet weak var labelDescriptionTextfieldNumberDocument: UILabel!
    @IBOutlet weak var labelDescriptionTextfieldSelectDocument: UILabel!
    @IBOutlet weak var labelIntoToApp: UILabel!
    @IBOutlet weak var labelHello: UILabel!
    
    private var viewModel = LoginViewModel()
    
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    @IBAction func buttonCreateAccountAction(_ sender: UIButton) {
    }
    
    @IBAction func buttonArrowTextfieldSelectDocumentAction(_ sender: UIButton) {
        openListModalSelectDocument()
    }
    
    @IBAction func buttonHidenTextfieldPasswordAction(_ sender: UIButton) {
        if viewCustomTextfieldPassword.textfield.isSecureTextEntry {
            viewCustomTextfieldPassword.textfield.isSecureTextEntry = false
        }else{
            viewCustomTextfieldPassword.textfield.isSecureTextEntry = true
        }
    }
    
    @IBAction func buttonForgotPasswordActioon(_ sender: UIButton) {
    }
    
    @IBAction func buttonLoginAction(_ sender: UIButton) {
        view.endEditing(true)
        guard validateTextFields() else {
            return
        }
        
        FactoryLoader.createCustomLoader(inView: self.view,text: Constants.Strings.Loader.starting)

        viewModel.login(username: viewCustomTextfieldNumberDocument.textfield.text!, password: viewCustomTextfieldPassword.textfield.text!)
            .sink(receiveCompletion: { [weak self] completion in
                
                guard let strongSelf = self else {
                    return
                }
                
                FactoryLoader.removeCustomLoader(fromView: strongSelf.view)
                
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    let errorMessage = (error as? APIError)?.errorDescription ?? Constants.Strings.Errors.default
                            print(errorMessage)
                    Toast(
                        text: errorMessage,
                        container: nil,
                        viewController: self,
                        direction: .bottom,
                        shouldAddExtraBottomMargin: true
                    )
                    break
                }
            }, receiveValue: { token in
                Keychain.shared[Constants.Keychain.token] = token.token
                if let window = UIApplication.shared.currentWindow {
                    window.rootViewController = MainTabBarController()
                }
            })
            .store(in: &subscriptions)
    }
    
    private func validateTextFields() -> Bool {
        var isValid = true

        if let documentText = viewCustomTextfieldNumberDocument.textfield.text {
            if documentText.isBlank() {
                viewCustomTextfieldNumberDocument.errorMessage = Constants.Strings.Controllers.Login.errorDocument
                isValid = false
            } else if !Validation.shared.validateEmailFormat(withText: documentText) {
                viewCustomTextfieldNumberDocument.errorMessage = Constants.Strings.Controllers.Login.errorEmailFormat
                isValid = false
            } else {
                viewCustomTextfieldNumberDocument.errorMessage = nil
            }
        }

        if let passwordText = viewCustomTextfieldPassword.textfield.text, passwordText.isEmpty {
            viewCustomTextfieldPassword.errorMessage = Constants.Strings.Controllers.Login.errorPassword
            isValid = false
        } else {
            viewCustomTextfieldPassword.errorMessage = nil
        }
        
        return isValid
    }
}

extension LoginViewController {
    
    func prepareView() {
        labelDoNotHaveAUser.text = Constants.Strings.Controllers.Login.doNotHaveAUser
        buttonCreateAccount.setTitle(Constants.Strings.Controllers.Login.createAccount, for: .normal)
        
        labelHello.text = Constants.Strings.Controllers.Login.hello
        labelIntoToApp.text = Constants.Strings.Controllers.Login.enterMyBank
        labelDescriptionTextfieldSelectDocument.text = Constants.Strings.Controllers.Login.typeDocument
        labelDescriptionTextfieldNumberDocument.text = Constants.Strings.Controllers.Login.email
        labelDescriptionTextfieldPassword.text = Constants.Strings.Controllers.Login.password
        
        viewCustomTextfieldTypeDocument.textfield.placeholder = Constants.Strings.Controllers.Login.selectYourDocument
        viewCustomTextfieldNumberDocument.textfield.placeholder = Constants.Strings.Controllers.Login.email
        viewCustomTextfieldPassword.textfield.placeholder = Constants.Strings.Controllers.Login.writeYourPassword
        
        buttonForgotPassword.setTitle(Constants.Strings.Controllers.Login.forgotPasswordHere, for: .normal)
        buttonLogin.setTitle(Constants.Strings.Controllers.Login.login, for: .normal)
        
        buttonLogin.layer.cornerRadius = 25

        viewCustomTextfieldPassword.textfield.isSecureTextEntry = true
        buttonForgotPassword.addUnderline()
        
        viewCustomTextfieldPassword.bringSubviewToFront(buttonHidenTextfieldPassword)
        viewCustomTextfieldTypeDocument.bringSubviewToFront(buttonArrowTextfieldSelectDocument)
        
        viewCustomTextfieldTypeDocument.isIconRight = true
        viewCustomTextfieldPassword.isIconRight = true
        
        viewCustomTextfieldTypeDocument.textfield.delegate = self
        
        #if DEBUG
        viewCustomTextfieldNumberDocument.textfield.text = "usrcnxdesarapis@bancompartir.co"
        viewCustomTextfieldPassword.textfield.text = "@MiBanco1234"
        #else
        #endif
    }
    
    private func openListModalSelectDocument() {
        let modalVC = ListModalViewController(titleText: Constants.Strings.Controllers.Login.selectYourDocument, items: Constants.typeDocumentOptions)
        modalVC.onItemSelected = { selectedItem in
            // Handle the selected item
            self.viewCustomTextfieldTypeDocument.textfield.text = selectedItem.name
        }
        self.present(modalVC, animated: true, completion: nil)
    }
}

extension LoginViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        openListModalSelectDocument()
        view.endEditing(true)
    }
}
