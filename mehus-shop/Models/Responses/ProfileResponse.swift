//
//  ProfileResponse.swift
//  mehus-shop
//
//  Created by Ashiq Uz Zoha on 7/10/23.
//

import Foundation

struct ProfileResponse: Decodable {
    let id: Int
    let email: String
    let name: String
    let role: String
    let avatar: String
}
