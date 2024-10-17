//
//  AddContact.swift
//  App-Contact
//
//  Created by Carlos Eduardo Gurdian on 14/10/24.
//

import UIKit

class AddContactViewController: UIViewController {

    // MARK: Closure
    var onContactAdded: (() -> Void)?
    
    // MARK: VIEWS
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var basicInfoView: UIView!
    private var contactInfoView: UIView!
    private var controller: MainController
    private var nameField                   = ContactTextField(frame: .zero, keyboardType: .default, placeholder: "Name")
    private var lastNameField               = ContactTextField(frame: .zero, keyboardType: .default, placeholder: "Last Name")
    private var emailField                  = ContactTextField(frame: .zero, keyboardType: .emailAddress, placeholder: "Email")
    private var phoneNumberField            = ContactTextField(frame: .zero, keyboardType: .phonePad, placeholder: "Phone Number")
    
    let padding: CGFloat        = 20
    let heightItem: CGFloat     = 45
    
    init(controller: MainController) {
        self.controller = controller
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: didLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        setupUI()
        setNavigationBar()
        setInfoView()
        setContactInfo()
    }
    
    // MARK: Navigation
    private func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveContact))
        navigationItem.title = "Add Contact"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
    }
    
    // MARK: Setting UI
    private func setupUI() {
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        contentView = UIView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints  = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    // MARK: INFO VIEW
    private func setInfoView() {
        basicInfoView = UIView()
        contentView.addSubview(basicInfoView)
        basicInfoView.layer.cornerRadius = 10
        basicInfoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            basicInfoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            basicInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            basicInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            basicInfoView.heightAnchor.constraint(equalToConstant: CGFloat(heightItem * 2))
        ])
        
        let itemList = [nameField, lastNameField]
        for item in itemList {
            basicInfoView.addSubview(item)
            
            NSLayoutConstraint.activate([
                item.leadingAnchor.constraint(equalTo: basicInfoView.leadingAnchor, constant: 5),
                item.trailingAnchor.constraint(equalTo: basicInfoView.trailingAnchor, constant: -5),
                item.heightAnchor.constraint(equalToConstant: heightItem)
            ])
        }
        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: basicInfoView.topAnchor),
            lastNameField.topAnchor.constraint(equalTo: nameField.bottomAnchor),
            lastNameField.bottomAnchor.constraint(equalTo: basicInfoView.bottomAnchor),
        ])
    }
    
    // MARK: ContactInfo
    private func setContactInfo() {
        contactInfoView = UIView()
        contactInfoView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contactInfoView)
        let itemList = [phoneNumberField, emailField]
        
        for item in itemList {
            contactInfoView.addSubview(item)
            
            NSLayoutConstraint.activate([
                item.leadingAnchor.constraint(equalTo: basicInfoView.leadingAnchor, constant: 5),
                item.trailingAnchor.constraint(equalTo: basicInfoView.trailingAnchor, constant: -5),
                item.heightAnchor.constraint(equalToConstant: heightItem)
            ])
        }
        
        NSLayoutConstraint.activate([
            contactInfoView.topAnchor.constraint(equalTo: basicInfoView.bottomAnchor, constant: 20),
            contactInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            contactInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            contactInfoView.heightAnchor.constraint(equalToConstant: CGFloat(heightItem * 2)),
            
            phoneNumberField.topAnchor.constraint(equalTo: contactInfoView.topAnchor),
            emailField.topAnchor.constraint(equalTo: phoneNumberField.bottomAnchor),
            emailField.bottomAnchor.constraint(equalTo: contactInfoView.bottomAnchor),
        ])
    }
    
    // MARK: SaveContact
    @objc func saveContact() {
        guard let name = nameField.text, !name.isEmpty else {
            nameField.placeholder = "* Name is required"
            print("Introduce el nombre")
            return
        }
        
        controller.saveContact(name: name,
                               phoneNumber: phoneNumberField.text ?? "",
                               email: emailField.text ?? "",
                               lastName: lastNameField.text ?? "")
        onContactAdded?()
        dismiss(animated: true)
    }
    
    // MARK: Cancel
    @objc func cancel() {
        dismiss(animated: true)
    }
}
