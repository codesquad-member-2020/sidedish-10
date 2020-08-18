//
//  ImageUseCase.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/25.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct ImageUseCase {
    
    let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
    
    func loadImage(with manager: NetworkManageable, from: URL, failureHandler: @escaping (NetworkError) -> Void, completed: @escaping(Data) -> Void) {
        guard let cacheDir = cachesDirectory else { return }
        let imageURL = cacheDir.appendingPathComponent(from.lastPathComponent)
        
        guard FileManager.default.fileExists(atPath: imageURL.path) else {
            manager.downloadResource(from: from) { 
                switch $0 {
                case .failure(let error):
                    failureHandler(error)
                    
                case .success(let url):
                    self.handleData(from: url, failureHandler: failureHandler, completed: completed)
                    try? FileManager.default.moveItem(at: url, to: imageURL)
                }
            }
            return
        }
        
        handleData(from: imageURL, failureHandler: failureHandler, completed: completed)
    }
    
    private func handleData(from url: URL, failureHandler: @escaping (NetworkError) -> Void, completed: @escaping(Data) -> Void) {
        do {
            let data = try Data(contentsOf: url)
            completed(data)
        } catch {
            failureHandler(.decodeError)
        }
    }
}
