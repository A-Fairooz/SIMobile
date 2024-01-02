
import Foundation



class API: ObservableObject {
    
    let timeout = UserDefaults.standard.integer(forKey: "requestTimeout") //?? 15
    let token = "ab182644-02df-42bc-b8b7-6c78f5246aa9"
    let bertUrl = "https://bert.scentglobal.com:8031"
    let apiUrl = "https://api.scentglobal.com"
    
    func fetchData(req: BERTRequestItem, completion: @escaping ([BERTItem]) -> Void) {
        let data = req
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        var url = "\(bertUrl)/api/BloodHound/?"
        url += "dStart=\(dateFormatter.string(from: data.StartDate))"
        url += "&dEnd=\(dateFormatter.string(from: data.EndDate))"
        url += "&searchTerm=\(data.SearchTerm)"
        url += "&barcode=\(data.Barcode.trimmingCharacters(in: .whitespaces))"
        url += "&supplier=\(data.Supplier)"
        url += "&exchangeRateEur=\(data.EURRate)"
        url += "&exchangeRateUsd=\(data.USDRate)"
        url += "&LandedCostPercentage=\(data.LandedCostPercent)"
        
        guard let url = URL(string: url) else { fatalError("Missing URL") }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if data != nil {
                let results = try? JSONDecoder().decode([BERTItem].self, from: data!)
                // print(results)
                DispatchQueue.main.async {
                    completion(results ?? [BERTItem]())
                }
            } else {
                print("No BERT Data")
                DispatchQueue.main.async {
                    completion([BERTItem]())
                }
            }
        }.resume()
    }
    
    func getStock(_ sku: String, completion: @escaping ([StockItem]) -> Void){
        var l = StockItem.sampleList
        var output = [StockItem]()
        for i in l{
            
        }
        
        DispatchQueue.main.async{
            completion(l)
        }
    }
    
    func getZProductByUPC(upc: String, completion: @escaping (ZPRODUCT) -> Void) {
        // let url = "https://api.scentglobal.com/api/products/?upc=\(upc)"
        let url = "\(apiUrl)/api/products/GetProductByUPC?upc=\(upc)"
        guard let url = URL(string: url) else { fatalError("Missing URL") }
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 15.0
        sessionConfig.timeoutIntervalForResource = 30.0
        let session = URLSession(configuration: sessionConfig)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: request) { data, _, _ in
            
            if data != nil {
                print("valid data")
                let results = try? JSONDecoder().decode(ZPRODUCT.self, from: data!)
                
                DispatchQueue.main.async {
                    completion(results ?? ZPRODUCT())
                }
            } else {
                print("invalid data")
                DispatchQueue.main.async {
                    completion(ZPRODUCT())
                }
            }
            
        }.resume()
    }
    
    func getBrands(completion: @escaping ([String]) -> Void) {
        do {
            let url = "\(apiUrl)/api/products/GetBrands"
            guard let url = URL(string: url) else { fatalError("Missing URL") }
            
            let sessionConfig = URLSessionConfiguration.default
            sessionConfig.timeoutIntervalForRequest = 15.0
            sessionConfig.timeoutIntervalForResource = 30.0
            let session = URLSession(configuration: sessionConfig)
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(token, forHTTPHeaderField: "Authorization")
            
            
            
            
            session.dataTask(with: request) { data, response, _ in
                
                if(response != nil){
                    let sc = (response as! HTTPURLResponse).statusCode
                    
                    if sc != 200 {}
                    
                    // print(response)
                    if data != nil {
                        // print("valid data")
                        var results = try? JSONDecoder().decode([String].self, from: data!)
                        if results != nil, !results!.isEmpty {
                            results = results!.filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
                        }
                        DispatchQueue.main.async {
                            completion(results!)
                        }
                    } else {
                        // print("invalid data")
                        DispatchQueue.main.async {
                            completion([String]())
                        }
                    }
                }
                else{
                    DispatchQueue.main.async {
                        completion([String]())
                    }
                }
                
            }.resume()
        }
    }
    
    func getBrandProds(brand: String, inStockOnly: Bool, completion: @escaping ([ZPRODMIN]) -> Void) {
        let fmtBrand = brand.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        
        let url = "\(apiUrl)/api/products/GetProductsByBrand?brand=" + fmtBrand!
        + (inStockOnly ? "&inStockOnly=true" : "")
        guard let url = URL(string: url) else { fatalError("Missing URL") }
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 15.0
        sessionConfig.timeoutIntervalForResource = 30.0
        let session = URLSession(configuration: sessionConfig)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: request) { data, response, _ in
            
            if data != nil {
                print("valid data")
                let results = try? JSONDecoder().decode([ZPRODMIN].self, from: data!)
                
                DispatchQueue.main.async {
                    completion(results ?? [ZPRODMIN]())
                }
            } else {
                print("invalid data")
                DispatchQueue.main.async {
                    completion([ZPRODMIN]())
                }
            }
            
        }.resume()
    }
    
    func getZProductBySKU(sku: String, completion: @escaping (ZPRODUCT) -> Void) {
        // let url = "https://api.scentglobal.com/api/products/?upc=\(upc)"
        let url = "\(apiUrl)/api/products/GetProductBySKU?sku=\(sku)"
        guard let url = URL(string: url) else { fatalError("Missing URL") }
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 15.0
        sessionConfig.timeoutIntervalForResource = 30.0
        let session = URLSession(configuration: sessionConfig)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: request) { data, _, _ in
            if data != nil {
                print("valid data")
                let results = try? JSONDecoder().decode(ZPRODUCT.self, from: data!)
                
                DispatchQueue.main.async {
                    completion(results ?? ZPRODUCT())
                }
            } else {
                print("invalid data")
                DispatchQueue.main.async {
                    completion(ZPRODUCT())
                }
            }
            
        }.resume()
    }
    
    func getSKUFromUPC(upc: String, completion: @escaping(String) -> Void){
        
        let url = "\(apiUrl)/api/products/GetSKUFromUPC?upc=\(upc)"
        guard let url = URL(string: url) else { fatalError("Missing URL") }
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 15.0
        sessionConfig.timeoutIntervalForResource = 30.0
        let session = URLSession(configuration: sessionConfig)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: request) { data, _, _ in
            if data != nil {
                print("valid data")
                let results = String(decoding:data!, as: UTF8.self)//try? JSONDecoder().decode(String.self, from: data!)
                print(results)
                DispatchQueue.main.async {
                    completion(results ?? "")
                }
            } else {
                print("invalid data")
                DispatchQueue.main.async {
                    completion("")
                }
            }
            
        }.resume()
    }
    
    
    func getUPCFromSKU(sku: String, completion: @escaping(String) -> Void){
        
        let url = "\(apiUrl)/api/products/GetBarcodeFromSKU?upc=\(sku)"
        guard let url = URL(string: url) else { fatalError("Missing URL") }
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 15.0
        sessionConfig.timeoutIntervalForResource = 30.0
        let session = URLSession(configuration: sessionConfig)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: request) { data, _, _ in
            if data != nil {
                print("valid data")
                let results = try? JSONDecoder().decode(String.self, from: data!)
                
                DispatchQueue.main.async {
                    completion(results ?? "")
                }
            } else {
                print("invalid data")
                DispatchQueue.main.async {
                    completion(String())
                }
            }
            
        }.resume()
    }
    
    func getExtendedProdData(productCode: String, completion: @escaping (X3Model) -> Void) {
        let url = "\(apiUrl)/api/products/productstock?code=\(productCode)"
        
        guard let url = URL(string: url) else { fatalError("Missing URL") }
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 15.0
        sessionConfig.timeoutIntervalForResource = 30.0
        let session = URLSession(configuration: sessionConfig)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: request) { data, _, _ in
            
            if data != nil {
                print("valid data")
                //print(String(data: data!, encoding: .utf8))
                let result = try? JSONDecoder().decode(X3Model.self, from: data!)
                
                DispatchQueue.main.async {
                    let x = X3Model(paramS1: PARAMS1(), headret: HEADRET(), listret: [LISTRET]())
                    completion(result ?? x)
                }
            } else {
                print("invalid data")
                let x = X3Model(paramS1: PARAMS1(), headret: HEADRET(), listret: [LISTRET]())
                DispatchQueue.main.async {
                    completion(x)
                }
            }
            
        }.resume()
    }
    
    func checkForUpdate(completion: @escaping (String) -> Void) {
        let nsObject: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject
        let localVersion = nsObject as! String
        var remoteVersion = ""
        //TODO Possibly change repository URL
        guard let url = URL(string: "https://a-fairooz.github.io/sgmobileios-page/manifest.plist") else { fatalError("Missing URL") }
        let seshConfig = URLSessionConfiguration.default
        seshConfig.timeoutIntervalForRequest = 30.0
        seshConfig.timeoutIntervalForResource = 30.0
        let session = URLSession(configuration: seshConfig)
        session.dataTask(with: url) { data, _, _ in
            if data != nil {
                let result = NSDictionary(contentsOf: url) as? [String: AnyObject]
                DispatchQueue.main.async {
                    let a1 = (result!["items"] as! [Any])[0]
                    let a2 = (a1 as! [String: AnyObject])["metadata"]
                    let a3 = (a2 as! [String: AnyObject])
                    remoteVersion = String(describing: a3["bundle-version"]!)
                    
                    if localVersion == remoteVersion {
                        completion("Up To Date")
                    } else {
                        completion("New Update available\nLocal Version: \(localVersion)\nRemote Version: \(remoteVersion)")
                    }
                }
            } else {
                completion("Error checking for update\nCheck connection or contact a member of IT")
            }
        }.resume()
    }
    
    func getPList(completion: @escaping (String) -> Void) {
        print("getting plist")
        //TODO Possibly change repository URL
        guard let url = URL(string: "https://a-fairooz.github.io/sgmobileios-page/manifest.plist") else { fatalError("Missing URL") }
        let seshConfig = URLSessionConfiguration.default
        seshConfig.timeoutIntervalForRequest = 30.0
        seshConfig.timeoutIntervalForResource = 30.0
        let session = URLSession(configuration: seshConfig)
        session.dataTask(with: url) { data, _, _ in
            if data != nil {
                let result = NSDictionary(contentsOf: url) as? [String: AnyObject]
                DispatchQueue.main.async {
                    let a1 = (result!["items"] as! [Any])[0]
                    let a2 = (a1 as! [String: AnyObject])["metadata"]
                    let a3 = (a2 as! [String: AnyObject])
                    let version = a3["bundle-version"]!
                    completion(String(describing: version))
                }
            } else {
                DispatchQueue.main.async {
                    completion("Error")
                }
            }
        }.resume()
    }
}


