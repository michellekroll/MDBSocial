//
//  RegisterViewController.swift
//  MDB Social
//
//  Created by Michelle Kroll on 10/20/20.
//

import UIKit

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var regisButton: UIButton!
    @IBOutlet weak var loginPromptLabel: UILabel!
    @IBOutlet weak var loginPromptButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
            
        headerLabel.text = "Register"
            
        noteLabel.text = "Please enter your full name."
            
        firstNameLabel.text = "First Name:"
    
        lastNameLabel.text = "Last Name:"
            
        firstNameTextField.placeholder = "First Name"
        firstNameTextField.delegate = self
            
        lastNameTextField.placeholder = "Last Name"
        lastNameTextField.delegate = self
            
        dobLabel.text = "Date of Birth:"
        dobTextField.placeholder = "MM-DD-YYYY"
        dobTextField.delegate = self
        dobTextField.tag = 1
        dobTextField.keyboardType = .numberPad
            
        emailLabel.text = "Email:"
        emailTextField.placeholder = "example@domain.com"
        emailTextField.delegate = self
        emailTextField.keyboardType = .emailAddress
            
        mobileLabel.text = "Mobile:"
        mobileTextField.placeholder = "(123)-456-789"
        mobileTextField.delegate = self
        mobileTextField.keyboardType = .numberPad

        passwordLabel.text = "Password:"
        passwordTextField.placeholder = "********"
        passwordTextField.delegate = self
            
        regisButton.setTitle("Register", for: .normal)
            
        loginPromptLabel.text = "Already have an account?"
        loginPromptButton.setTitle("Login Now", for: .normal)
        loginPromptButton.addTarget(self, action: #selector(didTapLogin(_:)), for: .touchUpInside)
            
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
            
        }
        
        @objc func didTapLogin(_ sender: Any?) {
            dismiss(animated: true, completion: nil)
        }
        
        @objc func keyboardNotification(notification: NSNotification) {
            if let userInfo = notification.userInfo {
                
                let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
                let endFrameY = endFrame?.origin.y ?? 0
                
                let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
                let animationCurveRaw = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue
                let animationCurve = UIView.AnimationOptions(rawValue: animationCurveRaw ?? UIView.AnimationOptions.curveEaseInOut.rawValue)
                
                UIView.animate(withDuration: duration, delay: TimeInterval(0), options: animationCurve, animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
        
    
    @IBAction func registerTapped(_ sender: Any) {
            let error = validateFields()
            guard error == nil, let email = emailTextField.text, let password = passwordTextField.text, let dob = dobTextField.text, let mobile = mobileTextField.text, let firstname = firstNameTextField.text, let lastname = lastNameTextField.text else {
                self.noteLabel.text = error
                return
            }
            
            FirebaseRequest.shared.register(withEmail: email, password: password, completion: { [weak self] result in
        
                guard let strongSelf = self else {
                    return
                }
                
                switch result {
                case .success(let user):
                    FirebaseRequest.shared.addUserInfo(withEmail: email, firstname: firstname, lastname: lastname, birthday: dob, mobile: mobile, completion: { [weak self] in
                        
                        guard let strongSelf = self else {
                            return
                        }
                        strongSelf.performSegue(withIdentifier: "FeedTable", sender: self)
                    })
                case .failure(let error):
                    switch error {
                    case .emailInUse:
                        strongSelf.noteLabel.text = "Email already in used"
                    case .generalError:
                        strongSelf.noteLabel.text = "Unknown error"
                    }
                }
            })
        }
        
        func validateFields() -> String? {
            //check that all fields are filled in
            if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                return "Please make sure to enter email and password"
            }
            
            if firstNameLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                return "Please enter your first name"
            }
            
            if lastNameLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                return "Please enter your last name"
            }
            
            if mobileLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                return "Please enter your phone number"
            }
            
            if dobTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                return "Please enter your birthday"
            }

            return nil
        }
        
        /*
        // MARK: - Navigation
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */

    }

    extension RegisterViewController: UITextFieldDelegate {
        
    }

