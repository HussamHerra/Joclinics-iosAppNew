import Foundation

struct Doctor: Codable {
    let clinicName, name, address, phoneNumber: String
    let userName, password, specialization: String
    let rate: String?
    let id: Int
    let email, gender: String
    
    enum CodingKeys: String, CodingKey {
        case clinicName = "Clinic_Name"
        case name = "Name"
        case address = "Address"
        case phoneNumber = "PhoneNumber"
        case userName = "UserName"
        case password = "Password"
        case specialization = "Specialization"
        case rate = "Rate"
        case id = "ID"
        case email, gender
    }
}
