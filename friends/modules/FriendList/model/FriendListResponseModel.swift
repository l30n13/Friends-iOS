//
//  FriendListResponseModel.swift
//  friends
//
//  Created by Mahbubur Rashid Leon on 17/4/22.
//

import Foundation

class FriendListResponseModel : Decodable {
    let results : [ResultsModel]?

    enum CodingKeys: String, CodingKey {
        case results = "results"
    }

    required init(from decoder: Decoder) throws {
        let values   = try decoder.container(keyedBy: CodingKeys.self)
        results      = try values.decodeIfPresent([ResultsModel].self, forKey: .results)
    }
    
    init(results: [ResultsModel]) {
        self.results = results
    }
}

class ResultsModel : Codable {
    let gender : String?
    let name : NameModel?
    let location : LocationModel?
    let email : String?
    let phone : String?
    let cell : String?
    let picture : PictureModel?

    enum CodingKeys: String, CodingKey {
        case gender     = "gender"
        case name       = "name"
        case location   = "location"
        case email      = "email"
        case phone      = "phone"
        case cell       = "cell"
        case picture    = "picture"
    }

    required init(from decoder: Decoder) throws {
        let values      = try decoder.container(keyedBy: CodingKeys.self)
        gender          = try values.decodeIfPresent(String.self, forKey: .gender)
        name            = try values.decodeIfPresent(NameModel.self, forKey: .name)
        location        = try values.decodeIfPresent(LocationModel.self, forKey: .location)
        email           = try values.decodeIfPresent(String.self, forKey: .email)
        phone           = try values.decodeIfPresent(String.self, forKey: .phone)
        cell            = try values.decodeIfPresent(String.self, forKey: .cell)
        picture         = try values.decodeIfPresent(PictureModel.self, forKey: .picture)
    }
}

class NameModel : Codable {
    let title : String?
    let first : String?
    let last : String?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case first = "first"
        case last = "last"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        first = try values.decodeIfPresent(String.self, forKey: .first)
        last = try values.decodeIfPresent(String.self, forKey: .last)
    }
}

class LocationModel : Codable {
    let street: StreetModel?
    let city : String?
    let state : String?
    let country : String?
    let postCode : Int?
    
    enum CodingKeys: String, CodingKey {
        case street = "street"
        case city = "city"
        case state = "state"
        case country = "country"
        case postCode = "postcode"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        street = try values.decodeIfPresent(StreetModel.self, forKey: .street)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        postCode = try values.decodeIfPresent(Int.self, forKey: .postCode)
    }
}

class StreetModel : Codable {
    let number: Int?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        case number = "number"
        case name = "name"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        number = try values.decodeIfPresent(Int.self, forKey: .number)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}

class PictureModel : Codable {
    let large : String?
    let medium : String?
    let thumbnail : String?

    enum CodingKeys: String, CodingKey {
        case large = "large"
        case medium = "medium"
        case thumbnail = "thumbnail"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        large = try values.decodeIfPresent(String.self, forKey: .large)
        medium = try values.decodeIfPresent(String.self, forKey: .medium)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
    }
}
