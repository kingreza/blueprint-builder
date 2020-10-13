//
//  String.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/14/20.
//

import Foundation

extension String {

    func camelCaseToWords() -> String {

        let spaced = unicodeScalars.reduce("") {

            if CharacterSet.uppercaseLetters.contains($1) {

                return ($0 + " " + String($1))
            }
            else {

                return $0 + String($1)
            }
        }
        return spaced.prefix(1).capitalized + spaced.dropFirst()
    }
}
