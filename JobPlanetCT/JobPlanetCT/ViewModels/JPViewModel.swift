//
//  JPViewModel.swift
//  JobPlanetCT
//
//  Created by yoon on 2021/05/26.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class JPViewModel {
    
    var items  = BehaviorSubject<[Item]>(value: [])
    var itemsCount = 0
    var page = 0
    var themes = BehaviorSubject<[Theme]>(value: [])
    
    func requestData(){
        var param : Parameters = ["page" : page]
        param["page_size"] = 10
        
        
        NetworkManager.shared.requestPost(nil){ [self] (result) in
            switch(result) {
            case let .failure(error):
                print(error)
                print("실패")
            case let .success(res):
                do {
                    let dataJSON = try JSONSerialization.data(withJSONObject: res, options: .prettyPrinted)
                    if let data = try? JSONDecoder().decode(BaseModel.self, from: dataJSON) {
                        
                        if !data.items.isEmpty {
                            itemsCount = data.items.count
                            items.onNext(data.items)
                        }
                    }
                } catch {
                    print(error)
                }
                break
            }
        }
    }
    
    
}
