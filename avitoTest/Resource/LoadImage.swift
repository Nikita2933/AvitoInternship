

import Foundation

class LoadImage {
    
    enum UrlError: Error {
        case invalidUrl(msg: String)
        case networkError(msg: String?)
        case jsonError
    }
    
    class func loadImage(imgString: String, result: @escaping (Result<Data, UrlError>)->()) {
        
        guard let url = URL(string: imgString) else {
            result(.failure(.invalidUrl(msg: "Invalid Url: \(imgString)")))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                result(.failure(.networkError(msg: error?.localizedDescription)))
                return
            }
            
            if let statusCode = (response as? HTTPURLResponse)?.statusCode, !(200..<299).contains(statusCode) {
                result(.failure(.networkError(msg: "HTTP ERROR \(statusCode)")))
            }
            
            if let data = data {
                result(.success(data))
            }
        }.resume()
    }
}


