//
//  User.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import Foundation

struct User: Codable {

    var _id: Int?
    var uuid: String?
    var firstName: String?
    var lastName: String?
    var fullName: String?
    var email: String?
    var accessToken: String?

    public init(_id: Int?, uuid: String?, firstName: String?, lastName: String?, fullName: String?, email: String?, accessToken: String?) {
        self._id = _id
        self.uuid = uuid
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = fullName
        self.email = email
        self.accessToken = accessToken
    }

    public enum CodingKeys: String, CodingKey {
        case _id = "id"
        case uuid
        case firstName = "first_name"
        case lastName = "last_name"
        case fullName = "full_name"
        case email
        case accessToken = "access_token"
    }


}
