
import Foundation

public struct BERTItem: Decodable, Hashable {
    private var Barcode: String? = ""
    private var Supplier: String? = ""
    private var BatchId: String? = ""
    private var Brand: String? = ""
    private var Currency: String? = ""
    private var DateImported: String? = ""
    private var LandedCost: Float = 0.00
    private var OfferDate: String? = ""
    private var Price: String = "0.00"
    private var ProductDescription: String? = ""
    private var ProductType: String? = ""
    private var Qty: String = "0"
    private var RRP: String = "0.00"
    private var Size: String? = ""
    private var StockStatus: String? = ""
    public var id: Int? = 0
}

extension BERTItem: Identifiable {
    public var Id: Int { return id ?? 0 }
    public var supplier: String { return Supplier ?? "" }
    public var batchId: String { return BatchId ?? "" }
    public var brand: String { return Brand ?? "" }
    public var currency: String { return Currency ?? "" }
    public var dateImported: String { return DateImported ?? "" }
    public var landedCost: Float { return LandedCost }
    public var offerDate: String { return OfferDate ?? "" }
    public var price: Float { return Float(Price.isEmpty ? "0.00" : Price.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0.00 }
    public var productDescription: String { return ProductDescription ?? "" }
    public var productType: String { return ProductType ?? "" }
    public var qty: String { return Qty.isEmpty ? "0" : Qty }
    public var rrp: Float { return Float(RRP.isEmpty ? "0.00" : RRP)! }
    public var size: String { return Size ?? "" }
    public var stockStatus: String { return StockStatus ?? "" }
    public var barcode: String { return Barcode ?? "" }
    //public var currencySymbol: String { return gCS(code: Currency ?? "") }
    public var currencySymbol: String { return CurrencyStruct.currency(for:Currency ?? "")?.shortestSymbol ?? ""}
    public var fmtImportDate: String { return
        (DateImported ?? "")
            .replacingOccurrences(of: "T", with: " ")
            .replacingOccurrences(of: "00:00:00", with: "")
    }

    public var fmtOfferDate: String { return
        (OfferDate ?? "")
            .replacingOccurrences(of: "T", with: " ")
            .replacingOccurrences(of: "00:00:00", with: "")
    }
    // public var fmtOfferDate
}

extension BERTItem {
    static let sampleData: [BERTItem] =
        [BERTItem(Barcode: "000000", Supplier: "SUPPLIER", BatchId: "00000", Brand: "BRAND", Currency: "EUR", DateImported: "01/01/1900", LandedCost: 258.91, OfferDate: "01/01/1990", Price: "170.02", ProductDescription: "DESCRIPTION", ProductType: "TYPE", Qty: "9000+", RRP: "567.03", Size: "SIZE", StockStatus: "STATUS", id: 0)]
}

extension String {
    var digits: String {
        components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
}

func gCS(code: String) -> String {
    let localeIdentifier = "en_US"
    let locale = Locale(identifier: localeIdentifier)
    let currencyCode = code.uppercased()
    return locale.localizedString(forCurrencyCode: currencyCode) ?? "ERR"
}

public enum BertSortType {
    case Date
    case Quantity
    case Price
    case LandedCost
    case None
}

public enum SortMode {
    case Ascending
    case Descending
    case None
}


struct CurrencyStruct {
   
   /// Returns the currency code. For example USD or EUD
   let code: String
   
   /// Returns currency symbols. For example ["USD", "US$", "$"] for USD, ["RUB", "₽"] for RUB or ["₴", "UAH"] for UAH
   let symbols: [String]
   
   /// Returns shortest currency symbols. For example "$" for USD or "₽" for RUB
   var shortestSymbol: String {
      return symbols.min { $0.count < $1.count } ?? ""
   }
   
   /// Returns information about a currency by its code.
   static func currency(for code: String) -> CurrencyStruct? {
      return cache[code]
   }
   
   // Global constants and variables are always computed lazily, in a similar manner to Lazy Stored Properties.
   static fileprivate var cache: [String: CurrencyStruct] = { () -> [String: CurrencyStruct] in
      var mapCurrencyCode2Symbols: [String: Set<String>] = [:]
      let currencyCodes = Set(Locale.commonISOCurrencyCodes)
      
      for localeId in Locale.availableIdentifiers {
         let locale = Locale(identifier: localeId)
         guard let currencyCode = locale.currencyCode, let currencySymbol = locale.currencySymbol else {
            continue
         }
         if currencyCode.contains(currencyCode) {
            mapCurrencyCode2Symbols[currencyCode, default: []].insert(currencySymbol)
         }
      }
      
      var mapCurrencyCode2Currency: [String: CurrencyStruct] = [:]
      for (code, symbols) in mapCurrencyCode2Symbols {
         mapCurrencyCode2Currency[code] = CurrencyStruct(code: code, symbols: Array(symbols))
      }
      return mapCurrencyCode2Currency
   }()
}
