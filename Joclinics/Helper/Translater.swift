////
////  Translater.swift
////  Joclinics
////
////  Created by Hussam Abuherra on 27/11/2021.
////
//
//import Foundation
//
//
//struct Translater {
//    //    var text : [String : [String : String]] = ["" : ["":""]]
//    func getTranslateMessage () -> String{
//        var test =  Bundle.main.path(forResource: "Directions", ofType: "json")
//
//        if let filePath = Bundle.main.path(forResource: "Directions", ofType: "json") {
//                    let fileUrl = URL(fileURLWithPath: filePath)
//                    let data =  Data(contentsOf: fileUrl)
//                    //return data
//        }
//        return "hussam"
//    }
//}
//private func readLocalFile(forName name: String) -> Data? {
//    do {
//        if let bundlePath = Bundle.main.path(forResource: name,
//                                             ofType: "json"),
//           let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
//            return jsonData
//        }
//    } catch {
//        print(error)
//    }
//
//    return nil
//}
