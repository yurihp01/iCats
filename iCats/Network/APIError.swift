//
//  APIError.swift
//  iCats
//
//  Created by Yuri on 12/06/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import Foundation

enum APIError: Error {
    case badURL
    case badResponse
    case invalidStatusCode(statusCode: Int)
    case invalidData
    case invalidJson
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badResponse:
            return "Response Inválido"
        case .badURL:
            return "URL inválida!"
        case .invalidData:
            return "Dados inválidos"
        case .invalidJson:
            return "Erro na decodificação do JSON"
        case .invalidStatusCode(let statusCode):
            return "O status code retornado é \(statusCode)! "
        }
    }
}
