//
//  ListDoctorView.swift
//  AlteaCareTest
//
//  Created by Dicky Geraldi on 18/11/22.
//

import UIKit

class ListDoctorView: UIView {
    
    @IBOutlet weak var lblPriceDoctor: UILabel!
    @IBOutlet weak var ivPhotoProfile: UIImageView!
    @IBOutlet weak var lblDoctorName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblSpecializationAndHospital: UILabel!

    var doctorModel: DoctorModel?

    class func instanceFromNib() -> ListDoctorView? {
        let views = UINib(nibName: "ListDoctorView", bundle: nil).instantiate(withOwner: nil, options: nil)
        if let view = views.first(where: { (vw) -> Bool in
            return vw is ListDoctorView
        }) as? ListDoctorView {
            return view
        }
        return nil
    }

    func updateUI() {
        if let data = doctorModel {
            lblPriceDoctor.text = data.price?.formatted
            ivPhotoProfile.loadImage(url: data.image?.formats?.medium)
            lblDoctorName.text = data.name
            lblSpecializationAndHospital.text = data.hospitalAndSpecialization()
            lblDesc.attributedText = data.aboutPreview?.htmlAttributedString()
            lblDesc.textColor = .black
        }
    }
}
