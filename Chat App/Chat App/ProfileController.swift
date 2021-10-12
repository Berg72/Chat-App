//
//  ProfileController.swift
//  Chat App
//
//  Created by Mark bergeson on 9/26/21.
//

import UIKit
import PhotosUI
import FirebaseStorage

class ProfileController: UIViewController {
    
    private let nameField = UITextField()
    private let profileImageView = UIImageView()
    private let placeholderImageView = UIImageView()
    private let imageLabel = UILabel()
    private let profileImageButton = UIButton(type: .roundedRect)
    
    private var changedImage = false
    
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
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 70.0
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.masksToBounds = true
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = 1.0
        profileImageView.layer.borderColor = UIColor(white: 151.0 / 255.0, alpha: 1.0).cgColor
        containerView.addSubview(profileImageView)
        
        profileImageView.widthAnchor.constraint(equalToConstant: 140.0).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 140.0).isActive = true
        profileImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        placeholderImageView.translatesAutoresizingMaskIntoConstraints = false
        placeholderImageView.image = UIImage(named: "image-placeholder")
        placeholderImageView.contentMode = .scaleAspectFit
        containerView.addSubview(placeholderImageView)
        
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        imageLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        imageLabel.textColor = .blue1
        imageLabel.textAlignment = .center
        imageLabel.numberOfLines = 2
        imageLabel.lineBreakMode = .byWordWrapping
        imageLabel.text = "Tap to add your\nprofile photo"
        containerView.addSubview(imageLabel)
        
        imageLabel.widthAnchor.constraint(equalToConstant: 130.0).isActive = true
        imageLabel.heightAnchor.constraint(equalToConstant: 36.0).isActive = true
        imageLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 80.0).isActive = true
        imageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        placeholderImageView.widthAnchor.constraint(equalToConstant: 56.0).isActive = true
        placeholderImageView.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        placeholderImageView.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 26.0).isActive = true
        placeholderImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        profileImageButton.translatesAutoresizingMaskIntoConstraints = false
        profileImageButton.addTarget(self, action: #selector(displayPhotoPicker), for: .touchUpInside)
        containerView.addSubview(profileImageButton)
        
        profileImageButton.widthAnchor.constraint(equalToConstant: 140.0).isActive = true
        profileImageButton.heightAnchor.constraint(equalToConstant: 140.0).isActive = true
        profileImageButton.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        profileImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let urlString = Database.shared.currentUser?.profileImageUrl, let url =
            URL(string: urlString) {
            DispatchQueue.global().async {
                guard let data = try? Data(contentsOf: url) else { return }
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.profileImageView.image = image
                    self.placeholderImageView.isHidden = true
                    self.imageLabel.isHidden = true
                }
            }
        }
        
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
        nameField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 40.0).isActive = true
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
            
            if let image = self.profileImageView.image,
               let data = image.jpegData(compressionQuality: 0.2), self.changedImage {
                let reference = Storage.storage().reference()
                let ref = reference.child("images/\(NSUUID().uuidString).jpg")
                
                ref.putData(data, metadata: nil) { (metadata, error) in
                    ref.downloadURL { (url, error) in
                        guard let url = url else { return }
                        guard var user = Database.shared.currentUser else { return }
                        user.profileImageUrl = url.absoluteString
                        Database.shared.currentUser = user
                        Database.shared.save(user) { (user, error) in
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc
    func closeAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    func displayPhotoPicker() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
}

extension ProfileController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if let itemsProvider = results.first?.itemProvider,
           itemsProvider.canLoadObject(ofClass: UIImage.self) {
            itemsProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    guard let self = self else {
                        picker.dismiss(animated: true, completion: nil)
                        return
                    }
                    if let image = image as? UIImage {
                        self.changedImage = true
                        self.profileImageView.image = image
                        self.placeholderImageView.isHidden = true
                        self.imageLabel.isHidden = true
                        picker.dismiss(animated: true, completion: nil)
                    }
                }
            }
        } else {
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
