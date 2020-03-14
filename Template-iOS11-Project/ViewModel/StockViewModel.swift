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
        String(format: "%.2f", stock.lastPrice)
    }
    
    var change: String {
        (stock.percentChange.sign != .minus ? "+" : "") + String(format: "%.2f", (stock.lastPrice * (stock.percentChange / 100)))
    }
    
    var percentChange: String {
        (stock.percentChange.sign != .minus ? "+" : "") + String(format: "%.2f", stock.percentChange) + "%"
    }

    var color: UIColor {
        stock.percentChange.sign == .minus ? .red : .green
    }
    
    init(withStock stock: Stock) {
        self.stock = stock
    }
}
