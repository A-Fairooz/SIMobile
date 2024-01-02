
import SwiftUI

struct ProductDetailsView: View {
    //@Binding var viewIndex: Int
    @StateObject var util: Util
    @State var searchTrigger  = false
    @State var skuSearch = ""
    @State var upcSearch = ""
    @State private var product = ZPRODUCT()
    @State private var loading = false
    
    
    
    var body: some View {
        
        VStack(alignment:.center){
            
            List{
                if(product.sku != nil){
                    SICarousel(sku: $product.sku)
                }
                Section(header: Text("Product Info")){
                    SITitleText("UPC", product.upc)
                    SITitleText("SKU", product.sku)
                    SITitleText("Description", product.description)
                    SITitleText("Product Type", product.pType)
                }
                if !util.cMode{
                    Section(header: Text("Pricing & Stock")){
                        SITitleText("Stock", "\(product.stock ?? 0)")
                        SITitleText("Volume Price", String(format: "£%.2f", product.volPrice ?? 0.00))
                        SITitleText("Cost Price", String(format: "£%.2f", product.costPrice ?? 0.00))
                        SITitleText("RRP", String(format: "£%.2f", product.rrp ?? 0.00))
                    }
                }
                Section(header: Text("Details")){
                    SITitleText("Brand", product.brand)
                    SITitleText("Range", product.range)
                    SITitleText("Size", product.size)
                    SITitleText("Category", product.category)
                    SITitleText("Sub-Category", product.subcat)
                }
                Section(header: Text("Additional Info")){
                    SITitleText("Variant", product.variant)
                    SITitleText("Edition", product.edition)
                    SITitleText("Colour", product.color)
                    SITitleText("Gender", product.gender)
                }
            }
            
            if(product.sku != nil && !util.cMode){
                HStack{
                    SINav(text: "Stock", destination: StockDetailView(util:util, sku: product.sku ?? ""))
                    SIButton(action: {BERTSearch()}, text:"BERT")
                }.padding(10)
            }
            
            
        }
        .onAppear{handleSearch()}
        .toolbar{
            ToolbarItem(placement: .principal){
                Text(String("\(product.sku ?? "")"))
                    .foregroundColor(.white)
            }
        }
        .toolbarBackground(Color.sigreendark, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
    
    func handleSearch(){
        
        if searchTrigger{
            searchTrigger = false
            if skuSearch.isEmpty{
                SearchUPC()
            }
            else{
                SearchSKU()
            }
        }
    }
    
    func SearchSKU(){
        util.loading = true
        API().getZProductBySKU(sku: skuSearch){data in
            product = data
            util.loading = false
            if product.sku == nil || product.sku!.isEmpty {
                util.alertText = "No Product Found, please check your SKU is correct, if the problem persists please contact a member of IT"
                util.showAlert = true
            }
        }
        
    }
    func SearchUPC(){
        util.loading = true
        API().getZProductByUPC(upc: upcSearch){data in
            product = data
            util.loading = false
            if product.sku == nil || product.sku!.isEmpty {
                util.alertText = "No Product Found, please check your UPC is correct, if the problem persists please contact a member of IT"
                util.showAlert = true
            }
        }
        
    }
    
    func BERTSearch(){
        util.bertUPC = product.upc!
        util.bertSearch = true
        util.viewIndex = 3
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView(util: Util(), searchTrigger: true, skuSearch: "10000001")
    }
}
