//
//  Auth.swift
//  Authorize
//
//  Created by Mahesh Sammatashetti on 07/01/19.
//  Copyright © 2019 Cybage. All rights reserved.
//

import Foundation
import AppAuth

public class Auth
{
    public static var currentAuthorizationFlow : OIDExternalUserAgentSession?
    public class func doAuthorization(presentingVC: UIViewController, authEndPoint:String, tokenEndPoint:String, redirectUrl:String, clientId:String, clientSecret:String, scopes:[String], responseType:String, callback: (@escaping (OIDAuthorizationResponse?, OIDAuthState?, String?, Error?) -> Void)) {
        print("doAuthorization - method started")
        let authorizationEndPoint = URL(string: authEndPoint)
        let tokenEndPoint = URL(string: tokenEndPoint)
        let configuration = OIDServiceConfiguration(authorizationEndpoint:authorizationEndPoint!, tokenEndpoint:tokenEndPoint!)
        let redirectURI = URL(string: redirectUrl)
        let request = OIDAuthorizationRequest(configuration: configuration, clientId: clientId, clientSecret: clientSecret, scopes:scopes, redirectURL: redirectURI!, responseType: responseType, additionalParameters: nil)
        
        currentAuthorizationFlow =
            OIDAuthorizationService.present(request, presenting:presentingVC, callback:{(regResponse:OIDAuthorizationResponse?,  error:Error?) -> Void in
                if let userAuthResponse = regResponse
                {
                    print("doAuthorization - inside userauthresponse if")
                    let userAuthState = OIDAuthState(authorizationResponse: userAuthResponse)
                    print("doAuthorization - userauthstate - inside userauthresponse if \(userAuthState)")
                    
                    let tokenExchangeRequest = userAuthResponse.tokenExchangeRequest()
                    
                    /* SDK method for token request */
                    OIDAuthorizationService.perform(tokenExchangeRequest!, callback: {(_ tokenResponse: OIDTokenResponse?, _ error: Error?) -> Void in
                        print("error is \(error.debugDescription)")
                        userAuthState.update(with: tokenResponse, error: error)
                        //print("auth state desc is \(userAuthState.description)")
                        if tokenResponse == nil
                        {
                            print("Token exchange error: \(error?.localizedDescription ?? "no error")")
                            callback(nil, nil, nil, error)
                        }
                        else
                        {
                            print("Received token response with accessToken:\(tokenResponse?.accessToken ?? "token not found")")
                            callback(userAuthResponse, userAuthState, tokenResponse?.accessToken, nil)
                        }
                        
                    })
                    /* SDK method for token request */
                }
                else{
                    print("doAuthorization - inside userauthresponse else")
                    callback(nil, nil, nil, error)
                }
            })
        
        print("doAuthorization - method end")
    }
    
    public class func getRefreshToken(currentAuthState:OIDAuthState, callback: (@escaping (String?, Error?) -> Void))
    {
        currentAuthState.tokenRefreshRequest()
        currentAuthState.performAction(freshTokens: {(_ accessToken:String?, _ idToken:String?, _ error:Error?) -> Void in
            if let error = error as NSError?
            {
                print("error while getting refresh token:\(error.localizedDescription)")
                callback("", error)
            }
            print("new access token is \(String(describing: accessToken))")
            print("new id token is \(String(describing: idToken))")
            callback(accessToken, nil)
        })
    }
}
