//
//  StockTableViewCell.swift
//  Template-iOS11-Project
//
//  Created by Németh Bendegúz on 2020. 03. 14..
//  Copyright © 2020. Németh Bendegúz. All rights reserved.
//

import UIKit

class StockTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    var viewModel: StockViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    private func bindViewModel() {
        if let viewModel = viewModel {
            label.text = viewModel.id + "\n" +
                viewModel.name + "\n" +
                viewModel.price + "\n" +
                viewModel.change + "\n" +
                viewModel.percentChange
        }
    }
}
