//
//  SearchDocument.swift
//  ImageSearch
//
//  Created by Jinwoo Kim on 3/12/21.
//

import Foundation

internal struct SearchDocunemt: Decodable {
    internal var displaySitename: String
    internal var docUrl: URL?
    internal var thumbnailUrl: URL
    internal var imageUrl: URL?
    
    private enum CodingKeys: String, CodingKey {
        case displaySitename = "display_sitename"
        case docUrl = "doc_url"
        case thumbnailUrl = "thumbnail_url"
        case imageUrl = "image_url"
    }
    
    internal init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.displaySitename = try container.decode(String.self, forKey: .displaySitename)
        
        let docUrl: String = try container.decode(String.self, forKey: .docUrl)
        self.docUrl = URL(string: docUrl)
        
        let thumbnailUrl: String = try container.decode(String.self, forKey: .thumbnailUrl)
        self.thumbnailUrl = URL(string: thumbnailUrl)!
        
        let imageUrl: String = try container.decode(String.self, forKey: .imageUrl)
        self.imageUrl = URL(string: imageUrl)
    }
}
