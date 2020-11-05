//
//  LoginViewController.swift
//  MDB Social
//
//  Created by Michelle Kroll on 10/20/20.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var regisPromptLabel: UILabel!
    @IBOutlet weak var regisButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setup()
    }
    
    private func setup() {
            
            headerLabel.text = "Login"
            
            emailLabel.text = "Your Email:"
            emailTextField.placeholder = "example@domain.com"
            emailTextField.delegate = self
            emailTextField.keyboardType = .emailAddress
            
            passwordLabel.text = "Password"
            passwordTextField.placeholder = "*********"
            passwordTextField.delegate = self
            
            errorMessageLabel.text = ""
            
            loginButton.setTitle("Login", for: .normal)
            loginButton.addTarget(self, action: #selector(didTapLoginWithEmail(_:)), for: .touchUpInside)
            
            regisPromptLabel.text = "New to MDBSocial?"
            regisButton.setTitle("Register Now", for: .normal)
        }
        
        @objc func didTapLoginWithEmail(_ sender: Any?) {
            guard let email = emailTextField.text, email != "" else {
                errorMessageLabel.text = "You must provide an email"
                return
            }
            
            guard let password = passwordTextField.text, password != "" else {
                errorMessageLabel.text = "You must provide a password"
                return
            }
            
            FirebaseRequest.shared.signIn(withEmail: email, password: password, completion: { [weak self] result in
                guard let strongSelf = self else {
                    return
                }
                
                switch result {
                case .success(let user):
                    strongSelf.performSegue(withIdentifier: "FeedTable", sender: nil)
                case .failure(let error):
                    switch error {
                    case .malformedEmail:
                        strongSelf.errorMessageLabel.text = "Invalid email format"
                    case .malformedPassword:
                        strongSelf.errorMessageLabel.text = "Invalid password format"
                    case .networkError:
                        strongSelf.errorMessageLabel.text = "Network error"
                    case .rejectedCredential:
                        strongSelf.errorMessageLabel.text = "Incorrect username or password"
                    case .generalError:
                        strongSelf.errorMessageLabel.text = "Unknown Error"
                    default:
                        strongSelf.errorMessageLabel.text = "Unknown Error"
                    }
                }
            })
        }
}

    extension LoginViewController: UITextFieldDelegate {
        
    }
    

