//
//  APIClient.swift
//  Pikachu
//
//  Created by Bo Chiu on 2024/9/7.
//

import Foundation
import Alamofire
import ComposableArchitecture

struct APIClient {
    var fetchPokemon: (String) async throws -> Pokemon?
}

extension APIClient: DependencyKey {
    static let liveValue = Self { name in
        let url = "https://pokeapi.co/api/v2/pokemon/\(name)"
        let value = try await AF.request(url).serializingDecodable(Pokemon.self).value
        return value
    }
    
    static let testValue = Self { name in
        let url = "https://pokeapi.co/api/v2/pokemon/\(name)"
        let value = try await AF.request(url).serializingDecodable(Pokemon.self).value
        return value
    }
}

extension DependencyValues {
    var apiClient: APIClient {
        get { self[APIClient.self] }
        set { self[APIClient.self] = newValue }
    }
}
