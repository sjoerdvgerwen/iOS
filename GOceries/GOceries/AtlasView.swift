//
//  AtlasView.swift
//  GOceries
//
//  Created by Bram on 15/03/2022.
//

import SwiftUI
import UIKit

struct AtlasView: UIViewControllerRepresentable{
            
    func updateUIViewController(_ uiViewController: ImageViewController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> ImageViewController {
        let atlasView = ImageViewController()
        IndoorAtlasManager().authenticateIALocationManager()
        
        return atlasView
    }
}


struct AtlasView_Previews: PreviewProvider {
    static var previews: some View {
        AtlasView()
    }
}
