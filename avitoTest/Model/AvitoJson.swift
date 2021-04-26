

import Foundation

struct AvitoJson: Codable {
    var status: String
    var result: Results
}

struct Results: Codable {
    var title, actionTitle, selectedActionTitle: String
    var list: [List]
}

struct List: Codable {
    var id, title: String
    var listDescription: String?
    var icon: Icon
    var price: String
    var isSelected: Bool

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case listDescription = "description"
        case icon = "icon"
        case price = "price"
        case isSelected = "isSelected"
        
    }
}

struct Icon: Codable {
    var icon: String
    
    enum CodingKeys: String, CodingKey {
        case icon = "52x52"
    }
}
