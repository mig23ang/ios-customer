//
//  CollectionViewController.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 28/11/23.
//

import UIKit

class CollectionViewController: BaseViewController {

    @IBOutlet weak var viewAdvisorMuleteers: CustomCardView!
    @IBOutlet weak var viewAdvisorsPymes: CustomCardView!
    @IBOutlet weak var viewComprehensiveSheet: CustomCardView!
    @IBOutlet weak var labelMyLibrary: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        prepareView()
    }
}

extension CollectionViewController {
    func prepareView() {
        labelMyLibrary.text = Constants.Strings.Controllers.Collection.myLibrary
        
        viewComprehensiveSheet.labelContent.text = Constants.Strings.Controllers.Collection.comprehensiveSheet
        viewComprehensiveSheet.isShowArrow = true
        viewComprehensiveSheet.typeImageBackground = .blue
        viewComprehensiveSheet.typeContent = .button
        viewComprehensiveSheet.onTapContent = {
            self.navigationController?.pushViewController(SearchByNameViewController(), animated: true)
        }
        
        viewAdvisorsPymes.labelContent.text = Constants.Strings.Controllers.Collection.advisorsPymes
        viewAdvisorsPymes.isShowArrow = true
        viewAdvisorsPymes.typeImageBackground = .blue
        viewAdvisorsPymes.typeContent = .button
        
        viewAdvisorMuleteers.labelContent.text = Constants.Strings.Controllers.Collection.advisorsMuleteers
        viewAdvisorMuleteers.isShowArrow = true
        viewAdvisorMuleteers.typeImageBackground = .blue
        viewAdvisorMuleteers.typeContent = .button
    }
}
