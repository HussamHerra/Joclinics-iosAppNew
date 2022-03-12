
import Foundation

struct Appointment: Codable {
    let id: Int
    let clinicName, doctorName, specialization, date: String
    let caseDescription, hour, doctorGender: String
    let log, lat: Double
    let clinicNumber, clinicClassification: String

    enum CodingKeys: String, CodingKey {
        case id
        case clinicName = "Clinic_Name"
        case doctorName = "Doctor_Name"
        case specialization = "Specialization"
        case date = "Date"
        case caseDescription = "Case"
        case hour
        case doctorGender = "Doctor_gender"
        case log, lat
        case clinicNumber = "Clinic_Number"
        case clinicClassification = "Clinic_Classification"
    }
}
struct AppointmentData: Codable {
    let date, caseDescription, clinicID, patentID: String
    let doctorID, hour: String

    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case caseDescription = "CaseDescription"
        case clinicID = "Clinic_ID"
        case patentID = "Patent_ID"
        case doctorID = "Doctor_ID"
        case hour
    }
}
