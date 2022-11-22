//
//  HospitalModel.swift
//  AlteaCareTest
//
//  Created by Dicky Geraldi on 18/11/22.
//

import Foundation

class HospitalModel: NSObject {
    var id: String?
    var name: String?
    var image: PhotoModel?
    var icon: IconModel?
    
    static func createObject(_ dict: [String: Any]) -> HospitalModel {
        let model = HospitalModel()
        model.id = dict["id"] as? String
        model.name = dict["name"] as? String
        model.image = PhotoModel.createObject(dict["image"] as? [String: Any] ?? [:])
        model.icon = IconModel.createObject(dict["icon"] as? [String: Any] ?? [:])

        return model
    }

    func getHospitalName() -> String {
        return name ?? ""
    }
}
