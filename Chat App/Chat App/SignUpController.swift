//
//  SignUpController.swift
//  Chat App
//
//  Created by Mark bergeson on 9/6/21.
//

import UIKit
import FirebaseAuth

class SignUpController: UIViewController {
    
    private let nameField = UITextField()
    private let emailField = UITextField()
    private let passwordField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

private extension SignUpController {
    
    func setupView() {
        view.backgroundColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppeared(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        let topLabel = UILabel()
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.textColor = .black
        topLabel.font = UIFont.systemFont(ofSize: 36.0, weight: .bold)
        topLabel.textAlignment = .center
        topLabel.text = "Sign Up"
        view.addSubview(topLabel)
        
        topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40.0).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        view.addSubview(containerView)
        
        containerView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 40.0).isActive = true
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        nameField.textColor = .black
        nameField.placeholder = "Your name"
        nameField.layer.borderWidth = 1.0
        nameField.layer.borderColor = UIColor.black.withAlphaComponent(0.40).cgColor
        nameField.layer.cornerRadius = 24.0
        nameField.setLeftPadding(18.0)
        containerView.addSubview(nameField)
        
        nameField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        nameField.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        nameField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        nameField.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
        
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        emailField.textColor = .black
        emailField.placeholder = "Your email"
        emailField.layer.borderWidth = 1.0
        emailField.layer.borderColor = UIColor.black.withAlphaComponent(0.40).cgColor
        emailField.layer.cornerRadius = 24.0
        emailField.setLeftPadding(18.0)
        containerView.addSubview(emailField)
        
        emailField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20.0).isActive = true
        emailField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
        
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        passwordField.textColor = .black
        passwordField.placeholder = "Your password"
        passwordField.layer.borderWidth = 1.0
        passwordField.layer.borderColor = UIColor.black.withAlphaComponent(0.40).cgColor
        passwordField.layer.cornerRadius = 24.0
        passwordField.setLeftPadding(18.0)
        passwordField.isSecureTextEntry = true
        containerView.addSubview(passwordField)
        
        passwordField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20.0).isActive = true
        passwordField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
        
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue1
        button.layer.cornerRadius = 24.0
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Create Account", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .medium)
        button.addTarget(self, action: #selector(createAccountAction), for: .touchUpInside)
        view.addSubview(button)
        
        button.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 40.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let button2 = UIButton(type: .roundedRect)
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.backgroundColor = .clear
        button2.layer.cornerRadius = 24.0
        button2.setTitleColor(UIColor.black.withAlphaComponent(0.30), for: .normal)
        button2.setTitle("Already have an account?", for: .normal)
        button2.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .medium)
        button2.addTarget(self, action: #selector(alreadyHaveAccountAction), for: .touchUpInside)
        view.addSubview(button2)
        
        button2.topAnchor.constraint(equalTo: button.bottomAnchor).isActive = true
        button2.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        button2.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
        button2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button2.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true

    }
    
    @objc
    func createAccountAction() {
        guard let name = nameField.text, let email = emailField.text, let password = passwordField.text else {
            return
        }
        
        guard name.count > 3, email.count > 5, password.count > 4 else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard let res = result else {
                return
            }
            
            let userId = res.user.uid
            
            let date = Date().timeIntervalSince1970
            
            let user = User(id: userId, apnsToken: nil, name: name, email: email, profileImageUrl: nil, created: date, createdBy: userId, lastUpdated: date, lastUpdatedBy: userId, archived: false, archivedAt: nil)
            Database.shared.save(user) { (user, error) in
                guard let user = user else { return }
                Database.shared.currentUser = user
                let vc = ChatListController()
                self.navigationController?.pushViewController(vc, animated: true)
            
                
            }
            
        }
        
    }
    
    @objc
    func alreadyHaveAccountAction() {
        let vc = SignInController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

private extension SignUpController {
    
    @objc func keyboardAppeared(notification: Notification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            
            if endFrameY >= UIScreen.main.bounds.size.height {
//                self.joinGameContainerBottomAnchor?.constant = -172.0
            } else {
                let offset = UIScreen.main.bounds.size.height - endFrameY
//                self.joinGameContainerBottomAnchor?.constant = -offset + view.safeAreaInsets.bottom - 30.0
            }
            UIView.animate(withDuration: duration, delay: TimeInterval(0), options: animationCurve, animations: {
                            self.view.layoutIfNeeded() }, completion: nil)
            }
                
        }
    }

