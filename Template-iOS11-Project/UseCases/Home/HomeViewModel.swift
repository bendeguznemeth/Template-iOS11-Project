//
//  HomeViewModel.swift
//  Template-iOS11-Project
//
//  Created by Németh Bendegúz on 2020. 03. 13..
//  Copyright © 2020. Németh Bendegúz. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    var observableStocks: Observable<[Stock]> {
        return stocks.asObservable()
    }
    
    private let stocks = BehaviorRelay<[Stock]>(value: [])
    
    private let disposeBag = DisposeBag()
    private let stocksProvider: StocksProviding
    
    init(stocksProvider: StocksProviding = StocksProvider()) {
        self.stocksProvider = stocksProvider
        fetchStocks()
    }
    
    func fetchStocks() {
        stocksProvider
            .fetchStocks(withSymbols: ["TSLA", "MMM", "BEN", "MMP", "MSM", "TAP"])
            .subscribe(
                onNext: { [weak self] searchResult in
                    let stocks = searchResult.results
                    
                    guard stocks.count > 0 else {
                        self?.stocks.accept([])
                        return
                    }
                    
                    self?.stocks.accept(stocks)
                },
                onError: { [weak self] error in
                    self?.stocks.accept([])
                    
                    print(error)
                }
        )
            .disposed(by: disposeBag)
    }
}
