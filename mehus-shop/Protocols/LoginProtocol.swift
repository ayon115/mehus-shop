//
//  LoginProtocol.swift
//  mehus-shop
//
//  Created by Ashiq Uz Zoha on 7/11/23.
//

import Foundation

protocol LoginProtocol {
    func onProcessStart () 
    func onSuccess (loginResponse: LoginResponse?)
    func onError (errorMessage: String?)
}
