//
//  Bundle+Extensions.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 03.12.2023.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("DEBUG: There is not a file with name - \(file)")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("DEBUG: Error with get data from file \(file)")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("DEBUG: Error with decoding data of type \(type)")
        }
        
        return loaded
    }
}
