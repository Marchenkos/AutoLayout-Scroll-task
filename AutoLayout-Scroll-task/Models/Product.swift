import Foundation

struct Product: Codable {
    let name: String
    let image: String
    let description: String
    let price: Int
    
    static func getData() -> [Product] {
        var products: [Product] = []
        let url = Bundle.main.url(forResource: "products", withExtension: "json")!

        do {
          let data = try Data(contentsOf: url)
          let json = try JSONDecoder().decode(Products.self, from: data)
            products = json.products
        } catch {
          print("Error occured during Parsing", error)
        }

        return products
    }
}
