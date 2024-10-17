//
//  Untitled.swift
//  App-Contact
//
//  Created by Carlos Eduardo Gurdian on 14/10/24.
//

import Foundation

struct ContactModel: Hashable {
    let id: String
    let name: String
    let lastName: String?
    let email: String?
    let phone: String?
    
    // Inicializador para convertir un objeto de Core Data (Contact) a ContactModel
    init(contact: Contact) {
        self.id = contact.id?.uuidString ?? UUID().uuidString
        self.name = contact.name ?? ""
        self.lastName = contact.lastName
        self.email = contact.email
        self.phone = contact.phoneNumber
    }
    
    var section: LetterSection {
        return LetterSection(firstLetter: name) ?? .Z
    }
}

// Enum para las secciones de letras
enum LetterSection: String {
    case A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z

    init?(firstLetter: String) {
        guard let first = firstLetter.first else { return nil }
        self.init(rawValue: String(first).uppercased())
    }
}
