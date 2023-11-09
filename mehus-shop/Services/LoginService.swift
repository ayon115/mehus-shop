//
//  LoginService.swift
//  mehus-shop
//
//  Created by Ashiq Uz Zoha on 7/11/23.
//

import Foundation
import Alamofire

class LoginService {
    
    func initiateLogin (email: String, password: String, loginDelegate: LoginProtocol) {
        
        let url = RestClient.baseUrl + RestClient.loginUrl
        let loginRequest = LoginRequest(email: email, password: password)
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
     //   
        AF.request(url, method: .post, parameters: loginRequest, encoder: JSONParameterEncoder.default, headers: headers, interceptor: nil, requestModifier: nil).responseDecodable(of: LoginResponse.self) { response in
         //   
            
            switch (response.result) {
                case .success:
                print(response)
                if let responseData = response.value {
                    if let accessToken = responseData.access_token {
                        loginDelegate.onSuccess(loginResponse: responseData)
                    } else if let statusCode = responseData.statusCode, let message = responseData.message {
                        loginDelegate.onError(errorMessage: message)
                    }
                }
                case let .failure(error):
                    print(error)
            }
        }
    }
}
