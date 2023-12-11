//
//  HomeViewController.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 28/11/23.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var viewSustainability: CustomCardView!
    @IBOutlet weak var viewNoticeAndEvents: CustomCardView!
    @IBOutlet weak var labelSustainability: UILabel!
    @IBOutlet weak var labelNoticeAndEvents: UILabel!
    @IBOutlet weak var labelLastVisited: UILabel!
    @IBOutlet weak var viewLastVisited: CustomCardView!
    @IBOutlet weak var viewHeader: CustomHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        prepareView()
    }
}

extension HomeViewController  {
    func prepareView() {
        labelLastVisited.text = Constants.Strings.Controllers.Home.lastVisited
        viewLastVisited.labelContent.text = Constants.Strings.Controllers.Home.cardLastVisited
        viewLastVisited.isShowArrow = true
        viewLastVisited.typeImageBackground = .green
        viewLastVisited.typeContent = .button
        viewLastVisited.onTapContent = {
            self.navigationController?.pushViewController(SearchByNameViewController(), animated: true)
        }
        
        labelNoticeAndEvents.text = Constants.Strings.Controllers.Home.noticeAndEvents
        viewNoticeAndEvents.labelContent.text = Constants.Strings.Controllers.Home.cardNoticeAndEvents
        viewNoticeAndEvents.isShowArrow = false
        viewNoticeAndEvents.typeImageBackground = .blue
        viewNoticeAndEvents.typeContent = .message
        
        labelSustainability.text = Constants.Strings.Controllers.Home.sustainability
        viewSustainability.labelContent.text = Constants.Strings.Controllers.Home.cardSustainability
        viewSustainability.isShowArrow = false
        viewSustainability.typeImageBackground = .yellow
        viewSustainability.typeContent = .message
    }
}
