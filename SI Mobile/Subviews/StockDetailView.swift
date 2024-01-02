
import SwiftUI

struct StockDetailView: View {
    @StateObject var util: Util
    @State var sku: String
    @State private var data: X3Model = X3Model()
    var body: some View {
        VStack{
            List{
                Section(header: Text("PRODUCT")){
                    SITitleText("SKU","\(data.paramS1.zitmref)")
                    SITitleText("ZSTOFCY","\(data.paramS1.zstofcy)")
                    SITitleText("Globally Allocated Quantity Remaining","\(data.headret.zgloall)")
                }
                ForEach(data.listret){grade in
                    Section(header: HStack { Text("GRADE: \(grade.zstoflD1)").font(.title); Spacer();Text("STATUS: \(grade.zsta)").font(.title) }) {
                        
                        SITitleText("Quantity","\(grade.zqtystu)")
                        SITitleText("Allocated Quantity","\(grade.zcumallqty)")
                        SITitleText("Free Quantity","\(grade.zfreeqty)")
                        SITitleText("Status","\(grade.zsta)")
                        SITitleText("Wholesale Price","£\(String(format: "%.2f", grade.zwpri))")
                        SITitleText("Volume Price","£\(String(format: "%.2f", grade.zvpri))")                       
                        
                    }
                }
             
            }
        }
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
    func loadStock(){
        util.loading = true
        API().getExtendedProdData(productCode: sku){data in
            self.data = data
            util.loading = false
        }
    }
}

struct StockDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StockDetailView(util: Util(), sku: "")
    }
}
