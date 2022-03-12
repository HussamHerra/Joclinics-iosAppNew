
import Foundation

protocol AppointmentManagerDelegate {
    func didFailWithError()
    func didGetAppointment(appointment : [Appointment])
}

struct AppointmentManager {
    let appointmentURL = "\(baseURL)/api/Appointment/"
    
    var delegate :AppointmentManagerDelegate?
    
    func getPatentAppointment(id  :Int){
        let urlString = "\(appointmentURL)/getPatentAppointment?id=\(id)"
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {( data, response , error )in
                if error != nil {
                    print("from error")
                    self.delegate!.didFailWithError()
                    return
                }
                if let safeData = data{
                    do{
//                        let jsonResponse = try JSONSerialization.jsonObject(with: safeData, options: [])
//                        print(jsonResponse)
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode([Appointment].self, from: safeData)
                        self.delegate!.didGetAppointment(appointment : decodedData)
                    }
                    catch let newError {
                        print("Error from get clinics API  : " , newError)
                        self.delegate?.didFailWithError()
                    }
                }
            }
            task.resume()
        }
    }
    
    func getDoctorAppointment(id  :Int){
        let urlString = "\(appointmentURL)/getDoctorAppointment?id=\(id)"
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {( data, response , error )in
                if error != nil {
                    print("from error")
                    self.delegate!.didFailWithError()
                    return
                }
                if let safeData = data{
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: safeData, options: [])
                        print(jsonResponse)
                    }
                    catch let newError {
                        print("Error from get clinics API  : " , newError)
                        self.delegate?.didFailWithError()
                    }
                }
            }
            task.resume()
        }
    }
    func getDoctorAppointmentByDate(id  :Int , Date: String){
        let urlString = "\(appointmentURL)/getDoctorAppointmentByDate?id=\(id)&&Date=\(Date)"
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {( data, response , error )in
                if error != nil {
                    print("from error")
                    self.delegate!.didFailWithError()
                    return
                }
                if let safeData = data{
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: safeData, options: [])
                        print(jsonResponse)
                    }
                    catch let newError {
                        print("Error from get clinics API  : " , newError)
                        self.delegate?.didFailWithError()
                    }
                }
            }
            task.resume()
        }
    }
    func RemoveAppointment(id  :Int){
        let urlString = "\(appointmentURL)/RemoveAppointment?id=\(id)"
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {( data, response , error )in
                if error != nil {
                    print("from error")
                    self.delegate!.didFailWithError()
                    return
                }
                if let safeData = data{
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: safeData, options: [])
                        print(jsonResponse)
                    }
                    catch let newError {
                        print("Error from get clinics API  : " , newError)
                        self.delegate?.didFailWithError()
                    }
                }
            }
            task.resume()
        }
    }
    func AddNewAppointment(appointmentData : AppointmentData)
    {
        let parameters = appointmentData
        let urlString = "\(appointmentURL)/AddNewAppointment"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            var req = URLRequest(url: url)
            req.httpMethod = "POST"
            do {
                req.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
            req.addValue("application/json", forHTTPHeaderField: "Content-Type")
            req.addValue("application/json", forHTTPHeaderField: "Accept")
            let task = session.dataTask(with: req){
                (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError()
                    return
                }
            }
            task.resume()
        }
    }
    func Rating(DocRate : Int , ClinicRate : Int , AppointmentID : Int){
        let urlString = "\(appointmentURL)/Rating?DocRate=\(DocRate)&ClinicRate=\(ClinicRate)&AppointmentID=\(AppointmentID)"
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {( data, response , error )in
                if error != nil {
                    print("from error")
                    self.delegate!.didFailWithError()
                    return
                }
                if let safeData = data{
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: safeData, options: [])
                        print(jsonResponse)
                    }
                    catch let newError {
                        print("Error from get clinics API  : " , newError)
                        self.delegate?.didFailWithError()
                    }
                }
            }
            task.resume()
        }
    }
}
