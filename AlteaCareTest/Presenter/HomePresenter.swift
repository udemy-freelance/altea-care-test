//
//  HomePresenter.swift
//  AlteaCareTest
//
//  Created by Dicky Geraldi on 18/11/22.
//

import Foundation

protocol HomeViewPresenter: AnyObject {
    init(view: HomeView, service: IHomeService)
    func fetchAllData()
    func getHospital()
    func getSpecialization()
    func getSpecializationData() -> [String]
    func getHospitalData() -> [String]
    func getData() -> [DoctorModel]
    func getDataByQuery()  -> [DoctorModel]
    func searchTapped(query: String)
    func searchBySpecialization(query: String)
    func searchByHospital(query: String)
    func countDoctorData(isSearch: Bool) -> Int
}

class HomePresenter: HomeViewPresenter {
    func getHospital() {
        for doctor in listDoctors {
            for hospital in doctor.getHospitalsData() {
                if !tempHospital.contains(hospital.getHospitalName()) {
                    tempHospital.append(hospital.getHospitalName())
                }
            }
        }
    }
    
    func getSpecialization() {
        for doctor in listDoctors {
            if !tempSpecialization.contains(doctor.getSpecialization()) {
                tempSpecialization.append(doctor.getSpecialization())
            }
        }
    }
    
    func getSpecializationData() -> [String] {
        return tempSpecialization
    }
    
    func getHospitalData() -> [String] {
        return tempHospital
    }
    
    func countDoctorData(isSearch: Bool) -> Int {
        if isSearch {
            return listDoctorsByQuery.count
        }
        return listDoctors.count
    }
    
    func fetchAllData() {
        view?.onLoadingRetrieve()
        homeService?.requestDoctorList(
            onComplete: { doctors in
                for doctor in doctors {
                    self.listDoctors.append(DoctorModel.createObject(doctor))
                }
                self.view?.onSuccessRetrieveDoctor()
            },
            onError: { error in
                self.view?.onFailedRetrieveDoctor(message: error.localizedDescription)
            }
        )
    }
    
    func getData() -> [DoctorModel] {
        return listDoctors
    }
    
    func searchTapped(query: String) {
        listDoctorsByQuery.removeAll()
        if !listDoctors.isEmpty {
            for doctor in listDoctors {
                if doctor.getDoctorName().lowercased().contains(query.lowercased()) {
                    listDoctorsByQuery.append(doctor)
                }
            }
            view?.onDoneRetrieveByQuery()
        } else {
            view?.onFailedRetrieveDoctor(message: "No Doctor Data")
        }
    }
    
    func searchBySpecialization(query: String) {
        listDoctorsByQuery.removeAll()
        if !listDoctors.isEmpty {
            for doctor in listDoctors {
                if doctor.getSpecialization().contains(query) {
                    listDoctorsByQuery.append(doctor)
                }
            }
            view?.onDoneRetrieveByQuery()
        } else {
            view?.onFailedRetrieveDoctor(message: "No Doctor Data")
        }
    }
    
    func searchByHospital(query: String) {
        listDoctorsByQuery.removeAll()
        if !listDoctors.isEmpty {
            for doctor in listDoctors {
                for hospital in doctor.getHospitalsData() {
                    if hospital.getHospitalName().contains(query) {
                        listDoctorsByQuery.append(doctor)
                    }
                }
            }
            view?.onDoneRetrieveByQuery()
        } else {
            view?.onFailedRetrieveDoctor(message: "No Doctor Data")
        }
    }
    
    func getDataByQuery() -> [DoctorModel] {
        return listDoctorsByQuery
    }
    
    weak var view: HomeView?
    private var homeService: IHomeService?
    private var isSearch: Bool?
    private var tempHospital: [String] = ["No Filter"]
    private var tempSpecialization: [String] = ["No Filter"]
    private var listDoctors: [DoctorModel] = []
    private var listDoctorsByQuery: [DoctorModel] = []
    
    required init(view: HomeView, service: IHomeService) {
        self.view = view
        self.homeService = service
    }
}
