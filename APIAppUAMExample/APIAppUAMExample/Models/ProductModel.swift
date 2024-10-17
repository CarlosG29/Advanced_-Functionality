//
//  ProductModel.swift
//  APIAppUAMExample
//
//  Created by Macbook on 3/10/24.
//

struct ProductResponse: Decodable {
    let products: [ProductModel]
}

struct ProductModel: Hashable, Codable {
    let id: Int?
    let title: String
    let description: String
    let price: Double
    let stock: Double
    let thumbnail: String
    let category: String
    let brand: String
    let discountPercentage: Double
}
