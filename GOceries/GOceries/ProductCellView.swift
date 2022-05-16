import SwiftUI

struct ProductCellView: View {
    
    var product: Product
    var productStore: ProductStore
    
    var body: some View {
        HStack{
            
            VStack{
                AsyncImage(url: URL(string: product.images[0]))
                { image in
                           image
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                               .frame(height: 40.0)
                       } placeholder: {
                           Image(systemName: "photo")
                               .imageScale(.large)
                               .foregroundColor(.gray)
                       }
                       .ignoresSafeArea()
                       .clipShape(Circle())
                       .clipped()
            }
            VStack(alignment: .leading){
                if product.name == "Dip"{
                    HStack{
                        Text("Still to grab: ")
                            .font(.system(size: 13, design: .rounded))
                            .foregroundColor(.red)
                        
                    BeaconRangeView()
                        .font(.system(size: 15, design: .rounded))
                        .foregroundColor(.gray)
                    }
                }
                Text(product.brand)
                    .font(.system(size: 15, design: .rounded))
                    .foregroundColor(.gray)
                Text(product.name)
                    .font(.system(size: 26, design: .rounded))
                Text("€ \(String(format: "%.2f", product.price))")
                    .font(.system(size: 24, design: .rounded))
                    .foregroundColor(.orange)
                    .bold()
            }
            
            Spacer()
            
            VStack{
                Spacer()
                HStack{
                    Button(action: {
                        productStore.removeOneFromAmount(product: product)
                    }){
                        ZStack{
                            Rectangle()
                                .frame(width:30, height: 30)
                                .foregroundColor(.cyan.opacity(0.1))
                        VStack{
                        Image(systemName: "minus")
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 2, height: 2)
                    .padding()
                    .foregroundColor(.orange)
                    .cornerRadius(10)
                    Text("\(product.amount)")
                    Button(action: {
                        productStore.addOneToAmount(product: product)
                                }){
                                    ZStack{
                                        Rectangle()
                                            .frame(width:30, height: 30)
                                            .foregroundColor(.cyan.opacity(0.1))
                                    VStack{
                                    Image(systemName: "plus")
                                        }
                                    }
                                }
                                .frame(width: 2, height: 2)
                                .padding()
                                .foregroundColor(.orange)
                                .cornerRadius(10)
                                
                                
                                
                            }.buttonStyle(PlainButtonStyle())
                .background(.cyan.opacity(0.1))
                .cornerRadius(10)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

struct ProductCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCellView(product: Product(name: "ivan", brand: "Tesst", images: [""], price: 200.00, amount: 1), productStore: ProductStore()).previewLayout(.sizeThatFits)
    }
}

