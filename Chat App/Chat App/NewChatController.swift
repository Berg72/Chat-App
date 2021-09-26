//
//  NewChatController.swift
//  Chat App
//
//  Created by Mark bergeson on 9/25/21.
//

import UIKit

class NewChatController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var datasource = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadUsers()
    }
    
}

private extension NewChatController {
    
    func setupView() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = "New Chat"
        navigationController?.navigationBar.tintColor = .blue1
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeAction))
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15.0, bottom: 0, right: 0)
        tableView.backgroundColor = .white
        tableView.backgroundView?.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reusIdentifier())
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
    func closeAction() {
        dismiss(animated: true, completion: nil)
    }
    
    func loadUsers() {
        User.getUsers { (users, error) in
            guard var users = users else { return }
        users = users.filter({$0.id != Database.shared.currentUser?.id })
            self.datasource.append(contentsOf: users)
            self.tableView.reloadData()
        }
    }
}

extension NewChatController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reusIdentifier(), for: indexPath)
        cell.textLabel?.text = datasource[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let currentUser = Database.shared.currentUser, let currentUserId = currentUser.id else { return }
        guard let selectedId = datasource[indexPath.row].id else { return }
        let date = Date().timeIntervalSince1970
        let conversation = Conversation(id: nil, participants: [currentUser, datasource[indexPath.row]], participantsId: [currentUserId, selectedId], lastMessageText: nil, created: date, createdBy: currentUserId, lastUpdated: date, lastUpdatedBy: currentUserId, archived: false, archivedAt: nil)
        Database.shared.save(conversation) { (conversation, error) in
            self.dismiss(animated: true, completion: nil)
        }
    }
}

