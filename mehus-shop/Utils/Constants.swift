//
//  Constants.swift
//  mehus-shop
//
//  Created by Ashiq Uz Zoha on 26/8/23.
//

import Foundation

class Constants {
    public static let loginController = "LoginController"
    public static let authNavigationController = "AuthNavigationController"
    public static let signupController = "SignupController"
    public static let tabController = "tabController"
    public static let profileController = "ProfileController"
}

class CellIdentifier {
    public static let searchCell = "SearchCell"
    public static let productCell = "ProductCell"
    public static let categoryHolderCell = "CategoryHolderCell"
    public static let categoryCell = "CategoryCell"
    public static let collectionSectionHeaderView = "CollectionSectionHeaderView"
}

class RestClient {
    public static let baseUrl = "https://api.escuelajs.co"
    public static let categoryUrl = "/api/v1/categories"
}
