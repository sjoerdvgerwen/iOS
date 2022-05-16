//
//  ProductStore.swift
//  GOceries
//
//  Created by Bram on 16/02/2022.
//

import Foundation
import SwiftUI

class OrderStore: Decodable, ObservableObject{
    @Published var orders: [Order] = []
    
    private static var goceriesOrderURL = "https://goceries-4100b-default-rtdb.europe-west1.firebasedatabase.app/.json"
    private static var goceriesPutOrderURL = "https://goceries-4100b-default-rtdb.europe-west1.firebasedatabase.app/orders.json"
    
    enum CodingKeys: CodingKey{
            case orders
    }
        
    required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            orders = try values.decode([Order].self, forKey: .orders)
    }

    init(){
        
    }
    
    func fetchOrders(completion: @escaping (Bool)->()){
        guard let orderUrl = URL(string: Self.goceriesOrderURL) else {
                    return
                }

                
                let request = URLRequest(url: orderUrl)
                let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
                
                if let error = error{
                    print(error)
                    completion(false)
                    return
                }
                if let data = data {
                    DispatchQueue.main.async {
                        self.orders = self.parseJsonData(data: data)
                        completion(true)
                    }
                }
                })

                task.resume()
        
        }
    
    func parseJsonData(data: Data) -> [Order]{
            let decoder = JSONDecoder()
            
            do{
                let orderstore = try decoder.decode(OrderStore.self, from: data)
                self.orders = orderstore.orders
            }catch{
                print(error)
            }

            return orders
        }
    
    func checkOut(products: [Product]){
        
        
        
        fetchOrders() {result in
            if result{

        let orderToPut = Order(products: products, totalPrice: 0, dateOfOrder: Date())
        var ordersToPut: [Order] = []
        ordersToPut.append(orderToPut)
            for order in self.orders {
            ordersToPut.append(order)
        }
        
                self.putOrders(ordersToPut: ordersToPut){_ in
                    
                }
        }
        }
    }
        
    
    func putOrders(ordersToPut: [Order], completion: @escaping (Bool)->()){
        
        guard let orderUrl = URL(string: Self.goceriesPutOrderURL) else {
                    return
                }

                var request = URLRequest(url: orderUrl)
                request.httpMethod = "PUT"
                let task = URLSession.shared.uploadTask(with: request, from: encodeJsonData(ordersToPut: ordersToPut)) { (responseData, response, error) in
                
                if let error = error{
                    print(error)
                    completion(false)
                    return
                }
                    if responseData != nil {
                    print("Successfully put orders")
                    completion(true)
                }
                }
                
                task.resume()
        }
    
    func encodeJsonData(ordersToPut: [Order]) -> Data{
        //var ordersToPut2 = ordersToPut
        //ordersToPut2[0].products.append(Product(name: "ivan", brand: "Tesst", images: [""], price: 200.00, amount: 1))
            let encoder = JSONEncoder()
        var data: Data = Data()
            
        do{
            data = try encoder.encode(ordersToPut)
        }catch{
            print(error)
        }
        return data
        }
    
    func clearOrders(){
        
        guard let orderUrl = URL(string: Self.goceriesPutOrderURL) else {
                    return
                }
        
        let jsonDictionary: [String: [Order]] = [
            "orders": [],
        ]

        let data = try! JSONSerialization.data(withJSONObject: jsonDictionary, options: .prettyPrinted)

                var request = URLRequest(url: orderUrl)
                request.httpMethod = "PUT"
                let task = URLSession.shared.uploadTask(with: request, from: data) { (responseData, response, error) in
                
                if let error = error{
                    print(error)
                    return
                }
                    if responseData != nil {
                    print("Successfully cleared orders")
                        DispatchQueue.main.async {
                            self.orders = []
                        }
                }
                }
                
                task.resume()
        }
}
