//
//  ContentView.swift
//  GOceries
//
//  Created by Bram on 16/02/2022.
//

import SwiftUI

struct OrderHistoryView: View {
    
    @ObservedObject var orderStore = OrderStore()
    
    var body: some View {
        ZStack{
            VStack{
            
            List(orderStore.orders){ order in
                OrderCellView(order: order)
                    .padding(.vertical, 5)
            }
            .navigationBarTitle("Order history", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                withAnimation(.linear){
                    orderStore.clearOrders()
                }
            })
            {
                if orderStore.orders.count != 0{
                Text("Clear")
                    .font(.subheadline)
                    .foregroundColor(.primary)
                }
            }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(){
            self.orderStore.fetchOrders(){_ in
                
            }
        }
        if self.orderStore.orders.count == 0{
            VStack{
                Text("No previous orders.")
                    .foregroundColor(.gray)
            }
        }
    }
    }
}

struct OrderHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryView()
    }
}
