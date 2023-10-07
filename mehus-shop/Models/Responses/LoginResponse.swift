//
//  LoginResponse.swift
//  mehus-shop
//
//  Created by Ashiq Uz Zoha on 3/10/23.
//

import Foundation

struct LoginResponse: Decodable {
    let access_token: String?
    let refresh_token: String?
    let statusCode: Int?
    let message: String?
}
