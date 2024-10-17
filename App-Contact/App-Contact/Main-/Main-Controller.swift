//
//  Untitled.swift
//  App-Contact
//
//  Created by Carlos Eduardo Gurdian on 14/10/24.
//

import Foundation
import UIKit
import CoreData

final class MainController {
    private let coreDataManager = CoreDataManager(modelName: "App_Contact")
    
    func getContacts() -> [Contact] {
        // Creamos un fetchRequest de tipo Contact explícitamente
        let fetchRequest: NSFetchRequest<Contact> = NSFetchRequest<Contact>(entityName: "Contact")
        
        do {
            let contacts = try coreDataManager.context.fetch(fetchRequest)
            return contacts
        } catch {
            print("Fetch Error: \(error.localizedDescription)")
        }
        return []
    }




    
    func saveContact(name: String, phoneNumber: String?, email: String?, lastName: String?) {
            // Inicializa el objeto Contact utilizando el contexto de Core Data
            let newContact = Contact(context: coreDataManager.context)
            
            newContact.id = UUID() // Asigna un ID único al nuevo contacto
            newContact.name = name
            newContact.phoneNumber = phoneNumber
            newContact.email = email
            newContact.lastName = lastName
            
            // Guarda los cambios en el contexto de Core Data
            coreDataManager.save()
        }
        
        func deleteContact(contact: Contact) {
            coreDataManager.context.delete(contact)
            coreDataManager.save()
        }
    }

