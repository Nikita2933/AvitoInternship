

import Foundation

class JsonController {
    enum fileError: Error {
        case error(stringError: String)
    }
    
    class func loadFile(result: @escaping (Result<Data, fileError>) -> () ){
        if let url = Bundle.main.url(forResource: "result", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                result(.success(data))
            } catch  {
                result(.failure(.error(stringError: String(error.localizedDescription))))
                print(error)
            }
        }
    }
    
    class func jsonParse(data: Data) -> AvitoJson? {
        do {
            let avitoJson = try JSONDecoder().decode(AvitoJson.self, from: data)
            if avitoJson.status == "ok" {
                return avitoJson
            }
        } catch  {
            print(error.localizedDescription, error)
        }
        return nil
    }
}

