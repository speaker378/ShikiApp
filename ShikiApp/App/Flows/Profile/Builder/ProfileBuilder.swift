//
//  ProfileBuilder.swift
//  ShikiApp
//
//  Created by Anton Lebedev on 02.02.2023.
//  As per https://www.youtube.com/watch?v=2z5uWBRGjFI

import UIKit

class ProfileBuilder {
    
    static func build() -> (UIViewController & ProfileViewInputProtocol) {
        let presenter = ProfilePresenter()
        let viewController = ProfileViewController(presenter: presenter)

        presenter.viewInput = viewController
        return viewController
    }
}
