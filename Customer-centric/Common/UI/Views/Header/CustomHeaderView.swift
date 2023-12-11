//
//  CustomHeaderView.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 30/11/23.
//

import UIKit

class CustomHeaderView: UIView {

    private let xibName = "CustomHeaderView"
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelWelcome: UILabel!
    @IBOutlet weak var viewContainerButtonBack: UIView!
    
    @IBOutlet var contentView: UIView!

    var isReturn: Bool = false {
        didSet {
            labelName.isHidden = isReturn
            labelWelcome.isHidden = isReturn
            viewContainerButtonBack.isHidden = !isReturn
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
  
        labelName.text = Constants.Strings.Header.hello
        labelWelcome.text = Constants.Strings.Header.welcomeToMyApp
        buttonBack.setTitle(Constants.Strings.Header.returntext, for: .normal)
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 16
        contentView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        self.backgroundColor = .clear
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func buttonBackAction(_ sender: UIButton) {
        if UIViewController.returnPresentedViewController().navigationController != nil, UIViewController.returnPresentedViewController().presentingViewController == nil {
            UIViewController.returnPresentedViewController().navigationController!.popViewController(animated: true)
        } else {
            UIViewController.returnPresentedViewController().dismiss(animated: true)
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
        contentView.prepareForInterfaceBuilder()
    }
}


