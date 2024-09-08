//
//  PikachuApp.swift
//  Pikachu
//
//  Created by Bo Chiu on 2024/9/7.
//

import SwiftUI
import ComposableArchitecture

@main
struct PikachuApp: App {
    var body: some Scene {
        WindowGroup {
            PokemonDetailView(
                store: Store(initialState: PokemonDetailFeature.State(name: "pikachu"), reducer: {
                    PokemonDetailFeature()
                })
                
            )
        }
    }
}
