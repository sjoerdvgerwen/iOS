//
//  AtlasView.swift
//  GOceries
//
//  Created by Bram on 15/03/2022.
//

import SwiftUI
import ARKit
import UIKit

struct ArView : UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ArViewController {
        UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ArViewController") as! ArViewController //theoretically unsafe to unwrap like this with `!`, but we know it works, since the view controller is included in the storyboard
    }
    
    func updateUIViewController(_ uiViewController: ArViewController, context: Context) {
    }
}


struct ArView_Previews: PreviewProvider {
    static var previews: some View {
        ArView()
    }
}
