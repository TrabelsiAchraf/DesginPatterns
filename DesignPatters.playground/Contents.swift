import UIKit

// MARK: - Observer Pattern Implementation

let weatherStation = WeatherStation<Display>()
let display = Display(weatherStation, UUID().hashValue)

display.observe()

DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
    display.dispose()
}

// MARK: - Adapter Pattern Implementation

public class LoginViewController: UIViewController {
    
    public var authService: AuthentificationService
    
    init(authService: AuthentificationService) {
        self.authService = authService
        
        self.authService.login(email: "achraf@gmail.com", password: "nopassword") { result in
            switch result {
            case .success((let user, let token)):
                debugPrint("Login succeed for user \(user.description), with \(token.description)")
            case .failure(let error):
                debugPrint("Error: \(error)")
            }
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

let viewController = LoginViewController(authService: SomeSocialMediaAuthenticatorAdapter(authenticator: SomeSocialMediaAuthenticator()))
