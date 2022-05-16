//
//  ProductScanView.swift
//  GOceries
//
//  Created by Bram on 16/02/2022.
//

import SwiftUI

struct ProductSortView: View {
    
    @Binding var amount: Double
    @Binding var scanEnabled: Bool
    var productStore: ProductStore
    
    var minAmount = 1.00
    var maxAmount = 20.00
    
    var body: some View {
        VStack{
            Text("Amount of product \(Int(amount))")
                .font(.system(.headline, design: .rounded))
            HStack{
                Slider(value: $amount, in: minAmount...maxAmount, step: 1)
                    .accentColor(.purple)
            }
            HStack{
                Text("\(Int(minAmount))")
                    .font(.system(.footnote, design: .rounded))
                
                Spacer()
                
                Text("\(Int(maxAmount))")
                    .font(.system(.footnote, design: .rounded))
            }
            Button(action: {
                productStore.addProducts(product: Product(name: "Product", brand: "", images: [""], price: 200, amount: Int(amount)))
                
                scanEnabled.toggle()
                
                playSound(key: "scanner-beep-sound")
            }){
                Image(systemName: "plus")
                }
                                .frame(width: 80, height: 80)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .font(.system(size: 60))
                                .cornerRadius(10)

            }
        
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
}

struct ProductSortView_Previews: PreviewProvider {
    static var previews: some View {
        ProductSortView(amount: .constant(1.0), scanEnabled: .constant(true), productStore: ProductStore())
    }
}
