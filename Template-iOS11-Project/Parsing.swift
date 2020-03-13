//
//  Parsing.swift
//  Template-iOS11-Project
//
//  Created by Németh Bendegúz on 2020. 03. 13..
//  Copyright © 2020. Németh Bendegúz. All rights reserved.
//

import Foundation

func decode<T: Decodable>(_ data: Data) -> Result<T, AppError> {
    let decoder = JSONDecoder()

    guard let response = try? decoder.decode(T.self, from: data) else {
        return .failure(.parsing(description: "Could not decode data into \(T.self)"))
    }
    
    return .success(response)
}
