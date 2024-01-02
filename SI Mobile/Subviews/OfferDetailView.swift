
import SwiftUI

struct OfferDetailView: View {
    @StateObject var util:Util
    let offer: BERTItem
    @State private var stockTrigger = false
    @State private var sku = ""
    var body: some View {
        VStack{
            List{
                Section("Product"){
                    SITitleText("Barcode",offer.barcode)
                    SITitleText("Supplier",offer.supplier)
                    SITitleText("Description",offer.productDescription)
                    SITitleText("Id",String(offer.Id))
                }
                Section("Pricing"){
                    SITitleText("Price","\(String(format:"\(offer.currencySymbol)%.2f", offer.price))")
                    SITitleText("Currency",offer.currency)
                    SITitleText("Landed Cost",String(format: "£%.2f", round((Double(truncating: offer.landedCost as NSNumber) * 100) / 100.0)))
                    SITitleText("Quantity",offer.qty)
                    SITitleText("RRP",String(format: "£%.2f", offer.rrp))
                }
                Section("Detail"){
                    SITitleText("Brand",offer.brand)
                    SITitleText("Size",offer.size)
                    SITitleText("Product Type",offer.productType)
                    SITitleText("Offer Date",offer.fmtOfferDate)
                    SITitleText("Import Date",offer.fmtImportDate)
                    SITitleText("Status",offer.stockStatus)
                    SITitleText("Batch Id",offer.batchId)
                }
                
            }
            
            HStack{
                SINav(text: "Find Product", destination: ProductDetailsView(util: util, searchTrigger: true, upcSearch: offer.barcode))
                
                SIButton(action: {checkStock()}, text:"Check Stock").padding(10)
               
            }
            
            } .navigationDestination(isPresented: $stockTrigger){
                StockDetailView(util: util, sku: sku)
        }
    }
    
    func checkStock(){
        util.loading = true
        API().getSKUFromUPC(upc: offer.barcode){data in
            if !data.isEmpty{
                sku = data
                DispatchQueue.main.asyncAfter(deadline: .now() + 1 ){
                    stockTrigger = true
                    util.loading = false
                }
            }
            else{
                util.alertText = "No product with UPC [\(offer.barcode)] found"
                util.showAlert = true
                util.loading = false
            }
           
        }
    }
    
    func findProduct(){
        util.loading = true
        API().getSKUFromUPC(upc: offer.barcode){data in
            if !data.isEmpty{
                sku = data
                DispatchQueue.main.asyncAfter(deadline: .now() + 1 ){
                    stockTrigger = true
                    util.loading = false
                }
            }
            else{
                util.alertText = "No product with UPC [\(offer.barcode)] found"
                util.showAlert = true
                util.loading = false
            }
           
        }
    }
    
    
}

struct OfferDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OfferDetailView(util:Util(), offer:BERTItem.sampleData[0])
    }
}
