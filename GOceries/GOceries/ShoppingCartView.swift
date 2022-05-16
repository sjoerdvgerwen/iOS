//
//  ContentView.swift
//  GOceries
//
//  Created by Bram on 16/02/2022.
//

import SwiftUI

struct ShoppingCartView: View {
    
    @ObservedObject var productStore = ProductStore()
    var orderStore = OrderStore()
    @State private var scanEnabled = false
    @State private var productAmount = 1.0
    @State var isPresentingScanner = false
    @State var isUpselling = false
    
    var body: some View {
        ZStack{
        VStack{
            if self.scanEnabled{
                ProductSortView(amount: $productAmount, scanEnabled: $scanEnabled, productStore: productStore)
                    .transition(.opacity)
                    .navigationBarItems(trailing: Button(action: {
                        withAnimation(.linear){
                            self.scanEnabled.toggle()
                        }
                    })
                    {
                        Text("Cancel")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    )
            }
            if self.isPresentingScanner{
                BarcodeScannerView(isPresentingScanner: $isPresentingScanner, isUpselling: $isUpselling, productStore: productStore)
                    .transition(.opacity)
                    .navigationBarItems(trailing: Button(action: {
                        withAnimation(.linear){
                            self.isPresentingScanner.toggle()
                        }
                    })
                    {
                        Text("Cancel")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    )
            }
                if self.isUpselling{
                    UpsellingView(isUpselling: $isUpselling, productStore: productStore)
                        .transition(.opacity)
                        .navigationBarItems(trailing: Button(action: {
                            withAnimation(.linear){
                                self.isUpselling.toggle()
                            }
                        })
                        {
                            Text("Cancel")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                        }
                        )
            }
            
//            List(productStore.products){ product in
//                ProductCellView(product: product, productStore: productStore)
//                    .padding(.vertical, 5)
//            }
            List{
                ForEach(productStore.products, id: \.id){product in
                     ProductCellView(product: product, productStore: productStore)
                                    .padding(.vertical, 5)
                    
                                   }.onDelete(perform: self.productStore.deleteProduct)
            }
            
            .navigationBarTitle("Shopping cart", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                withAnimation(.linear){
                    self.scanEnabled.toggle()
                }
            })
            {
                Text("Sort")
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(){
            self.productStore.fetchProducts()
        }
            VStack {
                Spacer()
                if self.productStore.products.count == 0{
                    Text("Nothing in shopping cart.")
                        .foregroundColor(.gray)
                }
                
                            Spacer()
                            HStack {
                                Spacer()
                                Spacer()
                                Spacer()
                                if self.productStore.products.count != 0{Button(action: {
                                    self.orderStore.checkOut(products: productStore.products)
                                    self.productStore.checkOut()
                                }){
                                    Text("Proceed to checkout")
                                        .foregroundColor(.white)
                                        .font(.system(.headline, design: .rounded))                        .padding()
                                        .frame(height: 50)
                                }
                                    .background(.orange)
                                    .cornerRadius(15)
                                }
                                
                                Spacer()
                                Button(action: {
                                    self.isPresentingScanner.toggle()
                                }){
                                    Image(systemName: "barcode.viewfinder")
                                    .frame(width: 70, height: 70)
                                    .foregroundColor(.white)
                                    .font(.system(size: 40))
                                }
                                .background(.blue)
                                .cornerRadius(38.5)
                                .padding()
                                .shadow(color: .black.opacity(0.3),
                                        radius: 3,
                                        x: 3,
                                        y: 3)
                            }
                        }
                            
        }
    }
}

struct ShoppingCartView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCartView()
    }
}
