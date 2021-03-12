//
//  SearchResult.swift
//  ImageSearch
//
//  Created by Jinwoo Kim on 3/12/21.
//

import Foundation

internal struct SearchResult: Decodable {
    let documents: [SearchDocunemt]
}
