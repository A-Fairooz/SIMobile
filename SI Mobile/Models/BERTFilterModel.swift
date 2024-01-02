//
//  BERTFilterModel.swift
//  SGTESTING01
//
//  Created by Abdulla Fairooz on 17/08/2023.
//

import Foundation
import SwiftUI

public class BERTFilterModel: ObservableObject{
     
    @Published public var filtered: Bool = false
    
    @Published public var suppliers = [String]()
    @Published public var supplier: String? = nil
    
    @Published public var statuses = [String]()
    @Published public var status: String? = nil
    
    @Published public var minQty: Float = 0
    @Published public var maxQty: Float = 100
    @Published public var qtyRange: ClosedRange<Float> = 1...100
    @Published public var qtyEnabled = false
    
    @Published public var minPrice: Float = 0
    @Published public var maxPrice: Float = 100
    @Published public var priceRange:ClosedRange<Float> = 1...100
    @Published public var priceEnabled = false
//
//    init(filtered: Bool, suppliers: [String] = [String](), supplier: String? = nil, statuses: [String] = [String](), status: String? = nil, minQty: Float, maxQty: Float, qtyRange: ClosedRange<Float>, qtyEnabled: Bool = false, minPrice: Float, maxPrice: Float, priceRange: ClosedRange<Float>, priceEnabled: Bool = false) {
//        self.filtered = filtered
//        self.suppliers = suppliers
//        self.supplier = supplier
//        self.statuses = statuses
//        self.status = status
//        self.minQty = minQty
//        self.maxQty = maxQty
//        self.qtyRange = qtyRange
//        self.qtyEnabled = qtyEnabled
//        self.minPrice = minPrice
//        self.maxPrice = maxPrice
//        self.priceRange = priceRange
//        self.priceEnabled = priceEnabled
//    }
//
}
