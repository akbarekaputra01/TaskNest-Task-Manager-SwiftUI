//
//  String+Ext.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 15/06/24.
//

import Foundation
import RegexBuilder

extension String {
    var isValidEmail: Bool {
        // let emailFormat         = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        // let emailPredicate      = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        // return emailPredicate.evaluate(with: self)

        let emailRegex = Regex {
            // Local part
            OneOrMore {
                CharacterClass(
                    .anyOf("._%+-"),
                    "A"..."Z",
                    "0"..."9",
                    "a"..."z"
                )
            }
            "@"
            // Domain part
            OneOrMore {
                CharacterClass(
                    "A"..."Z",
                    "a"..."z",
                    "0"..."9"
                )
            }
//            Optionally {
            OneOrMore {
                "."
                OneOrMore {
                    CharacterClass(
                        "A"..."Z",
                        "a"..."z"
                    )
                }
            }
//            }
        }

        return self.wholeMatch(of: emailRegex) != nil
    }
}
