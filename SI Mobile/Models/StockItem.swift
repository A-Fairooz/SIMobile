//
//  StockItem.swift
//  SI Mobile
//
//  Created by Abdulla Fairooz on 29/12/2023.
//

import Foundation


struct StockItem: Hashable{
    public var Site: String
    public var SKU: String
    public var Grade: String
    public var Status: String
    public var Lot: String
    public var Location: String
    public var LocationType: String
    public var Quantity: Int
    public var AllocatedQty: Int
}


extension StockItem{
    static let sample1 = StockItem(Site: "DTGL1", SKU: "10000001", Grade: "10", Status: "A", Lot: "1", Location: "SHOW RED", LocationType: "SHOWR", Quantity: 10, AllocatedQty: 0)
    static let sample2 = StockItem(Site: "DTGL1", SKU: "10000001", Grade: "10", Status: "Q", Lot: "1",Location: "SHOW RED", LocationType: "SHOWR", Quantity: 10, AllocatedQty: 0)
    static let sample3 = StockItem(Site: "DTGL1", SKU: "10000001", Grade: "10", Status: "A", Lot: "1",Location: "Y10", LocationType: "SHOWR", Quantity: 10, AllocatedQty: 0)
    static let sample4 = StockItem(Site: "DTGL1", SKU: "10000001", Grade: "20", Status: "A", Lot: "1",Location: "Y10", LocationType: "SHOWR", Quantity: 10, AllocatedQty: 0)
    static let sample5 = StockItem(Site: "DTGL1", SKU: "10000001", Grade: "10", Status: "A", Lot: "1",Location: "F6", LocationType: "SHOWR", Quantity: 10, AllocatedQty: 0)
    static let sample6 = StockItem(Site: "DTGL1", SKU: "10000001", Grade: "10", Status: "A", Lot: "5",Location: "F6", LocationType: "SHOWR", Quantity: 10, AllocatedQty: 0)
    
    static let sampleList = [sample1, sample2, sample3, sample4, sample5, sample6]
}
