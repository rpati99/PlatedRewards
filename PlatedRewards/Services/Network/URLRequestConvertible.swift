//
//  URLRequestConvertible.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/9/24.
//

import Foundation

// Protocol that ensures any conforming type can generate a URLRequest
public protocol URLRequestConvertible {
    func makeURLRequest() throws -> URLRequest
}
