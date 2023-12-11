//
//  CustomCardView.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 30/11/23.
//

import UIKit

class CustomCardView: UIView {
    
    private let xibName = "CustomCardView"
    
    @IBOutlet weak var buttonArrow: UIButton!
    @IBOutlet weak var labelContent: UILabel!
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet var contentView: UIView!
    
    var isShowArrow: Bool = false {
        didSet {
            buttonArrow.isHidden = !isShowArrow
        }
    }
    
    var typeContent : CardType = .message {
        didSet {
            switch typeContent {
            case .message:
                labelContent.font = .systemFont(ofSize: 12, weight: .light)
                labelContent.textColor = UIColor(named: "bodyTextBlack")
            case .button:
                labelContent.font = .systemFont(ofSize: 14)
                labelContent.textColor = UIColor(named: "bodyTextBlack")
            case .title:
                labelContent.font = .systemFont(ofSize: 16, weight: .medium)
                labelContent.textColor = .black
            }
        }
    }
    
    var typeImageBackground : ImageCardType = .blue {
        didSet {
            switch typeImageBackground {
            case .green:
                imageBackground.image = UIImage(named: "cardGreen")
            case .blue:
                imageBackground.image = UIImage(named: "cardBlue")
            case .yellow:
                imageBackground.image = UIImage(named: "cardYellow")
            case .yellowOffShadow:
                imageBackground.image = UIImage(named: "cardYellowOffShadow")
            }
        }
    }
    
    var onTapContent: ()->() = {}
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        onTapContent()
    }
    
    private func setup() {
        Bundle.main.loadNibNamed(xibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        _ = NSLayoutConstraint.pinningEdges(view: contentView, toView: self)
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
    
    enum CardType {
        case message
        case button
        case title
    }
    
    enum ImageCardType {
        case green
        case blue
        case yellow
        case yellowOffShadow
    }
}


