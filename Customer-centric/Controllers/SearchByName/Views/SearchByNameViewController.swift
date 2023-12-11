//
//  SearchByNameViewController.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 4/12/23.
//

import UIKit

class SearchByNameViewController: BaseViewController {

    @IBOutlet weak var viewCustomTextfieldChooseDigitVerification: CustomTextFieldView!
    @IBOutlet weak var labelChooseDigitVerification: UILabel!
    @IBOutlet weak var buttonArrowDownSelectDigitVerification: UIButton!
    @IBOutlet weak var buttonArrowDownSelectTypeDocument: UIButton!
    @IBOutlet weak var viewCustomTextfieldSearchByDocument: CustomTextFieldView!
    @IBOutlet weak var labelNumberDocument: UILabel!
    @IBOutlet weak var labelSearchNumberDocumentClient: UILabel!
    @IBOutlet weak var viewCustomTextfieldSelectDocument: CustomTextFieldView!
    @IBOutlet weak var labelSelectTypeDocument: UILabel!
    @IBOutlet weak var stackViewSearchByDocument: UIStackView!
    @IBOutlet weak var stackViewSearchByName: UIStackView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewHeader: CustomHeaderView!
    @IBOutlet weak var buttonSearchLens: UIButton!
    @IBOutlet weak var buttonClean: UIButton!
    @IBOutlet weak var buttonSearch: UIButton!
    @IBOutlet weak var viewCustomTextfieldSearch: CustomTextFieldView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDescriptionSearch: UILabel!
    @IBOutlet weak var viewTitleClient: CustomCardView!
    
    @IBOutlet weak var buttonDocument: UIButton!
    @IBOutlet weak var buttonName: UIButton!
    
    let indicatorView = UIView()
    
    var filterType : FilterSearchByName = .name
    
    var emptyView: EmptySearchResultView!
    
    enum FilterSearchByName {
        case name
        case documentNumber
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        prepareView()
    }

    @IBAction func buttonNameOrSocialReasonAction(_ sender: UIButton) {
        buttonName.select()
        buttonDocument.deselect()
        positionIndicator(under: buttonName)
        filterType = .name
        stackViewSearchByName.isHidden = false
        stackViewSearchByDocument.isHidden = true
        viewCustomTextfieldSelectDocument.textfield.text = nil
        viewCustomTextfieldChooseDigitVerification.textfield.text = nil
        viewCustomTextfieldSearchByDocument.textfield.text = nil
        view.endEditing(true)
    }
    
    @IBAction func buttonTypeDocumentAction(_ sender: UIButton) {
        buttonName.deselect()
        buttonDocument.select()
        positionIndicator(under: buttonDocument)
        filterType = .documentNumber
        stackViewSearchByName.isHidden = true
        stackViewSearchByDocument.isHidden = false
        viewCustomTextfieldSearch.textfield.text = nil
        view.endEditing(true)
    }
    
    @IBAction func buttonArrowDownSelectTypeDocumentAction(_ sender: UIButton) {
        openListModalSelectDocument()
    }
    
    @IBAction func buttonArrowDownSelectDigitVerificationAction(_ sender: UIButton) {
        openListModalSelectDigitVerification()
    }
    
    @IBAction func buttonLensSearchAction(_ sender: UIButton) {
    }
    
    @IBAction func buttonCleanAction(_ sender: UIButton) {
        viewCustomTextfieldSearch.textfield.text = nil
        viewCustomTextfieldSelectDocument.textfield.text = nil
        viewCustomTextfieldChooseDigitVerification.textfield.text = nil
        viewCustomTextfieldSearchByDocument.textfield.text = nil
        view.endEditing(true)
    }
    
