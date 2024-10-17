//
//  ProductDetailViewController.swift
//  APIAppUAMExample
//
//  Created by Carlos Eduardo Gurdian on 17/10/24.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    var productId: Int?
    let logoutButton = UIButton(type: .system) // Definir el botón aquí

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Product Detail"
        view.backgroundColor = .white
        
        setupLogoutButton() // Configurar el botón de logout
        fetchProductDetails()
    }
    
    func fetchProductDetails() {
        guard let productId = productId else { return }
        let url = URL(string: "https://api.example.com/products/\(productId)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let product = try JSONDecoder().decode(ProductModel.self, from: data)
                    DispatchQueue.main.async {
                        self.showProductDetails(product: product)
                    }
                } catch {
                    print("Error decoding: \(error)")
                }
            }
        }
        task.resume()
    }
    
    func showProductDetails(product: ProductModel) {
        let titleLabel = UILabel()
        titleLabel.text = "Title: \(product.title)"
        
        let priceLabel = UILabel()
        priceLabel.text = "Price: $\(product.price)"
        
        let categoryLabel = UILabel()
        categoryLabel.text = "Category: \(product.category)"
        
        let brandLabel = UILabel()
        brandLabel.text = "Brand: \(product.brand)"
        
        let discountLabel = UILabel()
        discountLabel.text = "Discount: \(product.discountPercentage)%"
        
        // Aquí puedes agregar las etiquetas a la vista y definir sus constraints
    }
    
    // Configurar el botón de logout
    func setupLogoutButton() {
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        
        view.addSubview(logoutButton)
        
        // Configuración del layout usando Auto Layout
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    @objc func logout() {
        UserDefaults.standard.removeObject(forKey: "authToken") // Limpiar el token de autenticación
        navigationController?.popToRootViewController(animated: true) // Regresar a la vista de login
    }
}

