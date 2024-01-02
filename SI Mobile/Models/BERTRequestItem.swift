import Foundation

public struct BERTRequestItem {
    public var StartDate: Date = .init(timeIntervalSinceNow: -604_800) {didSet { SetDate(StartDate, "bertStart")}}
    public var EndDate: Date = Date() {didSet { SetDate(EndDate,"bertEnd")}}
    public var Supplier: String = "" {didSet { SetValue(Supplier,"bertSupp")}}
    public var SearchTerm: String = "" {didSet { SetValue(SearchTerm,"bertTerm")}}
    public var Barcode: String = "" {didSet { SetValue(Barcode,"bertBarcode")}}
    public var EURRate: String = "" {didSet { SetValue(EURRate,"bertEUR")}}
    public var USDRate: String = "" {didSet { SetValue(USDRate,"bertUSD")}}
    public var LandedCostPercent: String = "" {didSet { SetValue(LandedCostPercent,"bertLand")}}
    
    
    private func SetDate(_ value: Date, _ key: String){
        let save = UserDefaults.standard.bool(forKey: "saveBERT")
        if !save {return}
        if key == "bertStart" {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            let start = formatter.string(from: value)
            UserDefaults.standard.set(String(describing: start), forKey: key)
        }
        else if key == "bertEnd"{
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            let end = formatter.string(from: value)
            UserDefaults.standard.set(String(describing: end), forKey: key)
        }
    }
    private func SetValue(_ value: Any, _ key: String ){
        let save = UserDefaults.standard.bool(forKey: "saveBERT")
        if !save {return}
            UserDefaults.standard.set(String(describing: value), forKey: key)
    }
}

public extension BERTRequestItem {
    static var startingDate: Date = .init(timeIntervalSinceNow: -6_533_171)
    static var endingdate: Date = .init()
    static var sampleData:
        BERTRequestItem =
        .init(StartDate: startingDate, EndDate: endingdate, SearchTerm: "Burberry", Barcode: "3386463021781", EURRate: "0.1", USDRate: "0.2", LandedCostPercent: "5")
}
