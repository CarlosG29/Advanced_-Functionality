//
//  Contactinfo.swift
//  App-Contact
//
//  Created by Carlos Eduardo Gurdian on 14/10/24.
//

import UIKit

class ContactCell: UITableViewCell {
    
    static let reuseIdentifier: String = "ContactCell"

    let contactName                     = ContactTitleLabel(textAlignment: .left, fontSize: 14)
    private let padding: CGFloat        = 5
    private let textPadding: CGFloat    = 10
    let divider                         = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String? = ContactCell.reuseIdentifier) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set Contact
    func setContact(contactModel: ContactModel) {
        contactName.text        = "\(contactModel.name)  \(contactModel.lastName ?? "")"
    }
    
    // MARK: CELL
    private func configureCell() {
        addSubview(contactName)
        addSubview(divider)
        divider.backgroundColor = .systemGray4
        // MARK: Contraints
        NSLayoutConstraint.activate([
            contactName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textPadding),
            contactName.centerYAnchor.constraint(equalTo: centerYAnchor),
            contactName.heightAnchor.constraint(equalToConstant: 18),
            contactName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -textPadding),
            
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor),
            divider.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
