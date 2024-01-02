
import SwiftUI

enum SortDir{
    case None,Asc,Desc
}

enum SortType{
    case Supplier, Date, Qty, Price, Landed
}

struct BERTTabView: View {
    @StateObject var util: Util
    @State var request = BERTRequestItem()
    @State var offerList = [BERTItem]()
    @State var viewableList = [BERTItem]()
    
    @State private var suppSort = (sType: SortType.Supplier, dir: SortDir.None)
    @State private var dateSort = (sType: SortType.Date, dir: SortDir.None)
    @State private var qtySort = (sType: SortType.Qty, dir: SortDir.None)
    @State private var priceSort = (sType: SortType.Price, dir: SortDir.None)
    @State private var landSort = (sType: SortType.Landed, dir: SortDir.None)
    
    @State private var showHeader = true
    
    @State private var isScanning = false
    @State private var image = UIImage()
    @State private var showFilter = false
    
    @State private var supplier: String? = nil
    @State private var status: String? = nil
    
    @StateObject var bf = BERTFilterModel()
    
    //3614220449555
    var body: some View {
        LoadingView(isShowing: $util.loading){
            NavigationStack{
                VStack(spacing:20){
                    if(showHeader){
                        BERTHead(request: $request).padding(10)
                        HStack{
                            SIButton(action:{SearchBERT()}, text:"Search",width:75)
                            SIButton(action:{isScanning = true}, text:"Scan",width:75)
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
                            SIButton(action:{clearParams()}, text:"Clear",width:75)
                        }
                    }
                    VStack{
                        SIButton(action:{toggleHeader()}, text:"\(showHeader ? "^": "⌄")",width:150)
                        if offerList.count > 0 {
                            SIButton(action:{showFilter = true}, text:"Filters",width:150)
                        }                        
                    }
                    Text("Offers: \(viewableList.count)")
                    HStack{
                        Button(action:{toggleSort(suppSort)}){SortText("Supplier", suppSort.dir)}
                        Spacer()
                        Button(action:{toggleSort(dateSort)}){SortText("Date", dateSort.dir)}
                        Spacer()
                        Button(action:{toggleSort(qtySort)}){SortText("Qty", qtySort.dir)}
                        Spacer()
                        Button(action:{toggleSort(priceSort)}){SortText("Price", priceSort.dir)}
                        Spacer()
                        Button(action:{toggleSort(landSort)}){SortText("Landed", landSort.dir)}
                    }.padding(.horizontal,10)
                        .padding(.vertical,20)
                        .foregroundColor(.white)
                        .background(Color.siorange)
                    //TODO
                    List(viewableList, id:\.self){offer in
                        NavigationLink(destination:OfferDetailView(util: util, offer: offer)){OfferCard(offer: offer)}
                    }
                }
                
//                .toolbar{
//                    ToolbarItem(placement: .principal){
//                        Text("BERT")
//                            .foregroundColor(.white)
//                    }
//                }
                .sheet(isPresented:$showFilter){
                    BERTFilter(isActive: $showFilter, offerList: $offerList, viewableList: $viewableList, bf:bf)
                }
            }
        }
        
        .onAppear{
            setBERTParams()
            if util.bertSearch
            {
                request.Barcode = util.bertUPC ;
                SearchBERT()
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
                request.Barcode = upc
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
            SearchBERT()
        }
        
    }
    
    func clearParams(){
        request.EURRate = ""
        request.USDRate = ""
        request.LandedCostPercent = ""
        request.Barcode = ""
        request.SearchTerm = ""
        request.Supplier = ""
        request.StartDate =  Date.init(timeIntervalSinceNow: -604_800)
        request.EndDate = Date()
    }
    func SearchBERT(){
        if request.EURRate.isEmpty || request.USDRate.isEmpty || request.LandedCostPercent.isEmpty {
            util.alertText = "Please check required fields"
            util.showAlert = true
            util.loading = false
            return
        }
        util.loading = true
        API().fetchData(req: request){data in
            offerList = data
            viewableList = offerList
            util.loading = false
            if viewableList.count <= 0 {
                util.alertText = "No offers found"
                util.showAlert = true
                showHeader = true
            }
            else{
                showHeader = false
            }
        }
    }
    func setBERTParams(){
        if !util.saveBERT{return}
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        let sDate = formatter.date(from: UserDefaults.standard.string(forKey: "bertStart") ?? String(describing: Date())) ?? Date()
        let endDateToday = UserDefaults.standard.bool(forKey: "bertEndToday")
        
        let eDate = endDateToday ? Date() : formatter.date(from: UserDefaults.standard.string(forKey: "bertEnd") ?? String(describing: Date())) ?? Date()
        
        request.EURRate = UserDefaults.standard.string(forKey: "bertEUR") ?? ""
        request.USDRate = UserDefaults.standard.string(forKey: "bertUSD") ?? ""
        request.LandedCostPercent = UserDefaults.standard.string(forKey: "bertLand") ?? ""
        request.StartDate = sDate
        request.EndDate = eDate
        
    }

    func toggleHeader(){
        showHeader = !showHeader
    }
    
    func toggleSort(_ sort: (sType: SortType, dir: SortDir)){
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let temp = sort
        
        suppSort.dir = .None
        dateSort.dir = .None
        qtySort.dir = .None
        priceSort.dir = .None
        landSort.dir = .None
        
        
        var s = temp
        switch(s.dir){
        case .None:
            s.dir = .Desc
            break
        case .Desc:
            s.dir = .Asc
            break
        case.Asc:
            s.dir = .None
            break
        }
        
        if(s.dir == .None){
            viewableList = viewableList.sorted{a,b in
                return a.Id > b.Id
            }
            return
        }
        
        switch(s.sType){
        case .Date:
            dateSort.dir = s.dir
            viewableList = viewableList.sorted{a,b in
                let dateA = dateFormatter.date(from: a.offerDate) ?? Date()
                let dateB = dateFormatter.date(from: b.offerDate) ?? Date()
                return s.dir == .Asc ? dateA < dateB : dateA > dateB
            }
            break
        case .Landed:
            landSort.dir = s.dir
            viewableList = viewableList.sorted{a,b in
                return s.dir == .Asc ? a.landedCost < b.landedCost : a.landedCost > b.landedCost
            }
            break
        case .Price:
            priceSort.dir = s.dir
            viewableList = viewableList.sorted{a,b in
                return s.dir == .Asc ? a.price < b.price : a.price > b.price
            }
            break
        case .Qty:
            qtySort.dir = s.dir
            viewableList = viewableList.sorted{a,b in
                return s.dir == .Asc ? Int(a.qty.digits)! < Int(b.qty.digits)! : Int(a.qty.digits)! > Int(b.qty.digits)!
            }
            break
        case .Supplier:
            suppSort.dir = s.dir
            viewableList = viewableList.sorted{a,b in
                return s.dir == .Asc ? a.supplier < b.supplier : a.supplier > b.supplier
            }
            break
        }
        
    }
    
    func SortText(_ text: String, _ dir: SortDir) -> Text{
        switch(dir){
        case .None:
            return Text(text)
        case.Asc:
            return Text("\(text) ^")
        case.Desc:
            return Text("\(text) ⌄")
        }
    }
    
}

struct BERTTabView_Previews: PreviewProvider {
    static var previews: some View {
        BERTTabView(util: Util(), viewableList: BERTItem.sampleData)
    }
}
