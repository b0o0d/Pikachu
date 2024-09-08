//
//  PokemonDetailFeature.swift
//  Pikachu
//
//  Created by Bo Chiu on 2024/9/7.
//

import Foundation
import ComposableArchitecture

@Reducer
struct PokemonDetailFeature {
    @ObservableState
    struct State: Equatable {
        let name: String
        var pokemon: Pokemon?
    }
    
    enum Action {
        case fetchPokemon
        case pokemonResponse(Pokemon?)
    }
    
    @Dependency(\.apiClient) var apiClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchPokemon:
                return .run { [name = state.name] send in
                    try await send(.pokemonResponse(self.apiClient.fetchPokemon(name)))
                }
            case let .pokemonResponse(pokemon):
                state.pokemon = pokemon
                return .none
            }
        }
    }
}
