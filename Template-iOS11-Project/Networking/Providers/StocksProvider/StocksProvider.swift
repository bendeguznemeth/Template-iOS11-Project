//
//  StocksProvider.swift
//  Template-iOS11-Project
//
//  Created by Németh Bendegúz on 2020. 03. 13..
//  Copyright © 2020. Németh Bendegúz. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class StocksProvider: StocksProviding {
    
    let url = URL(string: "https://marketdata.websol.barchart.com/getQuote.json")!
    
    let APIKeyParam = ["apikey": "659099365cb31d72ee29e5b46e664945"]
    
    func fetchStocks(withSymbols symbols: [String], completion: @escaping (Result<SearchResult, AppError>) -> Void) {
        var params = APIKeyParam
        params["symbols"] = symbols.joined(separator: ",")
        
        AF.request(url, method: .get, parameters: params)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    completion(decode(data))
                case .failure(let error):
                    completion(.failure(.network(description: error.localizedDescription)))
                }
        }
    }
    
    func fetchStocks(withSymbols symbols: [String]) -> Observable<SearchResult> {
        return Observable.create { (observer) -> Disposable in
            var params = self.APIKeyParam
            params["symbols"] = symbols.joined(separator: ",")
            
            AF.request(self.url, method: .get, parameters: params)
                .validate()
                .responseData { (response) in
                    switch response.result {
                    case .success(let data):
                        let searchResult: Result<SearchResult, AppError> = decode(data)
                        
                        switch searchResult {
                        case .success(let searchResult):
                            observer.onNext(searchResult)
                        case .failure(let appError):
                            observer.onError(appError)
                        }
                    case .failure(let error):
                        observer.onError(AppError.network(description: error.localizedDescription))
                    }
            }
            
            return Disposables.create()
        }
    }
}
