//
//  LoginTests.swift
//  Pleny taskTests
//
//  Created by Eslam Salem on 23/09/2023.
//

import XCTest
@testable import Pleny_task

class LoginViewModelTests: XCTestCase {
    var viewModel: LoginViewModel!
    var mockRepository: MockAuthRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockAuthRepository()
        viewModel = LoginViewModel(repository: mockRepository)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testLoginSuccess() {
        // Simulate a successful login by setting the expected result in the mock repository
        mockRepository.successRespone = LoginDomainModel(loginAPIModel: LoginAPIModel(token: "mock_token"))
        mockRepository.failedResponse = nil
        
        // Call the login method
        viewModel.login()
        
        // Assert that the view model's isLoggedIn property is set to true
        XCTAssertTrue(viewModel.isLoggedIn)
        
        // Assert that the UserDefaults value is set
        XCTAssertEqual(UserDefaults.standard.string(forKey: AppConstants.tokenKey), "mock_token")
    }
    
    func testLoginFailure() {
        // Simulate a failed login by setting the expected result in the mock repository
        mockRepository.successRespone = nil
        mockRepository.failedResponse = "Invalid credentials"
        
        // Call the login method
        viewModel.login()
        
        // Assert that the view model's showAlert property is set to true
        XCTAssertTrue(viewModel.showAlert)
        
        // Assert that the alert message matches the expected error message
        XCTAssertEqual(viewModel.alertMessage, "Invalid credentials")
    }
}
