//
//  NewsFeed.swift
//  Joclinics
//
//  Created by Hussam Abuherra on 26/11/2021.
//

import Foundation

struct NewsFeed: Codable {
    let title, welcomeDescription, doctorID: String
    let image: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case welcomeDescription = "Description"
        case doctorID = "Doctor_ID"
        case image
    }
}
struct NewsFeedData: Codable {
    let doctorID: Int
    let title, description, docGender, docName: String
    let docClas: String

    enum CodingKeys: String, CodingKey {
        case doctorID = "Doctor_ID"
        case title = "Title"
        case description = "Description"
        case docGender = "Doc_Gender"
        case docName = "Doc_Name"
        case docClas = "Doc_Clas"
    }
}
