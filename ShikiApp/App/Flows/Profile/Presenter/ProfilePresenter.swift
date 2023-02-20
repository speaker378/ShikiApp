//
//  ProfilePresenter.swift
//  ShikiApp
//
  
import UIKit

protocol ProfileViewInputProtocol: AnyObject {
    var model: UserProfileDTO? { get set }
}

protocol ProfileViewOutputProtocol: AnyObject {
    func viewDidSelectUser(user: UserProfileDTO)
    func fetchData()
}

final class ProfilePresenter: ProfileViewOutputProtocol {

    // MARK: - Properties

    weak var viewInput: (UIViewController & ProfileViewInputProtocol)?

    // MARK: - Private properties

    private var user: UserModelAPI {
        return USERMODEL
    }

    // MARK: - Functions

    func viewDidSelectUser(user: UserProfileDTO) {
    
    }

    func fetchData() {
    
    }
}

  
