//
//  BarcodeScannerView.swift
//  GOceries
//
//  Created by Bram on 18/02/2022.
//

import SwiftUI

struct UpsellingView: View {
    
    @Binding var isUpselling: Bool
    var productStore: ProductStore
    @State private var presentMe = false

                        
    var body: some View {
        
            Text("")
            .sheet(isPresented: $isUpselling){
                NavigationView{
                VStack{
                    HStack{
                        Spacer()
                    }
                    HStack{
                        Text("Also add?")
                            .font(.system(size: 30, weight: .medium, design: .rounded))
                    }
                    HStack{
                        Image("UpsellingDip")
                    }
                    Spacer()
                    HStack{
                        Text("Dorito's")
                            .foregroundColor(.gray)
                    }
                    HStack{
                        Text("Dip")
                    }
                    HStack{
                        
                        //NavigationLink(destination: BeaconView(), isActive: $presentMe){
                            Button(action: {
                                self.productStore.products.append(Product(name: "Dip", brand: "Dorito's", images: ["https://media.spar.nl/productdetail/doritos-dipsaus-dipsaus-hot-salsa-326-Gram-2362260-7783.jpg"], price: 0.50, amount: 1))
                                    self.presentMe = true
                                self.isUpselling.toggle()
                                            }, label: {
                            Image(systemName: "plus")
                                            .frame(width: 80, height: 80)
                                            .padding()
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .font(.system(size: 60))
                                            .cornerRadius(10)
                                            
                        })
                        //}
                    }
                    }
                }
                }
        }
    }


struct UpsellingView_Previews: PreviewProvider {
    static var previews: some View {
        UpsellingView(isUpselling: .constant(false), productStore: ProductStore())
    }
}
