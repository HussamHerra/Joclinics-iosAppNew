import Foundation

struct Clinics : Codable{
    let name, phoneNumber, location: String
    let rate: Float
    let classification: String
    let log, lat: Double
    let distance: String?
    let id, cost: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case phoneNumber = "PhoneNumber"
        case location = "Location"
        case rate = "Rate"
        case classification = "Classification"
        case log, lat, distance
        case id = "ID"
        case cost
    }
    
}
