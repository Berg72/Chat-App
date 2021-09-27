//
//  ChatListController.swift
//  Chat App
//
//  Created by Mark bergeson on 9/5/21.
//

import UIKit

class ChatListController: UIViewController {
    
    private var tableView = UITableView(frame: .zero, style: .plain)
    private var datasource = [Conversation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadConversations()
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
        let nav = UINavigationController(rootViewController: ProfileController())
        present(nav, animated: true, completion: nil)
    }
    
    @objc
    func addButtonAction() {
        let nav = UINavigationController(rootViewController: NewChatController())
        present(nav, animated: true, completion: nil)
    }
    
    func loadConversations() {
        datasource.removeAll()
        guard let userId = Database.shared.currentUser?.id else { return }
        Conversation.getConversations(userId: userId) { (conversations, error) in
            guard let conversations = conversations else { return }
            self.datasource.append(contentsOf: conversations)
            self.tableView.reloadData()
        }
    }
}

extension ChatListController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatListCell.reusIdentifier(), for: indexPath)
        
        if let cell = cell as? ChatListCell {
            cell.configure(conversation: datasource[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
