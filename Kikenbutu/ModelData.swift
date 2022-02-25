//
//  ModelData.swift
//  Kikenbutu
//
//  Created by dev on 2022/02/24.
//

import Foundation

class ResultModel: ObservableObject {
    @Published var result: [[Bool]] = [
        [false,false,false,false,false,false,false,false,false,false],
        [false,false,false,false,false],
        [false,false,false,false,false,false,false,false,false,false]
    ]
}

var qDatas: [QuestSection] = load("heisyu_01.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
}
