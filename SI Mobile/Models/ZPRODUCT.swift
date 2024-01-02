//
//  ZPRODUCT.swift
//  SGMobileiOS
//
//  Created by Abdulla Fairooz on 24/03/2022.
//

import Foundation

public struct ZPRODUCT: Codable, Hashable {
    var sku: String? = ""
    var description: String? = ""
    var category: String? = ""
    var pType: String? = ""
    var subcat: String? = ""
    var variant: String? = ""
    var edition: String? = ""
    var color: String? = ""
    var brand: String? = ""
    var range: String? = ""
    var gender: String? = ""
    var size: String? = ""
    var upc: String? = ""
    var stock: Int? = 0
    var volPrice: Float? = 0.00
    var rrp: Float? = 0.00
    var costPrice: Float? = 0.00
}

public extension ZPRODUCT {
    static var sample = ZPRODUCT(sku: "10000001", description: "Desc", category: "Cat", pType: "Ptype", subcat: "Subcat", variant: "Variant", edition: "Edit", color: "Col", brand: "Brand", range: "Range", gender: "Gender", size: "Size", upc: "UPC-000101021", stock: 1, volPrice: 1.00, rrp: 2.00, costPrice: 1.12)
}
