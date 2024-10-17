//
//  CoreDataManager.swift
//  App-Contact
//
//  Created by Carlos Eduardo Gurdian on 14/10/24.
//

import Foundation
import CoreData
    //ContactApp
final class CoreDataManager {
    private let modelName: String
    
    // MARK: - Persistent Container
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "App_Contact")

        
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                // Mejor manejo de errores, podrías lanzar una excepción o mostrar un mensaje en la UI
                fatalError("Error al cargar el almacén persistente: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    // MARK: - Contexto
    lazy var context: NSManagedObjectContext = persistentContainer.viewContext
    
    // Inicializador del CoreDataManager, cargando el nombre del modelo
    init(modelName: String) {
        self.modelName = modelName
    }
    
    // MARK: - Save Context
    func save() {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch {
            print("Error al guardar el contexto: \(error.localizedDescription)")
            // Aquí podrías registrar el error o manejarlo de otra manera, como mostrar una alerta
        }
    }
    
    // MARK: - Delete Object
    func delete(object: NSManagedObject) {
        context.delete(object)
        save() // Guardar el contexto para confirmar la eliminación
    }
    
    // MARK: - Fetch Request Helper
    func fetch<T: NSManagedObject>(_ objectType: T.Type, completion: @escaping (Result<[T], Error>) -> Void) {
        let entityName = String(describing: objectType)
        let request = NSFetchRequest<T>(entityName: entityName)
        
        do {
            let fetchedObjects = try context.fetch(request)
            completion(.success(fetchedObjects))
        } catch {
            completion(.failure(error))
        }
    }
}

