//
//  LoadingPageController.swift
//  Chat App
//
//  Created by Mark bergeson on 9/4/21.
//

import UIKit
import FirebaseAuth

class LoadingPageController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if let userId = Auth.auth().currentUser?.uid {
                User.getUser(userId: userId) { user, error in
                    guard let user = user else {
                        return
                }
                    Database.shared.currentUser = user
                    let vc = ChatListController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                let vc = OnboardingController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        
        }
    }
    
}

private extension LoadingPageController {
    
    func setupView() {
        view.backgroundColor = .blue1
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Chat-app-icon")?.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 237.0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 160.0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 160.0).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let topLabel = UILabel()
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.font = UIFont.systemFont(ofSize: 36.0, weight: .bold)
        topLabel.textColor = .white
        topLabel.textAlignment = .center
        topLabel.text = "Chat App"
        view.addSubview(topLabel)
        
        topLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let bottomLabel = UILabel()
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        bottomLabel.textColor = .white
        bottomLabel.textAlignment = .center
        bottomLabel.text = "Chatting for Professionals"
        view.addSubview(bottomLabel)
        
        bottomLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30.0).isActive = true
        bottomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
