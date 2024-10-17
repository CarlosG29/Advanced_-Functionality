//
//  MainViewController.swift
//  APIAppUAMExample
//
//  Created by Macbook on 3/10/24.
//

import UIKit

enum Section  {
    case main
}

class MainViewController: UIViewController, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, !query.isEmpty else {
            loadData() // Si no hay término de búsqueda, carga todos los productos
            return
        }
        
        // Filtrar los productos basados en el término de búsqueda
        Task {
            products = await mainController.getProducts(query: query) ?? []
            applySnapshot() // Actualizar la tabla con los resultados filtrados
        }
    }

    
    
    typealias DataSource = UITableViewDiffableDataSource<Section, ProductModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, ProductModel>
    
    private let mainController = MainController()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search products"
        searchController.searchResultsUpdater = self
        
        return searchController
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    private var products = [ProductModel]()
    
    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(tableView: tableView) { [weak self] tableView, indexPath, productModel in
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell
            cell?.titleProductLabel.text = productModel.title
            cell?.priceProductLabel.text = "$\(productModel.price)"
            
            Task {
                cell?.imageProductView.image = await self?.mainController.loadImage(url: productModel.thumbnail)
            }
            
            return cell
        }
        
        return dataSource
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self // Configurar el delegate
        title = "Products"
        
        searchControllerConfiguration()
        configureButtons()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    private func loadData() {
        Task {
            products = await mainController.getProducts() ?? []
            applySnapshot()
        }
    }
    
    func registerCell() {
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
    }
    
    private func configureButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addProduct))
    }
    
    @objc func addProduct() {
        performSegue(withIdentifier: "goToAddProduct", sender: self)
    }
    
    private func searchControllerConfiguration() {
        navigationItem.searchController = searchController
    }
    
    func applySnapshot() {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(products)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - UISearchResultsUpdating

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = products[indexPath.row]
        
        let detailVC = ProductDetailViewController()
        detailVC.productId = selectedProduct.id // Pasar el ID del producto seleccionado
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
