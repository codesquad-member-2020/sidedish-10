//
//  NetworkManageable.swift
//  SideDish
//
//  Created by 신한섭 on 2020/08/05.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

protocol NetworkManageable {
    func getResource(url: URL?, method: HTTPMethod, headers: HTTPHeaders?, handler : @escaping DataHandler)
    func downloadResource(from: URL, handler: @escaping DownloadHandler)
}

typealias DataHandler = (Result<Data, NetworkError>) -> Void
typealias DownloadHandler = (Result<URL, NetworkError>) -> Void
