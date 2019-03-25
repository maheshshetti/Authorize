//
//  Constants.swift
//  Authorize
//
//  Created by Mahesh Sammatashetti on 07/01/19.
//  Copyright © 2019 Cybage. All rights reserved.
//

import Foundation

struct APP_CONFIGURATION
{
    static let clientID = "codeclient"
    static let responseType = "code"
    static let secret = "secret"
    static let scope = "read openid profile offline_access idmgr"
    static let redirectURL = "com.cybage.gateway:/oidc_callback"
    static let tokenEndPointAuthMethod = "client_secret_post"
}

struct API
{
    static let baseURLAuth = "https://dmzsso.cybage.com"
    static let baseURLPublic = "https://dmzbi.cybage.com"
    static let baseURLTheHub = "https://dmzthehub.cybage.com"
    static let userInfoEndPoint = API.baseURLAuth + "/connect"
    static let authorizationEndPoint =  API.baseURLAuth + "/connect/authorize"
    static let tokenEndPoint = API.baseURLAuth + "/connect/token"
    static let navigationStructureByID = "https://dmzbi.cybage.com/DMI/L/NavigationStructure/ById"
    static let userClaim = "https://dmzbi.cybage.com/CYB/L/UserClaim/ByName"
}

struct KEYS
{
    static let access_token = "access_token"
    static let refresh_token = "refresh_token"
}
