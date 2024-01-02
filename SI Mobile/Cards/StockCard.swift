
import SwiftUI

struct StockCard: View {
    var item: StockItem
    var body: some View {
        VStack{
            HStack{
                Text(item.Grade)
                Spacer()
                Text(item.Status)
            }
            List{
                HStack{
                    Text("Quantity")
                    Spacer()
                    Text("\(item.Quantity)")
                }
                HStack{
                    Text("Allocated Quantity")
                    Spacer()
                    Text("\(item.AllocatedQty)")
                }
                HStack{
                    Text("Location")
                    Spacer()
                    Text(item.Location)
                }
                HStack{
                    Text("Location Type")
                    Spacer()
                    Text(item.LocationType)
                }
                HStack{
                    Text("Lot")
                    Spacer()
                    Text(item.Lot)
                }
            }
        }
    }
}

//
//struct StockCard_Previews: PreviewProvider {
//    static var previews: some View {
//        StockCard(item: StockItem.sample1)
//    }
//}


#Preview {
    StockCard(item: StockItem.sample1)
}
