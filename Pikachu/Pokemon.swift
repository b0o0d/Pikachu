//
//  Pokemon.swift
//  Pikachu
//
//  Created by Bo Chiu on 2024/9/7.
//

import Foundation

struct Pokemon: Decodable, Equatable {
    var id: Int
    var name: String
    var height: Int
    var weight: Int
    var types: [String]
    var sprite: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case height
        case weight
        case types
        case sprites
        
        enum TypesCodingKeys: String, CodingKey {
            case type
            
            enum TypeCodingKeys: String, CodingKey {
                case name
            }
        }
        
        enum SpritesCodingKeys: String, CodingKey {
            case other
            
            enum OtherCodingKeys: String, CodingKey {
                case home
                
                enum HomeCodingKeys: String, CodingKey {
                    case frontDefault = "front_default"
                }
            }
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        height = try container.decode(Int.self, forKey: .height)
        weight = try container.decode(Int.self, forKey: .weight)
        
        var typesContainer = try container.nestedUnkeyedContainer(forKey: .types)
        var types: [String] = []
        while !typesContainer.isAtEnd {
            let typeContainer = try typesContainer.nestedContainer(keyedBy: CodingKeys.TypesCodingKeys.self)
            let nameContainer = try typeContainer.nestedContainer(keyedBy: CodingKeys.TypesCodingKeys.TypeCodingKeys.self, forKey: .type)
            let type = try nameContainer.decode(String.self, forKey: .name)
            types.append(type)
        }
        self.types = types
        
        let spritesContainer = try container.nestedContainer(keyedBy: CodingKeys.SpritesCodingKeys.self, forKey: .sprites)
        let otherContainer = try spritesContainer.nestedContainer(keyedBy: CodingKeys.SpritesCodingKeys.OtherCodingKeys.self, forKey: .other)
        let homeContainer = try otherContainer.nestedContainer(keyedBy: CodingKeys.SpritesCodingKeys.OtherCodingKeys.HomeCodingKeys.self, forKey: .home)
        sprite = try homeContainer.decode(String.self, forKey: .frontDefault)
    }
    
    init(id: Int, name: String, height: Int, weight: Int, types: [String], sprite: String) {
        self.id = id
        self.name = name
        self.height = height
        self.weight = weight
        self.types = types
        self.sprite = sprite
    }

}

extension Pokemon {
    static let mock = Pokemon(id: 25, name: "pikachu", height: 4, weight: 60, types: ["electric"], sprite: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/25.png")
}

