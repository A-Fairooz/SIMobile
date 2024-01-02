//
//  X3Model.swift
//  SGMobileiOS
//
//  Created by Abdulla Fairooz on 23/02/2022.
//

import Foundation

struct X3Model: Decodable, Hashable {
    public var paramS1: PARAMS1 = .init()
    public var headret: HEADRET = .init()
    public var listret: [LISTRET] = .init()
}

extension X3Model: Identifiable {
    public var id: Int { return 0 }
    public var P1: PARAMS1 { return paramS1 }
    public var HEAD: HEADRET { return headret }
    public var LIST: [LISTRET] { return listret }
}

struct PARAMS1: Decodable, Hashable {
    public var zstofcy: String = ""
    public var zitmref: String = ""
}

struct HEADRET: Decodable, Hashable {
    public var zgloall: Int = 0
}

struct LISTRET: Decodable, Hashable {
    public var zstoflD1: String = ""
    public var zsta: String = ""
    public var zqtystu: Int = 0
    public var zcumallqty: Int = 0
    public var zfreeqty: Int = 0
    public var zvpri: Float = 0.00
    public var zwpri: Float = 0.00
}

extension LISTRET: Identifiable {
    public var id: UUID { return UUID() }

    public var zSTOFLD1: String { return zstoflD1 }
    public var zSTA: String { return zsta }
    public var zQTYSTU: Int { return zqtystu }
    public var zCUMALLQTY: Int { return zcumallqty }
    public var zFREEQTY: Int { return zfreeqty }
    public var zVPRI: Float { return zvpri }
    public var zWPRI: Float { return zwpri }
}
