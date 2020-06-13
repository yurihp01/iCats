//
//  CatsViewModel.swift
//  iCats
//
//  Created by Yuri on 12/06/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import Foundation

class CatsViewModel {

    var cats: [Cat] = []
    
    var catsCount: Int {
        cats.count
    }
    
    init() {
        print("CatsViewModel INITIALIZATION")
    }
    
    deinit {
        print("CatsViewModel DEINITIALIZATION")
    }
    
    func getCatsFromAPI(onComplete: @escaping (Result<[Cat], APIError>) -> Void) {
        ImgurAPI.getCats { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let cats):
                self.cats = cats
                onComplete(.success(cats))
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
    

}
