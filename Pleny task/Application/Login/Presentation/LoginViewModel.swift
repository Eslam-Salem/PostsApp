import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var isLoggedIn: Bool = false
    @Published var isLoggingIn: Bool = false
    private var repository: AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
    
    func login() {
        isLoggingIn = true
        repository.login(userName: username, password: password) { [weak self] loginDomainModel, errorMessage in
            if let errorMessage = errorMessage  {
                // Failed login
                self?.alertMessage = errorMessage
                self?.showAlert = true
            } else {
                // Successful login
                self?.isLoggedIn = true
                if let token = loginDomainModel?.token {
                    UserDefaults.standard.setValue(token, forKey: AppConstants.tokenKey)
                }
            }
            self?.isLoggingIn = false
        }
    }
}
