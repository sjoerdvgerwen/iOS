//
//  Product.swift
//  GOceries
//
//  Created by Bram on 16/02/2022.
//

import Foundation

struct Product: Identifiable{
    var id = UUID()
    var name: String
    var brand: String
    var images: [String]
    var price: Double
    var amount: Int
    
    init(name: String, brand: String, images: [String], price: Double, amount: Int){
        self.name = name
        self.brand = brand
        self.images = images
        self.price = price
        self.amount = amount
    }
    
    var roundedPrice: Double{
        let roundedValue = Double(round(1000 * price) / 1000)
        
        return roundedValue
    }

}

extension Product: Codable{
    enum CodingKeys: String, CodingKey{
        case name = "title"
        case brand
        case images
        case price
        case amount
    }
    
    init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decode(String.self, forKey: .name)
                
        brand = try values.decode(String.self, forKey: .brand)
        
        images = try values.decode([String].self, forKey: .images)
        
        price = try values.decode(Double.self, forKey: .price)
        
        amount = try values.decode(Int.self, forKey: .amount)
    }
}
