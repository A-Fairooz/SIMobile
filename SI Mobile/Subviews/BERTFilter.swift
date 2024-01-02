
import SwiftUI
import Sliders

struct BERTFilter: View {
    @Binding var isActive: Bool
    @Binding var offerList: [BERTItem]
    @Binding var viewableList: [BERTItem]
    
    @StateObject var bf: BERTFilterModel
    
    @State var bStatuses = [String]()
    @State var bSuppliers = [String]()
    
    @State var bState: String? = ""
    @State var bSupp: String? = ""
    
    @State var bQtyEnabled = false
    @State var bPriceEnabled = false
    
    @State var bQtyRange: ClosedRange<Float> = 1...100
    @State var bQtyMin: Float = 0.0
    @State var bQtyMax: Float = 100.0
    
    @State var bPriceRange: ClosedRange<Float> = 1...100
    @State var bPriceMin: Float = 0.0
    @State var bPriceMax: Float = 0.0
    
    
    
    var body: some View {
        VStack{
            List{
                HStack{
                    Picker("Supplier",selection: $bSupp){
                        Text("-----").tag("" as String?)
                        ForEach(bSuppliers, id: \.self) { supp in
                            if(!String(supp).isEmpty){
                                Text("\(supp)").tag(supp as String?)
                            }
                        }
                    }
                }
                
                HStack{
                    Picker("Product Status",selection: $bState){
                        Text("-----").tag("" as String?)
                        ForEach(bStatuses, id: \.self) { stat in
                            if(!String(stat).isEmpty){
                                Text("\(stat)").tag(stat as String?)
                            }
                        }
                    }
                }
                
                VStack{
                    HStack{
                        Toggle("Quantity Range",isOn:$bQtyEnabled)
                    }
                    if(bQtyEnabled){
                        VStack{
                            HStack{
                                Text("\(Int(bQtyRange.lowerBound))")
                                Spacer()
                                Text("\(Int(bQtyRange.upperBound))")
                            }
                            SISlider(range:$bQtyRange, min:bQtyMin, max:bQtyMax)
                        }
                    }
                }
                VStack{
                    HStack{
                        Toggle("Price Range",isOn:$bPriceEnabled)
                    }
                    if(bPriceEnabled){
                        VStack(spacing:0){
                            HStack{
                                Text(String(format: "£%.2f",Float(bPriceRange.lowerBound)))
                                Spacer()
                                Text(String(format: "£%.2f",Float(bPriceRange.upperBound)))
                            }
                            SISlider(range:$bPriceRange, min:bPriceMin, max:bPriceMax)
                        }.frame(maxHeight:75)
                    }
                }
            }
            HStack{
                SIButton(action:{applyFilters()}, text: "Apply")
                SIButton(action:{clearFilters()}, text: "Clear")
                SIButton(action:{cancelFilters()}, text: "Cancel")
            }
          
        }.onAppear{
            loadVars()
        }
        
        
    }
    
    func loadVars(){
        
        let suppliers = Set(offerList.map{$0.supplier.trimmingCharacters(in: .whitespacesAndNewlines)}).sorted()
        bSuppliers = suppliers
        let statuses = Set(offerList.map{$0.stockStatus.trimmingCharacters(in:.whitespacesAndNewlines)}).sorted()
        bStatuses = statuses
        
        let qtys = Set(offerList.map{Int($0.qty) ?? 0}).sorted()
        bQtyMax = Float(qtys.first ?? 0)
        bQtyMax = Float(qtys.last ?? 0)
        bQtyRange = bQtyMin...bQtyMax
        
        let prices = Set(offerList.map{$0.price}).sorted()
        bPriceMin = prices.first ?? 0
        bPriceMax = prices.last ?? 0
        bPriceRange = bPriceMin...bPriceMax
        
        if bf.filtered{
            bState = bf.status
            bSupp = bf.supplier
            bQtyEnabled = bf.qtyEnabled
            bPriceEnabled = bf.priceEnabled
            bQtyRange = bf.qtyRange
            bPriceRange = bf.priceRange
        }
        
    }
    
    func applyFilters(){
        var filteredList = offerList
        
        if !(bState ?? "").isEmpty{
            filteredList = filteredList.filter{$0.stockStatus == bState}
        }
        
        if !(bSupp ?? "").isEmpty{
            filteredList = filteredList.filter{$0.supplier == bSupp}
        }
        
        if bQtyEnabled{
            filteredList = filteredList.filter{Float($0.qty.isEmpty ? "0" : $0.qty.digits)! >= bQtyRange.lowerBound && Float($0.qty.isEmpty ? "0" : $0.qty.digits)! <= bQtyRange.upperBound}
        }
        
        if bPriceEnabled{
            filteredList = filteredList.filter{$0.price >= bPriceRange.lowerBound && $0.price <= bPriceRange.upperBound}
        }
        
        viewableList = filteredList
        
        setBfParams()
        isActive = false
        
    }
    
    func setBfParams(){
        bf.status = bState
        bf.supplier = bSupp
        
        bf.qtyEnabled = bQtyEnabled
        bf.qtyRange = bQtyRange
        bf.minQty = bQtyMin
        bf.maxQty = bQtyMax
        
        bf.priceEnabled = bPriceEnabled
        bf.priceRange = bPriceRange
        bf.minPrice = bPriceMin
        bf.maxPrice = bPriceMax
        bf.filtered = true
    }
    func clearBfParams(){
        bf.status = ""
        bf.supplier = ""
        
        bf.qtyEnabled = false
        bf.qtyRange = 0...0
        bf.minQty = 0
        bf.maxQty = 0
        
        bf.priceEnabled = false
        bf.priceRange = 0...0
        bf.minPrice = 0
        bf.maxPrice = 0
        bf.filtered = false
    }
    
    func clearFilters(){
        viewableList = offerList
        clearBfParams()
        isActive = false
    }
    func cancelFilters(){
        //clearFilters()
        isActive = false
    }
}

//struct BERTFilter_Previews: PreviewProvider {
//    static var previews: some View {
//        BERTFilter()
//    }
//}
