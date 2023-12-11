//
//  SearchViewController.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 28/11/23.
//

import UIKit

class SearchViewController: BaseViewController {

    @IBOutlet weak var buttonSearch: UIButton!
    @IBOutlet weak var viewCustomTextfieldSearch: CustomTextFieldView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        prepareView()
    }

    @IBAction func buttonSearchAction(_ sender: UIButton) {
    }
}

extension SearchViewController {
    func prepareView() {
        viewCustomTextfieldSearch.isIconRight = true
        viewCustomTextfieldSearch.textfield.placeholder = Constants.Strings.Controllers.Search.doYourSearch
        viewCustomTextfieldSearch.bringSubviewToFront(buttonSearch)
    }
}
