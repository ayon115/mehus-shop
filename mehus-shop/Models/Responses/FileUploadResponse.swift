//
//  FileUploadResponse.swift
//  mehus-shop
//
//  Created by Ashiq Uz Zoha on 7/10/23.
//

import Foundation

struct FileUploadResponse: Decodable {
    let originalname : String
    let filename : String
    let location: String
}
