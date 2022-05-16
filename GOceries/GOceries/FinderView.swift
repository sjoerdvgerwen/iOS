//
//  FinderView.swift
//  GOceries
//
//  Created by Bram on 14/03/2022.
//

import SwiftUI

struct FinderView: View {
    
    let names = ["Chips", "Tomatoes", "Peanut butter", "Bread"]
    @State private var searchText = ""
    
    var body: some View {
            
                    List {
                        ForEach(searchResults, id: \.self) { name in
                            NavigationLink(destination: ArView().edgesIgnoringSafeArea(.all)) {
                                Text(name)
                            }
                        }
                    }
                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Product Search")
                    .navigationTitle("Finder")
                
    }
    
    var searchResults: [String] {
            if searchText.isEmpty {
                return names
            } else {
                return names.filter { $0.contains(searchText) }
            }
        }
}

struct FinderView_Previews: PreviewProvider {
    static var previews: some View {
        FinderView()
    }
}
