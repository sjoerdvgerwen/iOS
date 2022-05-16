//
//  HomeView.swift
//  GOceries
//
//  Created by Sjoerd van Gerwen on 22/02/2022.
//

import SwiftUI

    struct Item: Identifiable {
        let id = UUID()
        let title: String
        let image: String
        let imgColor: Color
        
    }
    
    
    struct HomeView: View {
        
        let items = [
            Item(title: "Scannen", image: "home", imgColor: .orange),
            Item(title: "Bonnetjes", image: "money", imgColor: .green),
            Item(title: "Transacties", image: "bank", imgColor: Color.black.opacity(0.8)),
            Item(title: "Aanbiedingen", image: "vaction", imgColor: .green)]
    
    
    let spacing: CGFloat = 4
    @State private var numberOfRows = 2

    var body: some View {
        
        let columns = Array(
            repeating: GridItem(.flexible(), spacing: spacing), count: numberOfRows)
        NavigationView{
        ScrollView {
            
            headerView
            
            LazyVGrid(columns: columns, spacing: spacing) {
                
                NavigationLink(destination: ShoppingCartView()) {
                    ItemView(item: Item(title: "Scanning", image: "barcode.viewfinder", imgColor: .blue))
                }
                NavigationLink(destination: OrderHistoryView()) {
                    ItemView(item: Item(title: "Transactions", image: "eurosign.square", imgColor: .orange))
                }
                NavigationLink(destination: FloorPlanView()) {
                    ItemView(item: Item(title: "Floorplan", image: "map", imgColor: Color.black.opacity(0.8)))
                }
                NavigationLink(destination: FinderView()) {
                    ItemView(item: Item(title: "Finder", image: "mappin.square", imgColor: .green))
                }
            }
            .buttonStyle(ItemButtonStyle(cornerRadius: 20))
            .padding(.horizontal)
            .offset(y: -60)
        }
        .background(Color.white)
        .ignoresSafeArea()
        }
    }
        
        var headerView: some View {
            VStack {
                Image("Alex")
                    .resizable()
                    .frame(width: 110, height: 110)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                
                Text("Welcome back, Alex")
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .medium, design: .rounded))
            }
            
            
            .frame(height: 350)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
        }
}

struct ItemButtonStyle: ButtonStyle{
    let cornerRadius: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            configuration.label
            
            if configuration.isPressed {
                Color.black.opacity(0.2)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.2), radius: 10, y: 5)
    }
}


struct ItemView: View {
    
    let item: Item
   
    var body: some View {
                
        GeometryReader { reader in
            
            let fontSize = min(reader.size.width * 0.2, 28)
            let imageWidth: CGFloat = min(50, reader.size.width * 0.6)
            
            
            VStack(spacing: 5) {
                Image(systemName: item.image)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(item.imgColor)
                    .frame(width: imageWidth)
                
                Text(item.title)
                    .font(.system(size: fontSize, weight: .bold, design:
                                        .rounded))
                    .foregroundColor(Color.black.opacity(0.9))
            }
            .frame(width: reader.size.width, height:reader.size.height)
            .background(Color.white)
        }
        .frame(height:150)
 //       .clipShape(RoundedRectangle(cornerRadius: 20))
 //       .shadow(color: Color.black.opacity(0.2), radius: 10, y: 5)
        
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
