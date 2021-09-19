//
//  ChatListController.swift
//  Chat App
//
//  Created by Mark bergeson on 9/5/21.
//

import UIKit

class ChatListController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}


private extension ChatListController {
    
    func setupView() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = "Chat App"
        navigationController?.navigationBar.tintColor = .blue1
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(viewProfileAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonAction))
        
    }
    
    @objc
    func viewProfileAction() {
        
    }
    
    @objc
    func addButtonAction() {
        
    }
}
