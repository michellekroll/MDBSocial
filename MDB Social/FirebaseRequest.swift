//
//  FirebaseRequest.swift
//  MDB Social
//
//  Created by Michelle Kroll on 10/20/20.
//

import Foundation
import Firebase

class FirebaseRequest {
    
    static let shared = FirebaseRequest()
    
    func signIn(withEmail email: String, password: String, completion: @escaping (Result<User, FIBAuthError>) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { authResult, error in
            if let error = error {
                let authError = error as NSError
                switch authError.code {
                case AuthErrorCode.rejectedCredential.rawValue:
                    completion(.failure(.rejectedCredential))
                case AuthErrorCode.userNotFound.rawValue:
                    completion(.failure(.rejectedCredential))
                case AuthErrorCode.invalidEmail.rawValue:
                    completion(.failure(.malformedEmail))
                case AuthErrorCode.networkError.rawValue:
                    completion(.failure(.networkError))
                default:
                    completion(.failure(.generalError))
                }
                return
            }
            completion(.success(authResult!.user))
        })
    }
    
    enum FIBAuthError: Error {
        case emptyEmail, emptyPassword
        case malformedEmail, malformedPassword
        case rejectedCredential, networkError
        case generalError
    }
    
    func register(withEmail email: String, password: String, completion: @escaping (Result<User, FIBRegisError>) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                let authError = error as NSError
                switch authError.code {
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    completion(.failure(.emailInUse))
                default:
                    completion(.failure(.generalError))
                }
                return
            }
            
            completion(.success(result!.user))
        }
        
    }
    
    enum FIBRegisError: Error {
        case emailInUse
        case generalError
    }
    
    func addUserInfo(withEmail email: String, firstname: String, lastname: String, birthday: String, mobile: String, completion: (()->Void)? = nil) {
        
        let ref = getReference(forCollection: .userInfo)
        
        let docData: [String: Any] = [
            "email": email,
            "firstname": firstname,
            "lastname": lastname,
            "birthday": birthday,
            "mobile": mobile,
        ]
        
        ref.document().setData(docData) { error in
            guard error == nil else {
                print("Firebase Error")
                return
            }
            completion?()
        }
    }
    
    private func getReference(forCollection collection: FIBCollection) -> CollectionReference {
        let db = Firestore.firestore()
        return db.collection(collection.rawValue)
    }
    
    private enum FIBCollection: String {
        case userInfo
    }
}

