//
//  FactoryFooterLoader.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 11/12/23.
//

import Foundation
import UIKit

class FactoryFooterLoader {

    static func createFooterLoader(for tableView: UITableView) -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 50))
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }

    static func showLoader(in tableView: UITableView) {
        DispatchQueue.main.async {
            tableView.tableFooterView = createFooterLoader(for: tableView)
        }
    }

    static func hideLoader(in tableView: UITableView) {
        DispatchQueue.main.async {
            tableView.tableFooterView = nil
        }
    }
}
