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
    var stockCells: Observable<[StockViewModel]> {
        return stocks.asObservable()
    }
    
    let error = PublishSubject<Error>()
    
    let loading = BehaviorRelay(value: false)
    
    private let stocks = BehaviorRelay<[StockViewModel]>(value: [])
    
    private let disposeBag = DisposeBag()
    private let stocksProvider: StocksProviding
    
    private var symbols = ["TSLA", "MMM", "BEN", "MMP", "MSM", "TAP"]
    
    init(stocksProvider: StocksProviding = StocksProvider()) {
        self.stocksProvider = stocksProvider
    }
    
    func fetchStocks() {
        loading.accept(true)
        stocksProvider
            .fetchStocks(withSymbols: symbols)
            .subscribe(
                onNext: { [weak self] searchResult in
                    self?.loading.accept(false)
                    
                    let stocks = searchResult.results
                    
                    self?.stocks.accept(stocks.map{StockViewModel(withStock: $0)})
                },
                onError: { [weak self] error in
                    self?.loading.accept(false)
                    
                    self?.stocks.accept([])
                    
                    self?.error.onNext(error)
                }
        )
            .disposed(by: disposeBag)
    }
    
    func delete(at indexPath: IndexPath) {
        var stocks = self.stocks.value
        stocks.remove(at: indexPath.row)
        self.stocks.accept(stocks)
        symbols.remove(at: indexPath.row)
    }
}
