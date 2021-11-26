//
//  ClinicsManager.swift
//  Joclinics
//
//  Created by Hussam Abuherra on 26/11/2021.
//

import Foundation

protocol ClinicsManagerDelegate {
    func didGetClinics(clinics : [Clinics])
    func didFailWithError()
}



struct ClinicsManager {
    
    var delegate : ClinicsManagerDelegate?
    
    let ClinicsUrl = "https://rhsmartsolution.com/JoclinicsAPI/api/Clinics"
    
    func getClinics (){
        let urlString = "\(ClinicsUrl)/getAllClinics"
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
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode([Clinics].self, from: safeData)
                        self.delegate!.didGetClinics(clinics: decodedData)
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
