//
//  HomeViewController.swift
//  AlteaCareTest
//
//  Created by Dicky Geraldi on 18/11/22.
//

import UIKit

protocol HomeView: NSObject {
    func onSuccessRetrieveDoctor()
    func onFailedRetrieveDoctor(message: String)
    func onLoadingRetrieve()
    func onDoneRetrieveByQuery()
}

class HomeViewController: UIViewController {
    
    // MARK: - Variable
    @IBOutlet weak var tfQuerySearchDoctor: UITextField!
    @IBOutlet weak var tfSearchByRS: UITextField!
    @IBOutlet weak var tfSearchBySpecialization: UITextField!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var svListDoctor: UIStackView!
    
    var presentor: HomePresenter?
    let pickerSpecialization = UIPickerView()
    let pickerHospital = UIPickerView()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presentor?.fetchAllData()
        setupDelegation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func onClickSearch(_ sender: Any) {
        if let txt = tfQuerySearchDoctor.text, txt.isEmpty {
            onSuccessRetrieveDoctor()
        } else {
            presentor?.searchTapped(query: tfQuerySearchDoctor.text ?? "")
        }
    }
}

// MARK: - UIPicker
extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerSpecialization {
            return presentor?.getSpecializationData().count ?? 0
        } else {
            return presentor?.getHospitalData().count ?? 0
        }
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerSpecialization {
            return presentor?.getSpecializationData()[row]
        } else {
            return presentor?.getHospitalData()[row]
        }
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            if pickerView == pickerSpecialization {
                tfSearchBySpecialization.text = presentor?.getSpecializationData()[row]
            } else {
                tfSearchByRS.text = presentor?.getHospitalData()[row]
            }
            onSuccessRetrieveDoctor()
        } else {
            if pickerView == pickerSpecialization {
                tfSearchBySpecialization.text = presentor?.getSpecializationData()[row]
                presentor?.searchBySpecialization(query: presentor?.getSpecializationData()[row] ?? "")
            } else {
                tfSearchByRS.text = presentor?.getHospitalData()[row]
                presentor?.searchByHospital(query: presentor?.getHospitalData()[row] ?? "")
            }
        }
    }
}

// MARK: - View
extension HomeViewController: HomeView {
    func setupDelegation() {
        tfSearchByRS.inputView = pickerHospital
        tfSearchBySpecialization.inputView = pickerSpecialization
        pickerHospital.delegate = self
        pickerSpecialization.delegate = self
    }
    
    func onSuccessRetrieveDoctor() {
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
        presentor?.getSpecialization()
        presentor?.getHospital()
        svListDoctor.removeAllSubviews()
        if let doctors = presentor?.getData() {
            for doctor in doctors {
                if let view = ListDoctorView.instanceFromNib() {
                    view.heightAnchor.constraint(equalToConstant: 130).isActive = true
                    view.doctorModel = doctor
                    view.updateUI()
                    svListDoctor.addArrangedSubview(view)
                }
            }
        }
    }
    
    func onFailedRetrieveDoctor(message: String) {
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
        showAlert(message: message)
    }
    
    func onLoadingRetrieve() {
        loadingIndicator.startAnimating()
        loadingIndicator.isHidden = false
    }
    
    func onDoneRetrieveByQuery() {
        svListDoctor.removeAllSubviews()
        if let doctors = presentor?.getDataByQuery() {
            for doctor in doctors {
                if let view = ListDoctorView.instanceFromNib() {
                    view.heightAnchor.constraint(equalToConstant: 100).isActive = true
                    view.doctorModel = doctor
                    view.updateUI()
                    svListDoctor.addArrangedSubview(view)
                }
            }
        }
    }
    
    func showAlert(message: String) {
        let dialogMessage = UIAlertController(title: "Confirm", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
}
