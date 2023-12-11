//
//  EmptySearchResultView.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 8/12/23.
//

import Foundation
import UIKit

class EmptySearchResultView: UIView {

    private let xibName = "EmptySearchResultView"
    
    @IBOutlet weak var buttonTryAgain: UIButton!
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var labelTitleContent: UILabel!
    @IBOutlet var contentView: UIView!
    
    var onTapTryAgainButton: ()->() = {}

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        Bundle.main.loadNibNamed(xibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        _ = NSLayoutConstraint.pinningEdges(view: contentView, toView: self)
        
        labelTitleContent.text = Constants.Strings.EmptySearchResult.title
        labelMessage.text = Constants.Strings.EmptySearchResult.message
        buttonTryAgain.setTitle(Constants.Strings.EmptySearchResult.tryAgain, for: .normal)
        buttonTryAgain.layer.cornerRadius = 25
    }
    
    @IBAction func buttonTryAgainAction(_ sender: UIButton) {
        onTapTryAgainButton()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
        contentView.prepareForInterfaceBuilder()
    }
}


