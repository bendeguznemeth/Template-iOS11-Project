//
//  StockDetailViewController.swift
//  Template-iOS11-Project
//
//  Created by Németh Bendegúz on 2020. 03. 14..
//  Copyright © 2020. Németh Bendegúz. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var viewModel: StockViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        title = viewModel.name
        
        label.text = viewModel.id + "\n" +
        viewModel.name + "\n" +
        viewModel.price + "\n" +
        viewModel.change + "\n" +
        viewModel.percentChange
    }
}
