//
//  AppError.swift
//  Template-iOS11-Project
//
//  Created by Németh Bendegúz on 2020. 03. 13..
//  Copyright © 2020. Németh Bendegúz. All rights reserved.
//

import Foundation

enum AppError: Error {
    case parsing(description: String)
    case network(description: String)
    case selfNotExists
}
