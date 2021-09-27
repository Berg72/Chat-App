//
//  ProfileController.swift
//  Chat App
//
//  Created by Mark bergeson on 9/26/21.
//

import UIKit

class ProfileController: UIViewController {
    
    private let nameField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

private extension ProfileController {
    
    func setupView() {
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeAction))

        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppeared(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        let topLabel = UILabel()
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.textColor = .black
        topLabel.font = UIFont.systemFont(ofSize: 36.0, weight: .bold)
        topLabel.textAlignment = .center
        topLabel.text = "Profile"
        view.addSubview(topLabel)
        
        topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40.0).isActive = true
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
        nameField.text = Database.shared.currentUser?.name
        nameField.layer.borderWidth = 1.0
        nameField.layer.borderColor = UIColor.black.withAlphaComponent(0.40).cgColor
        nameField.layer.cornerRadius = 24.0
        nameField.setLeftPadding(18.0)
        containerView.addSubview(nameField)
        
        nameField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        nameField.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        nameField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        nameField.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
        
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue1
        button.layer.cornerRadius = 24.0
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .medium)
        button.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        view.addSubview(button)
        
        button.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 40.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
    }
    
    @objc
    func saveAction() {
        guard let text = nameField.text, text.count > 3 else { return }
        guard var user = Database.shared.currentUser else { return }
        user.name = text
        Database.shared.save(user) { (user, error) in
            Database.shared.currentUser = user
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc
    func closeAction() {
        dismiss(animated: true, completion: nil)
    }
    
}

