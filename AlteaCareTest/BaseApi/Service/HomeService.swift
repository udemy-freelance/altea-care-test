//
//  HomeService.swift
//  AlteaCareTest
//
//  Created by Dicky Geraldi on 19/11/22.
//


protocol IHomeService: AnyObject {
    func requestDoctorList(onComplete: @escaping ([[String: Any]]) -> Void, onError: @escaping (Error) -> Void)
}

class HomeService: IHomeService {
    func requestDoctorList(onComplete: @escaping ([[String : Any]]) -> Void, onError: @escaping (Error) -> Void) {
        BaseAPIService
            .request(BaseRouter.getDoctorData,
                     completion: { data in
                        if let data = data {
                            if let card = data["data"] as? [[String: Any]] {
                                onComplete(card)
                            }
                        }
                    },
                    onError: { error in
                        onError(error)
                    }
            )
    }
}

