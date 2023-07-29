//
//  Builder.swift
//  iTunes-Search
//
//  Created by Berkant Dağtekin on 29.07.2023.
//

import UIKit

final class DetailBuilder {
    static func build(item: MediaItem) -> UIViewController {
        let controller = DetailViewController()
        
        controller.configure(with: item)

        return controller
    }
}
