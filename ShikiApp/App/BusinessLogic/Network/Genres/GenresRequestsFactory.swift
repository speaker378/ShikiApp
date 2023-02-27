//
//  GenreRequestsFactory.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 19.02.2023.
//

import Foundation

// MARK: - GenreRequestsFactoryProtocol

protocol GenresRequestFactoryProtocol {

    // MARK: - Properties

    var delegate: (AbstractRequestFactory<GenreApi>)? { get }

    // MARK: - Functions

    func getList(completion: @escaping (_ response: GenreResponseDTO?, _ error: String?) -> Void)
}

// MARK: - GenresRequestFactoryProtocol extension

extension GenresRequestFactoryProtocol {

    // MARK: - Functions

    func getList(completion: @escaping (_ response: GenreResponseDTO?, _ error: String?) -> Void) {
        delegate?.getResponse(
            type: GenreResponseDTO.self,
            endPoint: .list,
            completion: completion
        )
    }
}

// MARK: - GenresRequestFactory

final class GenresRequestFactory: GenresRequestFactoryProtocol {

    // MARK: - Properties

    let delegate: (AbstractRequestFactory<GenreApi>)?

    // MARK: - Construction

    init() {
        delegate = AbstractRequestFactory<GenreApi>()
    }
}
