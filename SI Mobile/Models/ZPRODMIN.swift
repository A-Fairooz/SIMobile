//
//  ZPRODMIN.swift
//  SGMobileiOS
//
//  Created by Abdulla Fairooz on 31/03/2022.
//

import Foundation

public struct ZPRODMIN: Codable, Hashable {
    var sku: String? = ""
    var description: String? = ""
    var upc: String? = ""
}

public extension ZPRODMIN {
    static var sampleList =
        [ZPRODMIN(sku: "10000001", description: "Calvin Klein whatever", upc: "0192012020101"),
         ZPRODMIN(sku: "10000002", description: "Joop whatever", upc: "0192012020101"),
         ZPRODMIN(sku: "10000003", description: "CD whatever", upc: "0192012020101"),
         ZPRODMIN(sku: "10000004", description: "Hugo Boss whatever", upc: "0192012020101"),
         ZPRODMIN(sku: "10000005", description: "Eau De Toilette whatever", upc: "0192012020101"),
         ZPRODMIN(sku: "10000006", description: "Eau De Parfum whatever", upc: "0192012020101"),
         ZPRODMIN(sku: "10000007", description: "Diesel BAD whatever", upc: "0192012020101")]
}
