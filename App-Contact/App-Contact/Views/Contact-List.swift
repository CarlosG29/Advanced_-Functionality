    //
    //  Contact-List.swift
    //  App-Contact
    //
    //  Created by Carlos Eduardo Gurdian on 14/10/24.
    //

import UIKit

class ContactList: UIViewController {

    typealias DataSource = UITableViewDiffableDataSource<LetterSection, ContactModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<LetterSection, ContactModel>

    var filteredContactList = [ContactModel]() // Lista filtrada de contactos
    var contactList = [ContactModel]() // Lista completa de contactos
    var contactMap = [ContactModel: Contact]() // Mapeo entre ContactModel y Contact
    var isSearching = false // Variable para saber si estamos buscando
    private var tableView: UITableView!
    let controller = MainController()
    var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UINavigationBar.appearance().tintColor = .systemTeal
        configureTableView()
        configureDataSource()
        createAddButton()
        configureSearchController()
        updateData(contactList: contactList)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        getData()
    }
    
    // MARK: - Get Data
    private func getData() {
        // Obtener contactos de Core Data
        let contacts = controller.getContacts() // Esto devuelve [Contact]
        
        // Limpia el mapeo anterior
        contactMap.removeAll()

        // Convertir [Contact] a [ContactModel] y mapearlos
        contactList = contacts.map { contact in
            let model = ContactModel(contact: contact)
            contactMap[model] = contact // Guardar el mapeo
            return model
        }
        
        // Actualizar la tabla con los ContactModel
        updateData(contactList: contactList)
    }
    
    // MARK: - TableView Configuration
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
        tableView.delegate = self // Asignamos el delegate solo aquí
        tableView.backgroundColor = .systemBackground
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.reuseIdentifier)
    }

    // MARK: - DataSource Configuration
    private func configureDataSource() {
        dataSource = DataSource(tableView: tableView) { (tableView, indexPath, itemIdentifier) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.reuseIdentifier, for: indexPath) as? ContactCell
            cell?.setContact(contactModel: itemIdentifier)
            return cell
        }
    }

    // MARK: - Update Data
    func updateData(contactList: [ContactModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.Z]) // Para simplificar, todos los contactos se ponen en la sección Z
        snapshot.appendItems(contactList)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    // MARK: - Add Button
    private func createAddButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addContact))
    }

    @objc private func addContact() {
        let addContactVC = AddContactViewController(controller: controller)
        addContactVC.onContactAdded = { [weak self] in
            self?.getData()
        }
        present(UINavigationController(rootViewController: addContactVC), animated: true)
    }

    // MARK: - Search Controller
    private func configureSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search contacts"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - TableView Delegate Methods
extension ContactList: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Obtener el contacto seleccionado
        if let contactModel = dataSource.itemIdentifier(for: indexPath),
           let selectedContact = contactMap[contactModel] { // Mapa del modelo a la entidad Contact
            
            // Crear la vista de detalles
            let detailVC = ContactDetailViewController()
            detailVC.contact = selectedContact // Pasar el contacto seleccionado
            
            // Navegar a la vista de detalles
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
            if let contactModelToDelete = self.dataSource.itemIdentifier(for: indexPath),
               let contactToDelete = self.contactMap[contactModelToDelete] { // Obtener el Contact original
                self.controller.deleteContact(contact: contactToDelete) // Borrar el Contact original
                completion(true)
                self.getData()
            }
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeActions
    }
}

// MARK: - Search Results Updating
extension ContactList: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            isSearching = false
            updateData(contactList: contactList)
            return
        }
        
        isSearching = true
        
        // Filtrar la lista de contactos con base en el texto ingresado
        filteredContactList = contactList.filter { contact in
            contact.name.lowercased().contains(searchText.lowercased()) ||
            (contact.lastName?.lowercased().contains(searchText.lowercased()) ?? false)
        }
        
        // Actualizar los datos con los contactos filtrados
        updateData(contactList: filteredContactList)
    }
}
