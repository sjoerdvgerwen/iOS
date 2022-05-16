//
//  ProductStore.swift
//  GOceries
//
//  Created by Bram on 16/02/2022.
//

import Foundation
import SwiftUI

class ProductStore: Decodable, ObservableObject{
    @Published var products: [Product] = []
    var products2: [Product] = []
    var product: Product = Product(name: "ivan", brand: "Tesst", images: [""], price: 200.00, amount: 1)
    
    enum CodingKeys: CodingKey{
            case products
    }
        
    required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
        products2 = try values.decode([Product].self, forKey: .products)
            
    }

    init(){
        
    }
    
    func fetchProducts(){
            
                DispatchQueue.main.async {
                    //self.products = [Product(name: "ivan", description: "uganda", price: 200)]
                    self.products = self.products
                }
        }
    
    func addProducts(product: Product){
        
            self.products.append(product)
        
        }
    
    func fetchProduct(ean: String){
        
        guard let apiUrl = URL(string: "https://api.barcodelookup.com/v3/products?barcode=\(ean)&formatted=y&key=9br55slhxbizibflg8jh9xoazm00jk") else {
                    return
                }
                
                let request = URLRequest(url: apiUrl)
                let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
                
                if let error = error{
                    print(error)
                    return
                }
                if let data = data {
                    print(apiUrl)
                    DispatchQueue.main.async {
                        self.products2 = self.parseJsonData(data: data)
                        print(self.products2[0])
                        self.products.append(self.products2[0])
                    }
                }
                })
                
                task.resume()
        
        }
    
    func parseJsonData(data: Data) -> [Product]{
            let decoder = JSONDecoder()
            
            do{
                let productstore = try decoder.decode(ProductStore.self, from: data)
                self.products2 = productstore.products2
            }catch{
                print(error)
            }
            return products2
        }

    
    func addOneToAmount(product: Product){
        
        let index = products.firstIndex(where: {$0.id == product.id})
        if index != nil {products[index ?? 0].amount += 1}
    }
    
    func removeOneFromAmount(product: Product){
        
        if product.amount == 1 {
                    return
                }
        
        let index = products.firstIndex(where: {$0.id == product.id})
        if index != nil {products[index ?? 0].amount -= 1}
    }
    
    func checkOut(){
        
        products = []
    }
    
    func deleteProduct(indexSet: IndexSet){
        
        let id = indexSet.map{products[$0].id}
        DispatchQueue.main.async {
            print(id[0])
            let index = self.products.firstIndex(where: {$0.id == id[0]})
            self.products.remove(at: index ?? 0)
        }
    }
}
