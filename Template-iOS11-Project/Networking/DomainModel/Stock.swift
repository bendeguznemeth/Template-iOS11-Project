//
//  Stock.swift
//  Template-iOS11-Project
//
//  Created by Németh Bendegúz on 2020. 03. 13..
//  Copyright © 2020. Németh Bendegúz. All rights reserved.
//

import Foundation

struct Stock: Codable {
    let symbol: String
    let name: String
    let lastPrice: Double?
    let percentChange: Double?
}
