//
//  DetailViewController.swift
//  iTunes-Search
//
//  Created by Berkant Dağtekin on 29.07.2023.
//

import UIKit

// MARK: - DetailController
class DetailViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var collectionNamelabel: UILabel!
    @IBOutlet weak var collectionPriceLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Detail"
    }

    func configure(with item: MediaItem) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.collectionNamelabel.text = item.collectionName
            self.collectionPriceLabel.text = "\(item.currency ?? .empty) \(item.collectionPrice ?? .zero)"
            self.releaseDateLabel.text = item.releaseDate?.formatIsoStringToReadableDate()

            if let imageUrl = item.artworkUrl100 {
                self.thumbnailImageView.downloaded(from: imageUrl)
            }
        }
    }
}

