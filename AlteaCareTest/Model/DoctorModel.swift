//
//  DoctorModel.swift
//  AlteaCareTest
//
//  Created by Dicky Geraldi on 18/11/22.
//

import Foundation

class DoctorModel: NSObject {
    var doctorId: String?
    var name: String?
    var overview: String?
    var about: String?
    var experience: String?
    var aboutPreview: String?
    var price: PriceModel?
    var specialization: Specialization?
    var hospitals: [HospitalModel] = []
    var image: PhotoModel?
    var icon: IconModel?
    
    static func createObject(_ dict: [String: Any]) -> DoctorModel {
        let model = DoctorModel()
        model.doctorId = dict["doctor_id"] as? String
        model.name = dict["name"] as? String
        model.overview = dict["overview"] as? String
        model.about = dict["about"] as? String
        model.experience = dict["experience"] as? String
        model.aboutPreview = dict["about_preview"] as? String
        model.price = PriceModel.createObject(dict["price"] as? [String: Any] ?? [:])
        model.image = PhotoModel.createObject(dict["photo"] as? [String: Any] ?? [:])
        model.specialization = Specialization.createObject(dict["specialization"] as? [String: Any] ?? [:])
        model.icon = IconModel.createObject(dict["icon"] as? [String: Any] ?? [:])

        if let hospitals = dict["hospital"] as? [[String: Any]] {
            for hospitalData in hospitals {
                model.hospitals.append(HospitalModel.createObject(hospitalData))
            }
        }

        return model
    }

    func getDoctorName() -> String {
        if let name = name {
            return name
        }
        return ""
    }
    
    func hospitalAndSpecialization() -> String {
        if let specialization = specialization?.name {
            return "\(hospitals[0].name ?? "") - \(specialization)"
        }
        return ""
    }
    
    func getHospitalsData() -> [HospitalModel] {
        return hospitals
    }
    
    func getSpecialization() -> String {
        return specialization?.name ?? ""
    }
}

class Specialization: NSObject {
    var id: String?
    var name: String?

    static func createObject(_ dict: [String: Any]) -> Specialization {
        let model = Specialization()
        model.id = dict["id"] as? String
        model.name = dict["name"] as? String

        return model
    }
}