    @IBAction func buttonSearchAction(_ sender: UIButton) {
        view.endEditing(true)
        guard validateTextFields() else {
            return
        }
        
        setupEmptyView(show: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        indicatorView.alpha = 0
        indicatorView.backgroundColor = UIColor(named: "gradientGreen")
        viewContainer.addSubview(indicatorView)
        positionIndicator(under: buttonName)
    }
    
    private func setupEmptyView(show: Bool) {
        if show {
            if self.emptyView == nil {
                self.emptyView = EmptySearchResultView()
                self.view.addSubview(self.emptyView)
                emptyView.pinToSuperview(forAtrributes: [.leading, .trailing, .bottom])
                emptyView.pin(attribute: .top, toView: viewHeader, toAttribute: .bottom)
                emptyView.onTapTryAgainButton = {
                    self.setupEmptyView(show: false)
                }
            }
        } else {
            if self.emptyView != nil {
                self.emptyView.removeFromSuperview()
                self.emptyView = nil
            }
        }
    }
}

extension SearchByNameViewController {
    func prepareView() {
        viewTitleClient.labelContent.text = Constants.Strings.Controllers.SearchByName.comprehensiveClient
        viewTitleClient.typeImageBackground = .yellowOffShadow
        viewTitleClient.typeContent = .title
        viewTitleClient.isShowArrow = false
        
        //configure search by name
        viewCustomTextfieldSearch.isIconRight = true
        viewCustomTextfieldSearch.textfield.placeholder = Constants.Strings.Controllers.SearchByName.searchByNameOrSocialReason
        labelName.text = Constants.Strings.Controllers.SearchByName.nameAndLastNameOrSocialReason
        viewCustomTextfieldSearch.bringSubviewToFront(buttonSearchLens)
        
        //configure search by document
        
        viewCustomTextfieldSelectDocument.isIconRight = true
        viewCustomTextfieldSelectDocument.textfield.placeholder = Constants.Strings.Controllers.SearchByName.selectTypeDocument
        labelSelectTypeDocument.text = Constants.Strings.Controllers.SearchByName.chooseTypeDocumentClient
        viewCustomTextfieldSelectDocument.bringSubviewToFront(buttonArrowDownSelectTypeDocument)
        labelNumberDocument.text = Constants.Strings.Controllers.SearchByName.numberDocument
        
        viewCustomTextfieldChooseDigitVerification.isIconRight = true
        viewCustomTextfieldChooseDigitVerification.textfield.placeholder = Constants.Strings.Controllers.SearchByName.selectDigitVerification
        labelChooseDigitVerification.text = Constants.Strings.Controllers.SearchByName.chooseVerificationDigit
        viewCustomTextfieldChooseDigitVerification.bringSubviewToFront(buttonArrowDownSelectDigitVerification)
        
        viewCustomTextfieldSearchByDocument.isIconRight = false
        viewCustomTextfieldSearchByDocument.textfield.placeholder = Constants.Strings.Controllers.SearchByName.exampleNumberDocument
        labelSearchNumberDocumentClient.text = Constants.Strings.Controllers.SearchByName.searchOfNumberDocumentClient
        
        viewCustomTextfieldSearch.textfield.delegate = self
        viewCustomTextfieldSelectDocument.textfield.delegate = self
        viewCustomTextfieldChooseDigitVerification.textfield.delegate = self
        viewCustomTextfieldSearchByDocument.textfield.delegate = self
        
        buttonSearch.layer.cornerRadius = 25
        buttonClean.layer.cornerRadius = 25
        
        viewHeader.isReturn = true
        
        buttonSearch.setTitle(Constants.Strings.Controllers.SearchByName.consult, for: .normal)
        buttonClean.setTitle(Constants.Strings.Controllers.SearchByName.clean, for: .normal)
        
        buttonClean.layer.borderColor = UIColor(named: "primaryGreen")!.cgColor
        buttonClean.layer.borderWidth = 1
    }
    
    private func positionIndicator(under button: UIButton) {
        UIView.animate(withDuration: 0.3) {
            // Actualiza el marco del indicador para que coincida con el botón seleccionado
            self.indicatorView.frame = CGRect(
                x: button.frame.origin.x + 20 /*pading leading the container view*/,
                y: button.frame.maxY + 45 /*pading top the container view*/,
                width: button.frame.width,
                height: 1
            )
        } completion: { _ in
            self.indicatorView.alpha = 1
        }
    }
}

extension SearchByNameViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == viewCustomTextfieldSelectDocument.textfield {
            openListModalSelectDocument()
            view.endEditing(true)
        }else if textField == viewCustomTextfieldChooseDigitVerification.textfield {
            openListModalSelectDigitVerification()
            view.endEditing(true)
        }
    }

    private func validateTextFields() -> Bool {
        
        var isValid = true
        
        switch filterType {
        case .name:
            if let nameText = viewCustomTextfieldSearch.textfield.text,
               nameText.isBlank() {
                viewCustomTextfieldSearch.errorMessage = Constants.Strings.Controllers.SearchByName.errorName
                isValid = false
            }else {
                viewCustomTextfieldSearch.errorMessage = nil
            }
        case .documentNumber:

            if let typeDocumentText = viewCustomTextfieldSelectDocument.textfield.text,
               typeDocumentText.isBlank() {
                viewCustomTextfieldSelectDocument.errorMessage = Constants.Strings.Controllers.SearchByName.errorTypeDocument
                isValid = false
            }else {
                viewCustomTextfieldSelectDocument.errorMessage = nil
            }
            
            if let digitVerificationText = viewCustomTextfieldChooseDigitVerification.textfield.text,
               digitVerificationText.isBlank() {
                viewCustomTextfieldChooseDigitVerification.errorMessage = Constants.Strings.Controllers.SearchByName.errorDigitVerification
                isValid = false
            }else {
                viewCustomTextfieldChooseDigitVerification.errorMessage = nil
            }
            
            if let numberDocumentText = viewCustomTextfieldSearchByDocument.textfield.text,
               numberDocumentText.isBlank() {
                viewCustomTextfieldSearchByDocument.errorMessage = Constants.Strings.Controllers.SearchByName.errorDocument
                isValid = false
            }else {
                viewCustomTextfieldSearchByDocument.errorMessage = nil
            }
        }
        
        return isValid
    }
    
    private func openListModalSelectDocument() {
        let modalVC = ListModalViewController(titleText: Constants.Strings.Controllers.SearchByName.selectTypeDocument, items: Constants.typeDocumentOptions)
        modalVC.onItemSelected = { selectedItem in
            // Handle the selected item
            self.viewCustomTextfieldSelectDocument.textfield.text = selectedItem.name
        }
        self.present(modalVC, animated: true, completion: nil)
    }
    
    private func openListModalSelectDigitVerification() {
        let modalVC = ListModalViewController(titleText: Constants.Strings.Controllers.SearchByName.selectDigitVerification, items: Constants.digitVerificationOptions)
        modalVC.onItemSelected = { selectedItem in
            // Handle the selected item
            self.viewCustomTextfieldChooseDigitVerification.textfield.text = selectedItem.name
        }
        self.present(modalVC, animated: true, completion: nil)
    }
}
