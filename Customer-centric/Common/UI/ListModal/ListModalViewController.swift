//
//  ListModalViewController.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 27/11/23.
//

import Foundation
import UIKit

class ListModalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView = UITableView()
    private let items: [ListModal]
    private let titleText: String
    var onItemSelected: ((ListModal) -> Void)?
    
    init(titleText: String, items: [ListModal]) {
        self.titleText = titleText
        self.items = items
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        titleLabel.text = titleText
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .white

        tableView.frame = CGRect(x: 0, y: titleLabel.frame.height, width: 300, height: 350)
        tableView.backgroundColor = .white

 
        let containerView = UIView(frame: CGRect(
            x: (view.bounds.width - 300) / 2,
            y: (view.bounds.height - 400) / 2,
            width: 300,
            height: 400
        ))
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true
        containerView.addSubview(titleLabel)
        containerView.addSubview(tableView)

        view.addSubview(containerView)

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        // Calculate total height of cells and adjust size of container and tableView
         let totalRowsHeight = CGFloat(items.count * 44) // Assuming each cell height is 44
         let maxTableViewHeight: CGFloat = 350 // Max height for tableView
         let actualTableViewHeight = min(totalRowsHeight, maxTableViewHeight) // Use the smaller value
         let bottomMargin: CGFloat = 30 // Bottom margin

        let separatorView = UIView(frame: CGRect(x: 0, y: titleLabel.frame.maxY, width: 300, height: 1))
        separatorView.backgroundColor = .gray // o el color que prefieras para la línea
        containerView.addSubview(separatorView)
        
        tableView.frame = CGRect(x: 0, y: titleLabel.frame.maxY + 1 + 10, width: 300, height: actualTableViewHeight)

        containerView.frame = CGRect(
            x: (view.bounds.width - 300) / 2,
            y: (view.bounds.height - (titleLabel.frame.height + actualTableViewHeight + bottomMargin)) / 2,
            width: 300,
            height: titleLabel.frame.height + actualTableViewHeight + bottomMargin
        )
        
        tableView.separatorInset = .zero
        tableView.layoutMargins = .zero

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "   \(items[indexPath.row].name)"
        
        // Remove the separator for the last item
        if indexPath.row == items.count - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        } else {
            cell.separatorInset = .zero
        }
        cell.selectionStyle = .none
        return cell
    }
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.row]
        onItemSelected?(selectedItem)
        dismiss(animated: true, completion: nil)
    }
}

struct ListModal {
    let name : String
    let value : String
}
