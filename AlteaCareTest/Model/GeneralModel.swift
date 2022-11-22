//
//  GeneralModel.swift
//  AlteaCareTest
//
//  Created by Dicky Geraldi on 18/11/22.
//

import Foundation

class PhotoModel: NSObject {
    var url: String?
    var formats: PhotoFormatModel?
    
    static func createObject(_ dict: [String: Any]) -> PhotoModel {
        let model = PhotoModel()
        model.url = dict["url"] as? String
        model.formats = PhotoFormatModel.createObject(dict["formats"] as? [String: Any] ?? [:])

        return model
    }
}

class IconModel: NSObject {
    var url: String?
    var formats: PhotoFormatModel?
    
    static func createObject(_ dict: [String: Any]) -> IconModel {
        let model = IconModel()
        model.url = dict["url"] as? String
        model.formats = PhotoFormatModel.createObject(dict["formats"] as? [String: Any] ?? [:])

        return model
    }
}

class PhotoFormatModel: NSObject {
    var thumbnail: String?
    var large: String?
    var medium: String?
    var small: String?
    
    static func createObject(_ dict: [String: Any]) -> PhotoFormatModel {
        let model = PhotoFormatModel()
        model.thumbnail = dict["thumbnail"] as? String
        model.large = dict["large"] as? String
        model.medium = dict["medium"] as? String
        model.small = dict["small"] as? String

        return model
    }
}

class PriceModel: NSObject {
    var raw: String?
    var formatted: String?
    
    static func createObject(_ dict: [String: Any]) -> PriceModel {
        let model = PriceModel()
        model.raw = dict["raw"] as? String
        model.formatted = dict["formatted"] as? String

        return model
    }
}
