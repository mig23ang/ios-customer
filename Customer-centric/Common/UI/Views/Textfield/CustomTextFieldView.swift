//
//  CustomTextFieldView.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 29/11/23.
//

import UIKit

class CustomTextFieldView: UIView {

    private let xibName = "CustomTextFieldView"
    
    @IBOutlet weak var constrainRightTextfield: NSLayoutConstraint!
    @IBOutlet weak var viewContainerErrorLabel: UIView!
    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var viewContainerTextfield: UIView!
    @IBOutlet var contentView: UIView!
    
    var errorMessage: String? {
        didSet {
            labelError.text = "\(errorMessage ?? "")"
            viewContainerTextfield.layer.borderColor = errorMessage?.isEmpty ?? true ? UIColor.gray.cgColor : UIColor(named: "redError")!.cgColor
            viewContainerErrorLabel.isHidden = errorMessage?.isEmpty ?? true
        }
    }
    
    var isIconRight: Bool = false {
        didSet {
            constrainRightTextfield.constant = isIconRight ? 50 : 23
        }
    }

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
        
        viewContainerTextfield.layer.borderWidth = 1.0
        viewContainerTextfield.layer.borderColor = UIColor(named: "secondaryGray")!.cgColor
        viewContainerTextfield.layer.cornerRadius = 26
        
        viewContainerErrorLabel.isHidden = true
        self.backgroundColor = .clear
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

