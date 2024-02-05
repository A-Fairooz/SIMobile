
import Foundation
import SwiftUI

public class Util: ObservableObject{
    @Published public var loading = false
    @Published public var bertUPC = ""
    @Published public var bertSearch = false
    @Published public var showAlert = false
    @Published public var alertText = ""
    @Published public var viewIndex = 2
    
    
    @Published var inStockOnly = false
    @Published var bertEndToday = true
    @Published var saveBERT = true
    @Published var cMode = false
  
    
    init(loading: Bool = false, bertUPC: String = "", bertSearch: Bool = false, showAlert: Bool = false, alertText: String = "", viewIndex: Int = 2) {
        self.loading = loading
        self.bertUPC = bertUPC
        self.bertSearch = bertSearch
        self.showAlert = showAlert
        self.alertText = alertText
        self.viewIndex = viewIndex
        
        self.inStockOnly = GetBoolVal("inStockOnly")
        self.bertEndToday = GetBoolVal("bertEndToday")
        self.saveBERT = GetBoolVal("saveBERT")
        self.cMode = GetBoolVal("cMode")
    
    }
    

    
    func GetBoolVal(_ key: String) -> Bool{
        let v = UserDefaults.standard.bool(forKey: key)
        return v
    }
    
}


