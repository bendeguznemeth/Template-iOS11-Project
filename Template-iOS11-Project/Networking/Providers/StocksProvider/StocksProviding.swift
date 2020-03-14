//
//  StocksProviding.swift
//  Template-iOS11-Project
//
//  Created by Németh Bendegúz on 2020. 03. 13..
//  Copyright © 2020. Németh Bendegúz. All rights reserved.
//

import Foundation
import RxSwift

protocol StocksProviding {
    func fetchStocks(withSymbols symbols: [String], completion: @escaping (Result<SearchResult, AppError>) -> Void)
    func fetchStocks(withSymbols symbols: [String]) -> Observable<SearchResult>
}
