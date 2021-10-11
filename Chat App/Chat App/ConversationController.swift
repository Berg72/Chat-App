//
//  ConversationController.swift
//  Chat App
//
//  Created by Mark bergeson on 10/3/21.
//

import UIKit

class ConversationController: UIViewController {
    
    
    private var tableView = UITableView(frame: .zero, style: .plain)
    private var conversation: Conversation
    private var datasource = [ChatMessage]()
    private let textView = UITextView()
    
    
    private var chatBottomContainerAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Database.shared.currentListener?.remove()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Database.shared.currentListener == nil {
            loadMessages()
        }
    }
    
    init(conversation: Conversation) {
        self.conversation = conversation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

private extension ConversationController {
    
    func setupView() {
        view.backgroundColor = UIColor(white: 248.0 / 255.0, alpha: 1.0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppeared(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.backgroundView?.backgroundColor = .white
        tableView.register(MessageCell.self, forCellReuseIdentifier: MessageCell.reusIdentifier())
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 71.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
        let chatContainer = UIView()
        chatContainer.translatesAutoresizingMaskIntoConstraints = false
        chatContainer.backgroundColor = .white
        view.addSubview(chatContainer)
        
        tableView.bottomAnchor.constraint(equalTo: chatContainer.topAnchor).isActive = true
        chatContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        chatContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        chatBottomContainerAnchor = chatContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        chatBottomContainerAnchor?.isActive = true
//        chatContainer.heightAnchor.constraint(equalToConstant: 79.0).isActive = true
        
        let borderedView = UIView()
        borderedView.translatesAutoresizingMaskIntoConstraints = false
        borderedView.backgroundColor = .white
        borderedView.layer.borderWidth = 1.0
        borderedView.layer.borderColor = UIColor(white: 151.0 / 255.0, alpha: 1.0).cgColor
        borderedView.layer.cornerRadius = 22.0
        chatContainer.addSubview(borderedView)
        
        borderedView.leadingAnchor.constraint(equalTo: chatContainer.leadingAnchor, constant: 15.0).isActive = true
        borderedView.topAnchor.constraint(equalTo: chatContainer.topAnchor, constant: 15.0).isActive = true
        borderedView.trailingAnchor.constraint(equalTo: chatContainer.trailingAnchor, constant: -54.0).isActive = true
        borderedView.bottomAnchor.constraint(equalTo: chatContainer.bottomAnchor, constant: -20.0).isActive = true
        
        let sendButton = UIButton(type: .roundedRect)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.setImage(UIImage(named: "send-button"), for: .normal)
        sendButton.addTarget(self, action: #selector(sendButtonAction), for: .touchUpInside)
        chatContainer.addSubview(sendButton)
        
        sendButton.trailingAnchor.constraint(equalTo: chatContainer.trailingAnchor, constant: -5.0).isActive = true
        sendButton.topAnchor.constraint(equalTo: chatContainer.topAnchor, constant: 15.0).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        textView.textColor = .black
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.textContainer.lineFragmentPadding = 0
        textView.delegate = self
        textView.isScrollEnabled = false
        borderedView.addSubview(textView)
        
        textView.leadingAnchor.constraint(equalTo: borderedView.leadingAnchor, constant: 20.0).isActive = true
        textView.topAnchor.constraint(equalTo: borderedView.topAnchor,constant: 11.0).isActive = true
        textView.trailingAnchor.constraint(equalTo: borderedView.trailingAnchor, constant: -20.0).isActive = true
        textView.bottomAnchor.constraint(equalTo: borderedView.bottomAnchor, constant: -11.0).isActive = true
        textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 22.0).isActive = true
        
    }
    
    @objc
    func sendButtonAction(){
        guard let text = textView.text, !text.isEmpty else { return }
        textView.text = ""
        guard let userId = Database.shared.currentUser?.id, let convId = conversation.id else { return }
        let date = Date().timeIntervalSince1970
        let message = ChatMessage(id: nil, conversationId: convId, authorId: userId, messageText: text, messageImageUrl: nil, created: date, createdBy: userId, lastUpdated: date, lastUpdatedBy: userId, archived: false, archivedAt: nil)
        Database.shared.save(message) { (message, error) in
            
        }
        
        conversation.lastMessageText = text
        Database.shared.save(conversation) { (conversation, error) in
            
        }
    }
    
    func loadMessages() {
        datasource.removeAll()
        guard let convId = conversation.id else { return }
        ChatMessage.getMessages(conversationId: convId) { (messages, error) in
            guard let messages = messages else { return }
            let sorted = messages.sorted(by: {$0.created < $1.created})
            for message in sorted {
                guard !self.datasource.contains(where: { $0.id == message.id }) else { continue }
                self.datasource.append(message)
                self.tableView.insertRows(at: [IndexPath(row: self.datasource.count - 1, section: 0)], with: .automatic)
                self.tableView.scrollToRow(at: IndexPath(row: self.datasource.count - 1, section: 0), at: .bottom, animated: true)
            
            }

        }
    }
    
}

extension ConversationController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.reusIdentifier(), for: indexPath)
        cell.selectionStyle = .none
        
        if let cell = cell as? MessageCell {
            cell.configure(message: datasource[indexPath.row])
        }
        return cell
    }
}

extension ConversationController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
    }
}

private extension ConversationController {
    
    @objc func keyboardAppeared(notification: Notification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            
            if endFrameY >= UIScreen.main.bounds.size.height {
                self.chatBottomContainerAnchor?.constant = -0.0
            } else {
                let offset = UIScreen.main.bounds.size.height - endFrameY
                self.chatBottomContainerAnchor?.constant = -offset + 5.0
            }
            UIView.animate(withDuration: duration, delay: TimeInterval(0), options: animationCurve, animations: {
                            self.view.layoutIfNeeded() }, completion: nil)
            }
                
        }
    }
