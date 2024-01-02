
import SwiftUI

struct OfferCard: View {
    let offer: BERTItem
    private let cWidth: CGFloat = 100
    var body: some View {
        VStack(alignment: .center){
            HStack{
                Text(offer.productDescription).font(.subheadline)
                Spacer(minLength: 25)
                Text(offer.fmtOfferDate)
            }.frame(height:50, alignment:.trailing).inExpandingRectangle().fixedSize(horizontal: false, vertical: true)
            HStack{
                Text(offer.supplier).foregroundColor(.gray)
                Spacer()
                Text(offer.stockStatus).foregroundColor(.gray)
            }.font(.footnote)
            HStack(spacing:10){
                VStack{
                    Text("Qty")
                    Text(offer.qty == "0" ? "---" : offer.qty)
                }
                .padding(5)
                .frame(width:cWidth)
                .foregroundColor(.white)
                .background(Color(.systemBlue))
                .cornerRadius(10)
                
                VStack{
                    Text("Price")
                    Text("\(offer.currencySymbol)\(String(format: "%.2f", Double(truncating: offer.price as NSNumber)))")
                }
                .padding(5)
                .frame(width:cWidth)
                .foregroundColor(.white)
                .background(Color(.systemBlue))
                .cornerRadius(10)
                
                
                VStack{
                    Text("Landed")
                    Text("£\(String(format: "%.2f", Double(truncating: offer.landedCost as NSNumber)))")
                }
                .padding(5)
                .frame(width:cWidth)
                .foregroundColor(.white)
                .background(Color(.systemBlue))
                .cornerRadius(10)
                
            }
        }
    }
}

struct OfferCard_Previews: PreviewProvider {
    static var previews: some View {
        OfferCard(offer: BERTItem.sampleData[0])
    }
}
