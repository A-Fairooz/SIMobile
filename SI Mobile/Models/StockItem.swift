//
//  StockItem.swift
//  SI Mobile
//
//  Created by Abdulla Fairooz on 29/12/2023.
//

import Foundation
//
//struct StockItem: Hashable, Codable{
//    private var site: String? = ""
//    private var sku: String? = ""
//    public var grade: String? = ""
//    public var status: String? = ""
//    public var lot: String? = ""
//    public var location: String? = ""
//    public var locationType: String? = ""
//    public var quantity: Int? = 0
//    public var allocatedQuantity: Int? = 0
//    public var freeQuantity: Int? = 0
//}


struct StockItem: Hashable, Codable{
    public var site: String
    public var sku: String
    public var grade: String
    public var status: String
    public var lot: String
    public var location: String
    public var locationType: String
    public var quantity: Int
    public var allocatedQuantity: Int
    public var freeQuantity: Int
}
    //Group by lot option


extension StockItem{
    static let sample1 = StockItem(site: "DTGL1", sku: "10000001", grade: "10", status: "A", lot: "1", location: "SHOW RED", locationType: "SHOWR", quantity: 10, allocatedQuantity: 0, freeQuantity: 10)
//    static let sample2 = StockItem(Site: "DTGL1", SKU: "10000001", Grade: "10", Status: "Q", Lot: "1",Location: "SHOW RED", LocationType: "SHOWR", Quantity: 10, AllocatedQuantity: 0)
//    static let sample3 = StockItem(Site: "DTGL1", SKU: "10000001", Grade: "10", Status: "A", Lot: "1",Location: "Y10", LocationType: "SHOWR", Quantity: 10, AllocatedQuantity: 0)
//    static let sample4 = StockItem(Site: "DTGL1", SKU: "10000001", Grade: "20", Status: "A", Lot: "1",Location: "Y10", LocationType: "SHOWR", Quantity: 10, AllocatedQuantity: 0)
//    static let sample5 = StockItem(Site: "DTGL1", SKU: "10000001", Grade: "10", Status: "A", Lot: "1",Location: "F6", LocationType: "SHOWR", Quantity: 10, AllocatedQuantity: 0)
//    static let sample6 = StockItem(Site: "DTGL1", SKU: "10000001", Grade: "10", Status: "A", Lot: "5",Location: "F6", LocationType: "SHOWR", Quantity: 10, AllocatedQuantity: 0)
    
    static let sampleList = [sample1, sample1, sample1, sample1, sample1, sample1]
}
