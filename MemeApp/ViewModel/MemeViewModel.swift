//
//  MemeViewModel.swift
//  MemeApp
//
//  Created by Hanamanth Nagonde on 18/10/23.
//

import Foundation

class MemeViewModel: ObservableObject {
    
    @Published var memeData: [Meme] = []
    
    func fetchMeme() {
        NetworkManager.shared.fetch(url: "https://api.imgflip.com/get_memes", type: MemeModle.self) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.memeData = response.data.memes
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
