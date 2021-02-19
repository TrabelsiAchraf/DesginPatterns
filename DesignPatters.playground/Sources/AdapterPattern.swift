import Foundation

// MARK: - Legacy Object

public class SomeSocialMediaAuthenticator {
    
    public init() {
        
    }
    
    public func login(
        email: String,
        password: String,
        completion: @escaping (Result<SomeSocialMediaUser, Error>) -> Void) {
        
        let token = "mother$0fucker!token€2021"
        let user = SomeSocialMediaUser(email: email, password: password, token: token)
        completion(.success(user))
    }
    
    public struct SomeSocialMediaUser {
        var email: String
        var password: String
        var token: String
    }
}

// MARK: - New Protocol

public protocol AuthentificationService {
    func login(email: String, password: String, completion: @escaping ((Result<(User, Token), Error>) -> Void))
}

public struct User {
    let email: String
    let password: String
    
    public var description: String {
        "Email: \(email), Password: \(password)"
    }
}

public struct Token {
    let value: String
    
    public var description: String {
        "Token: \(value)"
    }
}

// MARK: - Adapter

public class SomeSocialMediaAuthenticatorAdapter: AuthentificationService {
    
    private var authenticator: SomeSocialMediaAuthenticator
    
    public init(authenticator: SomeSocialMediaAuthenticator) {
        self.authenticator = authenticator
    }
    
    public func login(
        email: String,
        password: String,
        completion: @escaping ((Result<(User, Token), Error>) -> Void)) {
        
        authenticator.login(email: email, password: password) { result in
            switch result {
            case .success(let someSocialMediaUser):
                let user = User(email: someSocialMediaUser.email, password: someSocialMediaUser.password)
                let token = Token(value: someSocialMediaUser.token)
                completion(.success((user, token)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
