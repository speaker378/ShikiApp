//
//  ForumsRequestFactory.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 17.01.2023.
// FF

import Foundation

final class ForumsRequestFactory: AbstractRequestFactory<ForumsApi> {
    func listForums(completion: @escaping (_ response: ForumsResponseDTO?, _ error: String?) -> Void) { getResponse(type: ForumsResponseDTO.self, endPoint: .list, completion: completion) }
}
