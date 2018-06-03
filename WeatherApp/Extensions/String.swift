//
//  String.swift
//  WeatherApp
//
//  Created by Pedja Jevtic on 5/7/18.
//  Copyright © 2018 Pedja Jevtic. All rights reserved.
//

import Foundation

extension String {
    var html2Attributed: NSAttributedString? {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
}
