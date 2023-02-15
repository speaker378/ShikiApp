//
//  ProfileBuilder.swift
//  ShikiApp
//
//  Created as per https://www.youtube.com/watch?v=2z5uWBRGjFI

import UIKit

class ProfileBuilder {
  
  static func build() -> (UIViewController & ProfileViewInputProtocol) {
      let presenter = ProfilePresenter()
      let viewController = ProfileViewController(presenter: presenter)
      
      presenter.viewInput = viewController
      return viewController
  }
}
