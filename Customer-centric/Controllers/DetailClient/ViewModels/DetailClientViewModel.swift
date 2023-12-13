//
//  DetailClientViewModel.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 12/12/23.
//

import Foundation
import Combine

class DetailClientViewModel: ObservableObject {
    
    var client: Client?
    // Add items to the stack view
    let itemTitles = [Constants.Strings.Controllers.DetailClient.basicData,
                      Constants.Strings.Controllers.DetailClient.offersAndAlerts,
                      Constants.Strings.Controllers.DetailClient.centralRisk,
                      Constants.Strings.Controllers.DetailClient.loanHistory,
                      Constants.Strings.Controllers.DetailClient.rotatingQuota,
                      Constants.Strings.Controllers.DetailClient.passives,
                      Constants.Strings.Controllers.DetailClient.contactHistory,
                      Constants.Strings.Controllers.DetailClient.PQR]
}
