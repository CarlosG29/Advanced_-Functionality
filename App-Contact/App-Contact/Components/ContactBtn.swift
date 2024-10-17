//
//  ContactBtn.swift
//  App-Contact
//
//  Created by Carlos Eduardo Gurdian on 14/10/24.
//

import UIKit

class ContactButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints   = false
        backgroundColor                              = .tertiarySystemBackground
        titleLabel?.font                             = UIFont.systemFont(ofSize: 14, weight: .bold)
        tintColor                                    = .label
        layer.cornerRadius                           = 10
    }
}
