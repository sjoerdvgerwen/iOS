//
//  BarcodeScannerView.swift
//  GOceries
//
//  Created by Bram on 18/02/2022.
//

import SwiftUI
import AVFoundation
import CodeScanner

struct BarcodeScannerView: View {
    @Binding var isPresentingScanner: Bool
    @Binding var isUpselling: Bool
    var productStore: ProductStore
    @State var scannedCode: String = ""
    
    var scannerSheet: some View{
        CodeScannerView(codeTypes: [.ean13],
                        completion: {result in
                            if case let .success(code) = result{
                            self.scannedCode = code.string
                            print(scannedCode)
                               
                            if scannedCode != ""{
                                //productStore.fetchProduct(ean: scannedCode)
                                productStore.products.append(Product(name: "nacho cheese", brand: "Dorito's", images: ["https://static.ah.nl/static/product/AHI_43545239373137303537_3_LowRes_JPG.JPG"], price: 1.75, amount: 1))
                            }
                                self.isPresentingScanner = false
                                self.isUpselling = true
                            }
                            })
    }
                        
    
    var body: some View {
        
            
            Text("")
            .sheet(isPresented: $isPresentingScanner){
                self.scannerSheet
            
        }
    }
}

struct BarcodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeScannerView(isPresentingScanner: .constant(false), isUpselling: .constant(false), productStore: ProductStore())
    }
}
