//

import Foundation

struct Country: Codable {
    let code: String
    let name: String
}

extension Country {
    var imageName: String {
        get { return code.lowercased() }
    }
}

func load<T: Decodable>(_ fileName: String, as type: T.Type = T.self) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: fileName, withExtension: nil) else {
        fatalError("Could not find the file called \(fileName)")
    }
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Could not read the contents of \(fileName) which threw \(error)")
    }
    
    let decoder = JSONDecoder()
    do {
        return try decoder.decode(type, from: data)
    } catch {
        fatalError("Could not decode the contents of \(fileName). The json must be malformed. Error: \(error)")
    }
}

let countriesData: [Country] = load("Data.json")
