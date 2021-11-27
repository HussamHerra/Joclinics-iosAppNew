import Foundation

protocol ClinicsManagerDelegate {
    func didGetClinics(clinics : [Clinics])
    func didFailWithError()
}
struct ClinicsManager {
    var delegate : ClinicsManagerDelegate?
    let ClinicsUrl = "\(baseURL)/api/Clinics"
    
    func getClinics (){
        let urlString = "\(ClinicsUrl)/getAllClinics"
        print(urlString)
        if let url = URL(string : urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error )in
                if error != nil{
                    print("from error")
                    self.delegate!.didFailWithError()
                    return
                }
                if let safeData = data{
                    do{
                        print(data!)
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode([Clinics].self, from: safeData)
                        self.delegate!.didGetClinics(clinics: decodedData)
                    }
                    catch let newError {
                        print("Error getClinics API  : " , newError)
                        self.delegate?.didFailWithError()
                    }
                }
            }
            task.resume()
        }
    }
    
    func getClinicFilter(classfic : String ,city : String , sort : String, num: Int , lat: Float , log: Float){
        let urlString = "\(ClinicsUrl)/GetClinics?classfic=\(classfic)&&city=\(city)&&sort=\(sort)&&num=\(num)&&lat=\(lat)&&log=\(log)"
        print(urlString)
        if let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!){
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
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode([Clinics].self, from: safeData)
                        self.delegate!.didGetClinics(clinics: decodedData)
                    }
                    catch let newError {
                        print("Error from getClinicFilter API  : " , newError)
                        self.delegate?.didFailWithError()
                    }
                }
            }
            task.resume()
        }
    }
    func searchForClinic(s: String , num : Int){
        let urlString = "\(ClinicsUrl)/Search?s=\(s)&&num=\(num)"
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
    func getDoctorByClinicId(id : Int){
        let urlString = "\(ClinicsUrl)/ReturnDoctorByClinicID?id=\(id)"
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
