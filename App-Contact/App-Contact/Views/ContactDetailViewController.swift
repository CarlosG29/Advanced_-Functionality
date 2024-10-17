//
//  ContactDetailViewController.swift
//  App-Contact
//
//  Created by Carlos Eduardo Gurdian on 14/10/24.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    var contact: Contact? // Variable para recibir el contacto seleccionado

    // MARK: - UI Elements
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let buttonsStackView = UIStackView()
    private let phoneLabel = UILabel()
    private let emailLabel = UILabel()
    private let phoneTitleLabel = UILabel()
    private let emailTitleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        loadContactDetails()
    }
    
    // Configuración de la interfaz
    private func setupUI() {
        // Configuración de la imagen de perfil
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 50
        profileImageView.layer.masksToBounds = true
        view.addSubview(profileImageView)
        
        // Configuración del nombre
        nameLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        nameLabel.textColor = .label
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        // Configuración del stack de botones
        buttonsStackView.axis = .horizontal
        buttonsStackView.alignment = .center
        buttonsStackView.spacing = 20
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsStackView)
        
        // Agregar los botones
        let messageButton = createButton(title: "message", imageName: "message.fill")
        let callButton = createButton(title: "call", imageName: "phone.fill")
        let mailButton = createButton(title: "mail", imageName: "envelope.fill")
        
        buttonsStackView.addArrangedSubview(messageButton)
        buttonsStackView.addArrangedSubview(callButton)
        buttonsStackView.addArrangedSubview(mailButton)
        
        // Configuración de los detalles del teléfono y correo
        phoneTitleLabel.text = "mobile"
        phoneTitleLabel.font = UIFont.systemFont(ofSize: 14)
        phoneTitleLabel.textColor = .secondaryLabel
        phoneTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(phoneTitleLabel)
        
        phoneLabel.font = UIFont.systemFont(ofSize: 18)
        phoneLabel.textColor = .label
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(phoneLabel)
        
        emailTitleLabel.text = "email"
        emailTitleLabel.font = UIFont.systemFont(ofSize: 14)
        emailTitleLabel.textColor = .secondaryLabel
        emailTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailTitleLabel)
        
        emailLabel.font = UIFont.systemFont(ofSize: 18)
        emailLabel.textColor = .label
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailLabel)
        
        // Constraints
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            buttonsStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            phoneTitleLabel.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 40),
            phoneTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            phoneLabel.topAnchor.constraint(equalTo: phoneTitleLabel.bottomAnchor, constant: 5),
            phoneLabel.leadingAnchor.constraint(equalTo: phoneTitleLabel.leadingAnchor),
            
            emailTitleLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 20),
            emailTitleLabel.leadingAnchor.constraint(equalTo: phoneTitleLabel.leadingAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: emailTitleLabel.bottomAnchor, constant: 5),
            emailLabel.leadingAnchor.constraint(equalTo: emailTitleLabel.leadingAnchor)
        ])
    }
    
    // Método auxiliar para crear botones con íconos
    private func createButton(title: String, imageName: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setImage(UIImage(systemName: imageName), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.tintColor = .systemBlue
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    // Cargar detalles del contacto
    private func loadContactDetails() {
        guard let contact = contact else { return }
        
        // Configurar la imagen de perfil
        profileImageView.image = UIImage(systemName: "person.circle") // Puedes usar una imagen del contacto si existe
        
        // Cargar los detalles
        nameLabel.text = contact.name
        phoneLabel.text = contact.phoneNumber ?? "No phone number"
        emailLabel.text = contact.email ?? "No email"
    }
}
