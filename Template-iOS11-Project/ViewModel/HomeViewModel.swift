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
    let loading = PublishSubject<Bool>()
    
    private let stocks = BehaviorRelay<[StockViewModel]>(value: [])
    
    private let disposeBag = DisposeBag()
    private let stocksProvider: StocksProviding
    
    init(stocksProvider: StocksProviding = StocksProvider()) {
        self.stocksProvider = stocksProvider
    }
    
    func fetchStocks() {
        loading.onNext(true)
        stocksProvider
            .fetchStocks(withSymbols: ["TSLA", "MMM", "BEN", "MMP", "MSM", "TAP"])
            .subscribe(
                onNext: { [weak self] searchResult in
                    self?.loading.onNext(false)
                    
                    let stocks = searchResult.results
                    
                    self?.stocks.accept(stocks.map{StockViewModel(withStock: $0)})
                },
                onError: { [weak self] error in
                    self?.loading.onNext(false)
                    
                    self?.stocks.accept([])
                    
                    self?.error.onNext(error)
                }
        )
            .disposed(by: disposeBag)
    }
}
