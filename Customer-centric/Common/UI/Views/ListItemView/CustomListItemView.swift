//
//  CustomListItemView.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 12/12/23.
//

import Foundation
import UIKit

class CustomListItemView: UIView {

    private let xibName = "CustomListItemView"
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var labelTitleContent: UILabel!
    
    var onTapContent: (Int)->() = { _ in }
    
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

        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        onTapContent(tag)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
        contentView.prepareForInterfaceBuilder()
    }
}


