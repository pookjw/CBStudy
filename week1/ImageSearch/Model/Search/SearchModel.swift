//
//  SearchModel.swift
//  ImageSearch
//
//  Created by Jinwoo Kim on 3/12/21.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

internal final class SearchModel {
    internal static let shared: SearchModel = .init()
    internal let searchEvent: PublishSubject<SearchResult> = .init()
    
    internal func reqeust(keyword: String, page: Int = 1) {
        guard let apiUrl: URL = apiUrl else { return }
        
        let parameters = ["query": keyword, "page": String(page)]
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK \(apiKey)"
        ]
        
        AF.request(apiUrl, method: .get, parameters: parameters, headers: headers)
            .validate(statusCode: 200...299)
            .responseData { [weak self] response in
                let decoder: JSONDecoder = .init()
                guard let data: Data = response.data,
                    let decoded: SearchResult = try? decoder.decode(SearchResult.self, from: data) else {
                    fatalError()
                }
                self?.searchEvent.onNext(decoded)
            }
    }
    
    private let apiUrl: URL? = URL(string: "https://dapi.kakao.com/v2/search/image")
    private let apiKey: String = "dff576e28ce434796a2329a6a2366d76"
    private var disposeBag: DisposeBag = .init()
}
