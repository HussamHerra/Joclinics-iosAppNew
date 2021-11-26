import Foundation

protocol PatentManagerDelegate {
    func didUpdatePatent(_ patentManager: PatentManager, patent: Patent)
    func didAddedPatent(_ patentManager: PatentManager)
    func didFailWithError()
    func theEmailAndUserNameValid(_ patentManager: PatentManager)
    func doneSendEmail (_ patentManager: PatentManager)
}
struct PatentManager{
    let patentURL = "https://rhsmartsolution.com/JoclinicsAPI/api/patent"
    
    var delegate : PatentManagerDelegate?
    
    func LoginPatent(password: String, userName: String) {
        let urlString = "\(patentURL)/getPatentByUserName?password=\(password)&username=\(userName)"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError()
                    return
                }
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(Patent.self, from: safeData)
                        self.delegate?.didUpdatePatent(self, patent: decodedData)
                        
                    } catch {
                        delegate?.didFailWithError()
                    }
                }
            }
            task.resume()
        }
    }
    
    func SendCodeToEmail (Email : String , Code : Int){
        let urlString = "\(patentURL)/SendEmail?code=\(Code)&Email=\(Email)"
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){ (data, response , error) in
                if error != nil {
                    self.delegate?.didFailWithError()
                    return
                }
                if let dataResponse = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                        print(jsonResponse)
                        self.delegate?.doneSendEmail(self)
                    }
                    catch let parsingError {
                        print("Error from send email : " , parsingError)
                        self.delegate?.didFailWithError()
                    }
                }
            }
            task.resume()
        }
    }
    
    func CheckIfUserNameOrEmailIsInDatabase(Email : String,UserName : String,code : Int){
        print("from check user name")
        let urlString = "\(patentURL)/CheckIfUserNameOrEmailIsInDatabase?UserName=\(UserName)&Email=\(Email)&code=\(code)"
        print(urlString)
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError()
                    return
                }
                if let dataResponse = data {
                    do{
                        print("data response is : " , dataResponse)
                        let jsonResponse = try JSONSerialization.jsonObject(
                            with:
                                dataResponse, options: [])
                        print(jsonResponse)
                        self.delegate?.theEmailAndUserNameValid(self)
                    } catch let parsingError {
                        print("Error", parsingError)
                        self.delegate?.didFailWithError()
                    }
                }
            }
            
            task.resume()
        }
    }
    func SignUpPatent(FirstName: String,LastName : String,UserName : String,Password : String,ChronicDiseases : String,Email : String,Gender : String,PhoneNumber : String,DateOfBirth : String,address : String)
    {
        let parameters =
        ["FirstName": FirstName,
         "LastName": LastName,
         "UserName":UserName,
         "Password":Password,
         "ChronicDiseases":ChronicDiseases,
         "Email":Email,
         "Gender":Gender,
         "PhoneNumber":PhoneNumber,
         "DateOfBirth":DateOfBirth,
         "address":address
        ]
        as [String : Any]
        let urlString = "\(patentURL)/addNewPatent"
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
                self.delegate?.didAddedPatent(self)
            }
            task.resume()
        }
    }
    func ChangePassword (NewPassword : String , Email : String) {
        let urlString = "\(patentURL)/ChangePassword?Email=\(Email)&newpassword=\(NewPassword)"
        print(urlString)
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError()
                    return
                }
                if let safeData = data {
                    do{
                        print("safe data is : \(safeData)")
                        let jsonResponse = try JSONSerialization.jsonObject(with: safeData, options: [])
                        print(jsonResponse)
                        self.delegate?.doneSendEmail(self)
                    }
                    catch let newError {
                        print("Error from changePassword API  : " , newError)
                        self.delegate?.didFailWithError()
                    }
                }
            }
            task.resume()
        }
    }
}
