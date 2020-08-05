//
//  ImageUseCase.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/25.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct ImageUseCase {
    
    static let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
    static func loadImage(with manager: NetworkManager, from: URL, failureHandler: @escaping (NetworkError) -> Void, completed: @escaping(Data) -> Void) {
        guard let cacheDir = cachesDirectory else { return }
        let imageURL = cacheDir.appendingPathComponent(from.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: imageURL.path) {
            handleData(from: imageURL, failureHandler: failureHandler, completed: completed)
        } else {
            manager.downloadResource(from: from) {
                switch $0 {
                case .failure(let error):
                    failureHandler(error)
                    
                case .success(let url):
                    handleData(from: url, failureHandler: failureHandler, completed: completed)
                    try? FileManager.default.moveItem(at: url, to: imageURL)
                }
            }
        }
    }
    
    private static func handleData(from url: URL, failureHandler: @escaping (NetworkError) -> Void, completed: @escaping(Data) -> Void) {
        do {
            let data = try Data(contentsOf: url)
            completed(data)
        } catch {
            failureHandler(.decodeError)
        }
    }
}
