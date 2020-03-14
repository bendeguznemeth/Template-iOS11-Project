//
//  StockViewModel.swift
//  Template-iOS11-Project
//
//  Created by Németh Bendegúz on 2020. 03. 14..
//  Copyright © 2020. Németh Bendegúz. All rights reserved.
//

import UIKit

struct StockViewModel {
    private let stock: Stock
    
    var id: String { // this is the symbol as well
        stock.symbol.uppercased()
    }
    
    var name: String {
        stock.name.capitalized
    }
    
    var price: String {
        String(format: "%.2f", stock.lastPrice ?? 0)
    }
    
    var change: String {
        ((stock.percentChange ?? 0).sign != .minus ? "+" : "") + String(format: "%.2f", (stock.lastPrice ?? 0 * ((stock.percentChange ?? 0) / 100)))
    }
    
    var percentChange: String {
        ((stock.percentChange ?? 0).sign != .minus ? "+" : "") + String(format: "%.2f", stock.percentChange ?? 0) + "%"
    }

    var color: UIColor {
        (stock.percentChange ?? 0).sign == .minus ? .red : .green
    }
    
    init(withStock stock: Stock) {
        self.stock = stock
    }
}
