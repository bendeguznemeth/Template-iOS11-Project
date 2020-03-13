//
//  StocksProvider.swift
//  Template-iOS11-Project
//
//  Created by Németh Bendegúz on 2020. 03. 13..
//  Copyright © 2020. Németh Bendegúz. All rights reserved.
//

import Foundation
import Alamofire

class StocksProvider: StocksProviding {
    
    let url = URL(string: "https://marketdata.websol.barchart.com/getQuote.json")!
    
    let APIKeyParam = ["apikey": "659099365cb31d72ee29e5b46e664945"]
    
    func fetchStocks(withSymbols symbols: [String], completion: @escaping (Result<SearchResult, AppError>) -> Void) {
        var params = APIKeyParam
        params["symbols"] = symbols.joined(separator: ",")
        
        AF.request(url, method: .get, parameters: params)
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    completion(decode(data))
                case .failure(let error):
                    completion(.failure(.network(description: error.localizedDescription)))
                }
        }
    }
}
