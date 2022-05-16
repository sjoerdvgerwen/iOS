//
//  Product.swift
//  GOceries
//
//  Created by Bram on 16/02/2022.
//

import Foundation

struct Order: Identifiable{
    var id = UUID()
    var products: [Product]
    var totalPrice: Double
    var dateOfOrder: Date
    
    init(products: [Product], totalPrice: Double, dateOfOrder: Date){
        self.products = products
        self.totalPrice = totalPrice
        self.dateOfOrder = dateOfOrder
    }
    
    func formatDate(date: Date) -> String{
            
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
        }
    
    func calculateTotalPrice() -> Double{
            
        var total: Double = 0
        for product in products {
            total += product.price * Double(product.amount)
        }

        return total
    }
}

extension Order: Codable{
    enum CodingKeys: String, CodingKey{
        case products
        case totalPrice
        case dateOfOrder
    }
    
    init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        products = try values.decode([Product].self, forKey: .products)

        totalPrice = try values.decode(Double.self, forKey: .totalPrice)

        dateOfOrder = try values.decode(Date.self, forKey: .dateOfOrder)
    }
}
