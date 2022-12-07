//
//  MFJSONParser.swift
//  MovieFlix
//
//  Created by Pranay Jadhav  on 07/12/22.
//

import Foundation

enum MFJSONType: String {
    case movies = "movies"
    case staffPick = "staff_pick"
}

class MFJSONParser {
    
    static let shared  = MFJSONParser()
    
    private init () {}
    
    /// Generate json data from json files
    func generateJSONData<T:Decodable>(_ forResource: MFJSONType,
                                       _ type: T.Type,
                                       completionHandler: (T) -> Void) {
        
        if let url = Bundle.main.url(forResource: forResource.rawValue, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let responseModels = try JSONDecoder().decode(T.self, from: data)
                completionHandler(responseModels)
            } catch {
                print("error:\(error)")
            }
        }
    }
}
