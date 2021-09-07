//
//  OnboardingController.swift
//  Chat App
//
//  Created by Mark bergeson on 9/5/21.
//

import UIKit

class OnboardingController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}

private extension OnboardingController {
    
    func setupView() {
        view.backgroundColor = .white
        
        let onBoardImageView = UIImageView()
        onBoardImageView.translatesAutoresizingMaskIntoConstraints = false
        onBoardImageView.image = UIImage(named: "collaborate")?.withRenderingMode(.alwaysOriginal)
        onBoardImageView.contentMode = .scaleAspectFit
        view.addSubview(onBoardImageView)
        
        onBoardImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        onBoardImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40.0).isActive = true
        onBoardImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0).isActive = true
        onBoardImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40.0).isActive = true
        
        let topLabel = UILabel()
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        topLabel.textColor = .black
        topLabel.numberOfLines = 0
        topLabel.lineBreakMode = .byWordWrapping
        topLabel.textAlignment = .center
        topLabel.text = "Communication with professional connections"
        view.addSubview(topLabel)
        
        topLabel.topAnchor.constraint(equalTo: onBoardImageView.bottomAnchor, constant: 30.0).isActive = true
        topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0).isActive = true
        
        let bottomLabel = UILabel()
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        bottomLabel.textColor = .black
        bottomLabel.numberOfLines = 0
        bottomLabel.lineBreakMode = .byWordWrapping
        bottomLabel.textAlignment = .center
        bottomLabel.text = "Use this chat app with all of your prefessional connections no matter where they are in the world."
        view.addSubview(bottomLabel)
        
        bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 20.0).isActive = true
        bottomLabel.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        bottomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue1
        button.layer.cornerRadius = 24.0
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Get Started", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .medium)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(button)
        
        button.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor, constant: 30.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
    }
    
    @objc
    func buttonTapped() {
        let vc = SignUpController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
