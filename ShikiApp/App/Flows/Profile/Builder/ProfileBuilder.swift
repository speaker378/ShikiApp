//
//  ProfileBuilder.swift
//  ShikiApp
//

import UIKit

class ProfileBuilder {
  
  static func build() -> (UIViewController & ProfileViewInputProtocol) {
      let presenter = ProfilePresenter()
      let viewController = ProfileViewController(presenter: presenter)
      
      presenter.viewInput = viewController
      return viewController
  }
}
