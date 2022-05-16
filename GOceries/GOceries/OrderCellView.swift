import SwiftUI

struct OrderCellView: View {
    
    var order: Order
    
    var body: some View {
        HStack{
            
            VStack(alignment: .leading){
                Text("Products: \(order.products.count)")
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.gray)
                Text(order.formatDate(date: order.dateOfOrder))
                    .font(.system(.headline, design: .rounded))
            }
            
            Spacer()
            
            VStack(){
                
                Text("€ \(String(format: "%.2f", order.calculateTotalPrice()))")
                    .font(.system(size: 30))
                    .font(.system(.title, design: .rounded))
                    .foregroundColor(.orange)
                    .bold()
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

struct OrderCellView_Previews: PreviewProvider {
    static var previews: some View {
        OrderCellView(order: Order(products: [], totalPrice: 10, dateOfOrder: Date())).previewLayout(.sizeThatFits)
    }
}

