//
//  SearchViewModel.swift
//  ImageSearch
//
//  Created by Jinwoo Kim on 3/12/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

internal final class SearchViewModel {
    internal private(set) var dataSource: Driver<[SearchDataSourceSectionModel]>!
    internal let keywordEvent: PublishSubject<String> = .init()
    
    internal init() {
        dataSource = searchModel.searchEvent
            .map { data -> [SearchDataSourceSectionModel] in
                let items: [SearchDataSourceSectionItem] = data.documents
                    .map { document -> SearchDataSourceSectionItem in
                        .search(SearchDataSourceData(displaySitename: document.displaySitename,
                                                     thumbnailUrl: document.thumbnailUrl,
                                                     docUrl: document.docUrl))
                    }
                return [.init(model: .search, items: items)]
            }
            .asDriver(onErrorJustReturn: [])
        
        bind()
    }
    
    private let searchModel: SearchModel = .init()
    private var disposeBag: DisposeBag = .init()
    
    private func bind() {
        keywordEvent
            .subscribe(with: self, onNext: { (obj, keyword) in
                obj.searchModel.reqeust(keyword: keyword)
            })
            .disposed(by: disposeBag)
    }
}
