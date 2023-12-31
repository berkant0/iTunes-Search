//
//  String+Extension.swift
//  iTunesSearch
//
//  Created by Berkant Dağtekin on 29.07.2023.
//

import Foundation

extension String {
    static var empty: String {
        ""
    }
    /// Use this function for formatting your date to human readable format
    func formatIsoStringToReadableDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none

        let date: Date? = dateFormatterGet.date(from: self)

        return dateFormatter.string(from: date!)
    }
}
