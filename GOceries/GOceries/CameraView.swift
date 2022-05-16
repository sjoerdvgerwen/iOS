//
//  CameraView.swift
//  GOceries
//
//  Created by Bram on 15/03/2022.
//

import SwiftUI
import UIKit

struct CameraView: View {
    
    @State var image: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    var body: some View {
        VStack{
            ImagePicker(selectedImage: $image, sourceType: sourceType)
                .edgesIgnoringSafeArea(.all)
    }
}
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}


struct ImagePicker: UIViewControllerRepresentable{
    
    @Binding var selectedImage: UIImage?
    var sourceType: UIImagePickerController.SourceType
    
    @Environment(\.dismiss) var dismiss
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        imagePicker.view.subviews
            .filter { $0.isKind(of: UIButton.self) }
                    .forEach { $0.isHidden = true }
        
        imagePicker.view.subviews
            .filter { $0.isKind(of: UINavigationBar.self) }
                    .forEach { $0.isHidden = true }
        
        return imagePicker
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(photo: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        
        var _imagePicker : ImagePicker
        
        init(photo imagePicker: ImagePicker){
            _imagePicker = imagePicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[.originalImage] as? UIImage{
                
                _imagePicker.selectedImage = image
            }
                
            _imagePicker.dismiss()
        }
        
    }
}
