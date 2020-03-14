//
//  HomeViewController.swift
//  Template-iOS11-Project
//
//  Created by Németh Bendegúz on 2020. 03. 12..
//  Copyright © 2020. Németh Bendegúz. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    @IBOutlet weak var stocksTableView: UITableView!
    
    let viewModel = HomeViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        setupCellTapHandling()
        viewModel.fetchStocks()
    }
    
    private func bindViewModel() {
        viewModel
            .stockCells
            .bind(to: stocksTableView
                .rx
                .items(cellIdentifier: "StockTableViewCell",
                       cellType: StockTableViewCell.self)) { (row, stock, cell) in
                        cell.viewModel = stock
        }
        .disposed(by: disposeBag)
        
        viewModel
            .error
            .map { [weak self] in self?.presentError($0)}
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func setupCellTapHandling() {
        stocksTableView
            .rx
            .modelSelected(StockViewModel.self)
            .subscribe(onNext: { [weak self] stockViewModel in
                self?.performSegue(withIdentifier: "showStockDetail", sender: stockViewModel)
            })
            .disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showStockDetail" {
            let stockViewModel = sender as! StockViewModel
            let destinationViewController = segue.destination as! StockDetailViewController
            destinationViewController.viewModel = stockViewModel
        }
    }
}
