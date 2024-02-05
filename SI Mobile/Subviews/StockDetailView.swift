
import SwiftUI

struct StockDetailView: View {
    @StateObject var util: Util
    @State var sku: String
    @State private var stockItems = [StockItem]()
    @State private var viewableStockItems = [StockItem]()
    @State private var site = ""
    @State private var totalQty = 0
    @State private var totalAlloc = 0
    @State private var totalFree = 0
    @State private var mergeLots = true
    @State private var stockSort = StockSort.Free_Quantity
    @State private var sortDir = StockSortDir.Descending
    var body: some View {
        
        VStack(spacing:5){
            
            VStack{
                HStack{Text("SKU").foregroundColor(.gray);Spacer();Text(sku)}
                HStack{Text("Total Quantity").foregroundColor(.gray);Spacer();Text("\(totalQty)")}
                HStack{Text("Total Allocated").foregroundColor(.gray);Spacer();Text("\(totalAlloc)")}
                HStack{Text("Total Free").foregroundColor(.gray);Spacer();Text("\(totalFree)")}
            }.padding(15)
                .background(
                    RoundedRectangle(cornerRadius:16)
                        .fill(.white)
                        .shadow(color:Color(.sRGB,red:0,green:0,blue:0,opacity:0.1),radius:10,x:3,y:3))
                .padding([.horizontal],10)
            
            HStack{
                Text("Merge Lots")
                Spacer()
                Toggle("", isOn:$mergeLots).onChange(of:mergeLots){_ in
                    toggleLotMerge()
                }
            }.padding(15)
            
            HStack{
                Text("Sort By")
                Picker("Sort Type", selection: $stockSort){
                    ForEach(StockSort.allCases, id:\.self) {Text(String(describing:$0).description.replacingOccurrences(of: "_", with: " "))}
                }.onChange(of:stockSort){_ in
                    sortStock()}
                
                Picker("Sort Direction", selection: $sortDir){
                    ForEach(StockSortDir.allCases, id:\.self) {Text(String(describing:$0))}
                }.onChange(of:sortDir){_ in
                sortStock()}
            }
            
            ScrollView{
                VStack(spacing:15){
                    ForEach(viewableStockItems, id:\.self){item in
                        StockCard(item:item, showLot: !mergeLots)
                    }.padding([.horizontal],10)
                }   .padding([.vertical],10)
            }
            
            
        }.padding([.vertical],10)
        .onAppear{
            loadStock()
        }
        .toolbar{
            ToolbarItem(placement: .principal){
                Text("Stock")
                    .foregroundColor(.white)
            }
        }
        .toolbarBackground(Color.sigreendark, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func toggleLotMerge(){
        if(mergeLots){
            var d = [String:StockItem]()
            for item in stockItems{
                let key = "\(item.grade)-\(item.status)-\(item.lot)-\(item.location)"
                if d[key] != nil{
                    d[key]!.quantity += item.quantity
                    d[key]!.allocatedQuantity += item.allocatedQuantity
                    d[key]!.freeQuantity += item.freeQuantity
                }
                else{
                    d[key] = item
                }
            }
            viewableStockItems = Array(d.values)
            
        }
        else{
            viewableStockItems = stockItems
        }
        sortStock()
    }
    func loadStock(){
        util.loading = true
        totalQty = 0
        totalAlloc = 0
        totalFree = 0
        API().getProductStock(sku){data in
          
                stockItems = data
            
            for i in stockItems{
                totalQty += i.quantity
                totalAlloc += i.allocatedQuantity
                totalFree += i.freeQuantity
            }
            toggleLotMerge()
            util.loading = false
        }
    }
    
    func sortStock(){
       
        
        switch(stockSort){
       
        case .Free_Quantity:
            viewableStockItems = viewableStockItems.sorted{a,b in
                return sortDir == .Descending ? a.quantity > b.quantity : a.quantity < b.quantity
            }
            break;
        case .Location:
            viewableStockItems = viewableStockItems.sorted{(channel1, channel2) -> Bool in
                let a = channel1.location
                let b = channel2.location
                return (a.description.localizedCaseInsensitiveCompare(b) == (sortDir == .Ascending ? .orderedAscending : .orderedDescending))
            }
            break;
        case .Location_Type:
            viewableStockItems = viewableStockItems.sorted{(channel1, channel2) -> Bool in
                let a = channel1.locationType
                let b = channel2.locationType
                return (a.description.localizedCaseInsensitiveCompare(b) == (sortDir == .Ascending ? .orderedAscending : .orderedDescending))
            }
            break;
        case .Grade:
            viewableStockItems = viewableStockItems.sorted{(channel1, channel2) -> Bool in
                let a = channel1.grade
                let b = channel2.grade
                return (a.description.localizedCaseInsensitiveCompare(b) == (sortDir == .Ascending ? .orderedAscending : .orderedDescending))
            }
            break;
        case .Status:
            viewableStockItems = viewableStockItems.sorted{(channel1, channel2) -> Bool in
                let a = channel1.status
                let b = channel2.status
                return (a.description.localizedCaseInsensitiveCompare(b) == (sortDir == .Ascending ? .orderedAscending : .orderedDescending))
            }
            break;
        }
        
    }
}

private enum StockSort: CaseIterable{
    case Free_Quantity
    case Location
    case Location_Type
    case Grade
    case Status
}
private enum StockSortDir: CaseIterable{
    case Ascending
    case Descending
}

//
//
//struct StockDetailView: View {
//    @StateObject var util: Util
//    @State var sku: String
//    @State private var data: X3Model = X3Model()
//    var body: some View {
//        VStack{
//            List{
//                Section(header: Text("PRODUCT")){
//                    SITitleText("SKU","\(data.paramS1.zitmref)")
//                    SITitleText("ZSTOFCY","\(data.paramS1.zstofcy)")
//                    SITitleText("Globally Allocated Quantity Remaining","\(data.headret.zgloall)")
//                }
//                ForEach(data.listret){grade in
//                    Section(header: HStack { Text("GRADE: \(grade.zstoflD1)").font(.title); Spacer();Text("STATUS: \(grade.zsta)").font(.title) }) {
//
//                        SITitleText("Quantity","\(grade.zqtystu)")
//                        SITitleText("Allocated Quantity","\(grade.zcumallqty)")
//                        SITitleText("Free Quantity","\(grade.zfreeqty)")
//                        SITitleText("Status","\(grade.zsta)")
//                        SITitleText("Wholesale Price","£\(String(format: "%.2f", grade.zwpri))")
//                        SITitleText("Volume Price","£\(String(format: "%.2f", grade.zvpri))")
//
//                    }
//                }
//
//            }
//        }
//        .onAppear{
//            loadStock()
//        }
//        .toolbar{
//            ToolbarItem(placement: .principal){
//                Text("Stock")
//                    .foregroundColor(.white)
//            }
//        }
//        .toolbarBackground(Color.sigreendark, for: .navigationBar)
//        .toolbarBackground(.visible, for: .navigationBar)
//        .navigationBarTitleDisplayMode(.inline)
//    }
//    func loadStock(){
//        util.loading = true
//        API().getExtendedProdData(productCode: sku){data in
//            self.data = data
//            util.loading = false
//        }
//    }
//}

struct StockDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StockDetailView(util: Util(), sku: "" )
    }
}
