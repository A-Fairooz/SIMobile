
import SwiftUI
//import CodeScanner

struct ProductTabView: View {
    @StateObject var util: Util
    
    @State var skuSearch = ""
    @State var skuDisabled = true
    @State var upcSearch = ""
    @State var upcDisabled = true
    @State private var isScanning = false
    
    @State private var skuTrigger = false
    @State private var upcTrigger = false
    
    var body: some View
    {
        LoadingView(isShowing: $util.loading){
            NavigationStack{
                VStack(spacing:30){
                    Image("S_FINAL_FINAL")
                        .resizable()
                        .frame(width:150, height:150)
                    
                    Spacer()
                        .frame(height:50)
                    VStack{
                        HStack(spacing:0){
                            TextField("SKU",text: $skuSearch).onChange(of:skuSearch){skuChanged($0)}
                                .padding(5)
                                .background(Color(.systemGray6) )
                                .frame(width: 200)
                                .keyboardType(.numberPad)
                            SINav(text:"Search SKU",destination: ProductDetailsView(util:util, searchTrigger: true, skuSearch:skuSearch)).disabled(skuDisabled)
                                .frame(width: 150)
                        }
                        HStack(spacing:0){
                            TextField("UPC",text: $upcSearch).onChange(of:upcSearch){upcChanged($0)}
                                .padding(5)
                                .background(Color(.systemGray6) )
                                .frame(width: 200)
                                .keyboardType(.numberPad)
                            SINav(text:"Search UPC", destination:ProductDetailsView(util:util, searchTrigger: true, upcSearch:upcSearch)).disabled(upcDisabled)
                                .frame(width: 150)
                        }
                    }
                    VStack{
                        SIButton(action:{startScan()},text:"Scan", width:150)
                            .sheet(isPresented: $isScanning) {
                                NavigationView {
                                    CodeScannerView(codeTypes: [.ean8, .ean13, .upce], scanMode: .once, showViewfinder: true, simulatedData: "8411061695951", completion: handleScan)
                                        .toolbar {
                                            ToolbarItem(placement: .bottomBar) {
                                                Button("Cancel") {
                                                    isScanning = false
                                                }
                                            }
                                        }
                                }
                            }
                        SINav(text:"Search by brand", destination: BrandListView(util:util), width:150)
                    }
                }
          
                .navigationDestination(isPresented: $upcTrigger){
                    ProductDetailsView(util:util, searchTrigger: true, upcSearch:upcSearch)
                }
            }
        }
    }
    
    func startScan() {
        isScanning = true
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isScanning = false
        switch result {
        case let .success(result):
            let details = result.string
            var upc = ""
            upc = details
            upc = upc.replacingOccurrences(of: " ", with: "")
            if !upc.isEmpty {
                upcSearch = upc
                util.loading = true
                triggerUPCSearch()
            }
            else{
                util.alertText = "No barcode found"
                util.showAlert = true
            }
        case let .failure(error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
    func triggerUPCSearch(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            util.loading = true
            upcTrigger = true
        }
    }
    
    func skuChanged(_ text: String){
        if text.isEmpty || text.count < 8 {
            skuDisabled = true
        }
        else{
            if text.count > 8{
                skuSearch = String(text.dropLast())
            }
            skuDisabled = false
        }
    }
    
    func upcChanged(_ text: String){
        if text.isEmpty{
            upcDisabled = true
        }
        else{
            upcDisabled = false
        }
    }
}

struct ProductTabView_Previews: PreviewProvider {
    static var previews: some View {
        ProductTabView(util: Util())
    }
}
