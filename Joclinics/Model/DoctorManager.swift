import Foundation

protocol DoctorManagerDelegate {
    func didFailWithError()
}

protocol NewsFeedManagerDelegate {
    func didFailWithError()
    func didReturnNewsFeed(newsFeeds : [NewsFeedData])
}

struct DoctorManager {
    var delegate : DoctorManagerDelegate?
    var newsFeedDelegate : NewsFeedManagerDelegate?
    let DoctorUrl = "\(baseURL)/api/Doctor"
    func getDoctorById(id : Int){
        let urlString = "\(DoctorUrl)/getDoctorByID?id=\(id)"
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
    
    
    func getDoctorByUserName(password : String,username : String){
        let urlString = "\(DoctorUrl)/getDoctorByUserName?password=\(password)&&username=\(username)"
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
    
    
    func getNewsFeed(num : Int){
        let urlString = "\(DoctorUrl)/NewsFeed?num=\(num)"
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {( data, response , error )in
                if error != nil {
                    print("from error")
                    self.newsFeedDelegate!.didFailWithError()
                    return
                }
                if let safeData = data{
                    do{
//                        let jsonResponse = try JSONSerialization.jsonObject(with: safeData, options: [])
//                        print(jsonResponse)
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode([NewsFeedData].self, from: safeData)
                        self.newsFeedDelegate!.didReturnNewsFeed(newsFeeds : decodedData)
                    }
                    catch let newError {
                        print("Error from get clinics API  : " , newError)
                        self.newsFeedDelegate?.didFailWithError()
                    }
                }
            }
            task.resume()
        }
    }
    
    func getNewsFeedByDoctorID(id : Int, num : Int){
        let urlString = "\(DoctorUrl)/getNewsFeedByDoctorID?id=\(id)&&num=\(num)"
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
    
    func AddNewsFeed(newsFeed : NewsFeed)
    {
        let parameters = newsFeed
        let urlString = "\(DoctorUrl)/AddNewsFeed"
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
    
    func returnHour(date : String , Doctor_id : Int , Clinic_ID : Int ,day : String){
        let urlString = "\(DoctorUrl)/returnHour?date=\(date)&&Doctor_id=\(Doctor_id)&&Clinic_ID=\(Clinic_ID)&&day=\(day)"
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
    
    func returnDoctorProfile(id : Int){
        let urlString = "\(DoctorUrl)/returnDoctorProfile?id=\(id)"
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
