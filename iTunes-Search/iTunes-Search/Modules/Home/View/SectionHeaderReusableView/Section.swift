//
//  Section.swift
//  iTunes-Search
//
//  Created by Berkant Dağtekin on 29.07.2023.
//

import Foundation

final class Section: Hashable {
    
    // MARK: Properties
    var id = UUID()
    var title: String
    var items: [MediaItem]
    
    // MARK: Init
    init(title: String, items: [MediaItem]) {
        self.title = title
        self.items = items
    }
    
    // MARK: Functions
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Section, rhs: Section) -> Bool {
        lhs.id == rhs.id
    }
}
