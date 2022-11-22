//
//  ObjectFoundation+Ext.swift
//  AlteaCareTest
//
//  Created by Dicky Geraldi on 18/11/22.
//

import Foundation

extension Optional {
    func ifNil(_ then: Wrapped) -> Wrapped {
        switch self {
            case .none: return then
            case let .some(value): return value
        }
    }
}

extension String {
    var urlEncoded: String? {
        let allowedCharacterSet = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "~-_."))
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
    }

    func convertToDictionary() -> [String: Any]? {
        if let data = data(using: .utf8) {
            return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        }
        return nil
    }
    
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }

        return try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
        )
    }
}

func Dlog(_ message: String,
          function: String = #function,
          file: String = #file,
          line: Int = #line,
          column: Int = #column) {
    #if DEBUG
    let string = "\n====================================================\nfile: \(file)\nfunction: \(function)\nline: \(line)\ncolumn: \(column)\nMESSAGE: \(message)\nTIME: \(Date())\n\n\n"
    print("\(string)")
    #else
    #endif
}
