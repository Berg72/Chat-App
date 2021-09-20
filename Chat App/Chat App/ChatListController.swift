//
//  ChatListController.swift
//  Chat App
//
//  Created by Mark bergeson on 9/5/21.
//

import UIKit

class ChatListController: UIViewController {
    
    private var tableView = UITableView(frame: .zero, style: .plain)
    
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
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15.0, bottom: 0, right: 0)
        tableView.backgroundColor = .white
        tableView.backgroundView?.backgroundColor = .white
        tableView.register(ChatListCell.self, forCellReuseIdentifier: ChatListCell.reusIdentifier())
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 71.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    @objc
    func viewProfileAction() {
        
    }
    
    @objc
    func addButtonAction() {
        
    }
}

extension ChatListController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatListCell.reusIdentifier(), for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
