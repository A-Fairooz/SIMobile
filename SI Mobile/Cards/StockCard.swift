
import SwiftUI

struct StockCard: View {
    var item: StockItem
    var cWidth: CGFloat = 100
    @State private var expanded = false
    @State var showLot: Bool
    var body: some View {
        
        
        VStack(spacing:0){
            
            if(!expanded){
                
                Button(action:{expanded.toggle()}){
                    HStack{
                        UnevenRoundedRectangle()
                            .fill(Color(.siorange))
                            .clipShape(.rect(cornerRadii: RectangleCornerRadii.init(topLeading: 8, bottomLeading: 8, bottomTrailing: 0, topTrailing: 0))
                            )
                           
                            .frame(width:75,height:65)
                            .overlay(Text("\(item.status)").foregroundColor(.white))
                                               
                            HStack{
                                Text("\(item.location)").foregroundColor(.black)
                                Spacer()
                                VStack(alignment:.trailing){
                                    StockCardHText("Grade",item.grade)
                                    StockCardHText("Free Qty","\(item.freeQuantity)")
                                }
                            }
                        Spacer()
                        Text("+").frame(width:30)
                    }
                } .frame(height:65)
                    
                
            }
            else{
                VStack(spacing:0){
                    Button(action:{expanded.toggle()}){
                        HStack{
                            UnevenRoundedRectangle()
                                .fill(Color(.siorange))
                                .clipShape(.rect(cornerRadii: RectangleCornerRadii.init(topLeading: 8, bottomLeading: 0, bottomTrailing: 0, topTrailing: 0))
                                )
                            
                                .frame(width:75,height:65)
                                .overlay(Text("\(item.status)").foregroundColor(.white))
                            
                            HStack{
                                Text("\(item.location)").foregroundColor(.black)
                                Spacer()
                                VStack(alignment:.trailing){
                                    StockCardHText("Grade",item.grade)
                                    StockCardHText("Free Qty","\(item.freeQuantity)")
                                }
                            }
                            Spacer()
                            Text("+").frame(width:30)
                        }
                        
                    } .frame(height:65)
                    Divider().padding(0).frame(height:0)
                }
                VStack{
                    HStack{
                        Text("Total Quantity").foregroundColor(.gray)
                        Spacer()
                        Text("\(item.quantity)")
                    }
                    Divider()
                    HStack{
                        Text("Allocated Quantity").foregroundColor(.gray)
                        Spacer()
                        Text("\(item.allocatedQuantity)")
                    }
                    Divider()
                    HStack{
                        Text("Free Quantity").foregroundColor(.gray)
                        Spacer()
                        Text("\(item.freeQuantity)")
                    }
                    Divider()
                    HStack{
                        Text("Status").foregroundColor(.gray)
                        Spacer()
                        Text("\(item.status)")
                    }
                    Divider()
                    HStack{
                        Text("Grade").foregroundColor(.gray)
                        Spacer()
                        Text("\(item.grade)")
                    }
                    Divider()
                    HStack{
                        Text("Location").foregroundColor(.gray)
                        Spacer()
                        Text("\(item.location)")
                    }
                    Divider()
                    HStack{
                        Text("Location Type").foregroundColor(.gray)
                        Spacer()
                        Text("\(item.locationType)")
                    }
                    if(showLot){
                        Divider()
                        HStack{
                            Text("Lot").foregroundColor(.gray)
                            Spacer()
                            Text("\(item.lot)")
                        }
                    }
                }
                .padding(15)
                .padding([.vertical],10)
                
            }
            
        }
       
        
        .background(
            RoundedRectangle(cornerRadius:16)
                .fill(.white)
                .shadow(color:Color(.sRGB,red:0,green:0,blue:0,opacity:0.1),radius:10,x:3,y:3))
        
        
    }
}

struct StockCardHText:View{
    var text: String
    var value: String
    init(_ text: String,_ value: String){
        self.text = text
        self.value = value
    }
    var body: some View{
        HStack{
            Text(text).foregroundColor(Color(.systemGray))
            Text(value).foregroundColor(.black)
        }
    }
}
struct StockCardVText:View{
    var text: String
    var value: String
    init(_ text: String,_ value: String){
        self.text = text
        self.value = value
    }
    var body: some View{
        VStack(alignment:.leading){
            Text(text).foregroundColor(Color(.systemGray2))
            Text(value).foregroundColor(.black)
        }
    }
}

//struct StockCard_Previews: PreviewProvider {
//    static var previews: some View {
//        StockCard(item: StockItem.sample1)
//    }
//}


#Preview {
    StockCard(item: StockItem.sample1, showLot:true)
}
