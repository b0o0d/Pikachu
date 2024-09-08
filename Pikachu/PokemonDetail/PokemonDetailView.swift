//
//  PokemonDetailView.swift
//  Pikachu
//
//  Created by Bo Chiu on 2024/9/7.
//

import SwiftUI
import ComposableArchitecture
import SDWebImageSwiftUI

struct PokemonDetailView: View {
    let store: StoreOf<PokemonDetailFeature>
    
    var body: some View {
        VStack {
            WebImage(url: URL(string: store.state.pokemon?.sprite ?? ""))
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .overlay {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.lightLightGray, lineWidth: 4)
                }
                .padding(12)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Name: \(store.state.pokemon?.displayName ?? "")")
                    Text("Height: \(store.state.pokemon?.displayHeight ?? "")")
                    Text("Weight: \(store.state.pokemon?.displayWeight ?? "")")
                    Text("ID: \(store.state.pokemon?.displayID ?? "")")
                }
                .padding(.leading, -44)
                .padding(.top, 12)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(Color.lightLightGray)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                
                VStack(alignment: .leading) {
                    Text("Type")
                    ForEach(store.state.pokemon?.types ?? [], id: \.self) { type in
                        Text(type)
                            .frame(maxWidth: .infinity)
                            .background(Color.lightLightGray)
                            .clipShape(.capsule)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding()
            }
            .padding()
        }
        .task {
            store.send(.fetchPokemon)
        }
    }
}

#Preview {
    PokemonDetailView(
        store: Store(initialState: PokemonDetailFeature.State(name: "pikachu", pokemon: Pokemon.mock), reducer: {
            PokemonDetailFeature()
        })
    )
}

extension Color {
    static var lightLightGray: Color {
        Color(uiColor: UIColor(red: 223.0 / 255, green: 225.0 / 255, blue: 229.0 / 255, alpha: 1.0))
    }
}
