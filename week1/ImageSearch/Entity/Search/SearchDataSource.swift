//
//  SearchDataSource.swift
//  ImageSearch
//
//  Created by Jinwoo Kim on 3/12/21.
//

import Foundation
import RxDataSources

internal typealias SearchDataSourceSectionModel = AnimatableSectionModel<SearchDataSourceSection, SearchDataSourceSectionItem>

internal enum SearchDataSourceSection: Int, IdentifiableType, Equatable {
    case search = 0
    
    internal var identity: Int {
        return rawValue
    }
    
    internal static func == (lhs: SearchDataSourceSection, rhs: SearchDataSourceSection) -> Bool {
        return lhs.identity == rhs.identity
    }
}

internal struct SearchDataSourceData: IdentifiableType, Equatable {
    internal var displaySitename: String
    internal var thumbnailUrl: URL
    internal var docUrl: URL?
    
    internal var identity: String {
        return thumbnailUrl.absoluteString
    }
    
    internal static func == (lhs: SearchDataSourceData, rhs: SearchDataSourceData) -> Bool {
        return lhs.identity == rhs.identity
    }
}

internal enum SearchDataSourceSectionItem: IdentifiableType, Equatable {
    case search(SearchDataSourceData)
    
    internal var identity: String {
        switch self {
        case .search(let data):
            return data.identity
        }
    }
    
    internal static func == (lhs: SearchDataSourceSectionItem, rhs: SearchDataSourceSectionItem) -> Bool {
        return lhs.identity == rhs.identity
    }
}
