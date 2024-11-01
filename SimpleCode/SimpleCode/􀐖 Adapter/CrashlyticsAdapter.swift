//
//  CrashlyticsAdapter.swift
//  FluxSwift
//
//  Created by ShuZik on 23.03.2024.
//
//  For future...

/*
import FirebaseCrashlytics
import Foundation

final class CrashlyticsAdapter {
    private static let sharedInstance = CrashlyticsAdapter()
    private let crashlytics: Crashlytics

    private init(crashlytics: Crashlytics = Crashlytics.crashlytics()) {
        FirebaseAdapter.setup()
        self.crashlytics = crashlytics
    }

    // MARK: - Public

    static var shared: CrashlyticsAdapter {
        return sharedInstance
    }

    func signUser(id: String) {
        crashlytics.setUserID(id)
    }

    func signOutUser() {
        crashlytics.setUserID(" ")
    }

    func didCrash(_ error: Error) {
        crashlytics.record(error: error)
    }

    func sendUnsentReports() {
        crashlytics.sendUnsentReports()
    }
}
*/
