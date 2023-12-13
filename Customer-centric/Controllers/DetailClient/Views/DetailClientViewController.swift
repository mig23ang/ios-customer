//
//  DetailClientViewController.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 12/12/23.
//

import UIKit

class DetailClientViewController: BaseViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var labelDocument: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var viewHeader: CustomHeaderView!
    
    var viewModel : DetailClientViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        prepareView()
    }
}

extension DetailClientViewController {
    func prepareView() {
        
        viewHeader.isReturn = true
        
        if let client = viewModel.client {
            labelDocument.text = "\(client.tipoDocumento): \(client.numeroDocumento)"
            labelName.text = client.nombreCompleto
        }
        
        for (index,title) in viewModel.itemTitles.enumerated() {
           
            let customListItemView = CustomListItemView()
            customListItemView.labelTitleContent.text = title
            customListItemView.tag = index
            customListItemView.onTapContent = { tap in
                
            }
            
            stackView.addArrangedSubview(customListItemView)
        }
    }
}
