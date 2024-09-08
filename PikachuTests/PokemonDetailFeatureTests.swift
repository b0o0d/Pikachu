//
//  PokemonDetailFeatureTests.swift
//  PikachuTests
//
//  Created by Bo Chiu on 2024/9/8.
//

import XCTest
import ComposableArchitecture

@testable import Pikachu

final class PokemonDetailFeatureTests: XCTestCase {

    func testFetchPokemon() async {
        let store = await TestStore(initialState: PokemonDetailFeature.State(name: "pikachu")) {
            PokemonDetailFeature()
        }
        
        await store.send(.fetchPokemon)
        await store.receive(\.pokemonResponse) {
            $0.pokemon = Pokemon.mock
        }
    }

}
