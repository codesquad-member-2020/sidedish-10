//
//  ImageUseCase.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/25.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct ImageUseCase {
    static let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    static func loadImage(with manager: NetworkManager, from: URL, failureHandler: @escaping (NetworkManager.NetworkError) -> (), completed: @escaping(Data) -> ()) {
        
        let imageURL = cachesDirectory.appendingPathComponent(from.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: imageURL.path) {
            do {
                let data = try Data(contentsOf: imageURL)
                completed(data)
            } catch {
                failureHandler(.DecodeError)
            }
        } else {
            manager.downloadResource(from: from) {
                switch $0 {
                case .failure(let error):
                    failureHandler(error)
                case .success(let url):
                    do {
                        let data = try Data(contentsOf: url)
                        completed(data)
                        try? FileManager.default.moveItem(at: url, to: imageURL)
                    } catch {
                        failureHandler(.DecodeError)
                    }
                }
            }
        }
    }
}
