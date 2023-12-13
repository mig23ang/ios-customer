//
//  SearchResultViewController.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 11/12/23.
//

import UIKit
import Combine

class SearchResultViewController: BaseViewController {

    @IBOutlet weak var viewLine2: UIView!
    @IBOutlet weak var viewContainerFilters: UIView!
    @IBOutlet weak var viewLine1: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonFilterAZ: UIButton!
    @IBOutlet weak var viewContainerButtonFilterAZ: UIView!
    @IBOutlet weak var buttonSearch: UIButton!
    @IBOutlet weak var textfieldSearch: UITextField!
    @IBOutlet weak var viewContainerTextfield: UIView!
    @IBOutlet weak var labelResultsTo: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewTitleResult: CustomCardView!
    @IBOutlet weak var viewHeader: CustomHeaderView!
    
    var viewModel : SearchResultViewModel!
    
    // preferable to keep different sets of AnyCancellable in your ViewModels and ViewControllers. This respects the single responsibility principle and ensures that subscriptions are appropriately managed based on the lifecycle of each component.
    private var cancellables = Set<AnyCancellable>()
    
    var emptyView: EmptySearchResultView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        prepareView()
    }

    @IBAction func buttonSearchAction(_ sender: UIButton) {
        
        guard let text = textfieldSearch.text else {
            return
        }
        
        view.endEditing(true)
        viewModel.resetSearch()
        FactoryLoader.createCustomLoader(inView: UIViewController.returnRootViewController().view)
        viewModel.searchByName(name: text)
    }
    
    @IBAction func buttonFilterAZAction(_ sender: UIButton) {
        if viewModel.isSortedAscending {
            //Order Z-A
            viewModel.sortClients(clients: &viewModel.clients, ascending: true)
        }else{
            //Order A-Z
            viewModel.sortClients(clients: &viewModel.clients, ascending: false)
        }
        viewModel.isSortedAscending.toggle()
        tableView.reloadData()
        updateSortButtonAppearance()
    }
    
    func updateSortButtonAppearance() {
        if viewModel.isSortedAscending {
            buttonFilterAZ.setTitle("Z - A      ", for: .normal)
        } else {
            buttonFilterAZ.setTitle("A - Z      ", for: .normal)
        }
    }
    
    private func makeConnection() {
        viewModel.$searchResponse
            .sink { [weak self] searchResponse in
                
                guard let strongSelf = self, let searchResponse = searchResponse else {
                    return
                }
                strongSelf.labelResultsTo.text = String(format: Constants.Strings.Controllers.SearchResult.resultsFoundsTo, strongSelf.viewModel.textToSearch, searchResponse.totalClientes)
                FactoryFooterLoader.hideLoader(in: strongSelf.tableView)
                FactoryLoader.removeCustomLoader(fromView: UIViewController.returnRootViewController().view)
            }
            .store(in: &cancellables)

        viewModel.$clients
            .sink { [weak self] clients in
                
                guard let strongSelf = self else {
                    return
                }
                FactoryFooterLoader.hideLoader(in: strongSelf.tableView)
                FactoryLoader.removeCustomLoader(fromView: UIViewController.returnRootViewController().view)
                if clients.isEmpty {
                    strongSelf.setupEmptyView(show: true)
                    return
                }
                strongSelf.setupEmptyView(show: false)
                strongSelf.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .sink { [weak self] errorMessage in
                guard let strongSelf = self else {
                    return
                }
                FactoryFooterLoader.hideLoader(in: strongSelf.tableView)
                FactoryLoader.removeCustomLoader(fromView: UIViewController.returnRootViewController().view)
                if let errorMessage = errorMessage {
                    Toast(
                        text: errorMessage,
                        container: nil,
                        viewController: strongSelf,
                        direction: .bottom,
                        shouldAddExtraBottomMargin: true
                    )
                }
            }
            .store(in: &cancellables)
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

extension SearchResultViewController {
    func prepareView() {
        viewHeader.isReturn = true
        
        viewTitleResult.typeContent = .title
        viewTitleResult.typeImageBackground = .yellowOffShadow
        viewTitleResult.labelContent.text = Constants.Strings.Controllers.SearchByName.comprehensiveClient
        viewTitleResult.isShowArrow = false
        
        tableView.register(cell: SearchClientTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        
        makeConnection()
        prepareViewFromType()
    }
    
    private func prepareViewFromType() {
        switch viewModel.typeFilter {
        case .documentNumber:
            viewLine1.isHidden = true
            viewLine2.isHidden = true
            viewContainerTextfield.isHidden = true
            viewContainerFilters.isHidden = true
            labelResultsTo.text = String(format: Constants.Strings.Controllers.SearchResult.resultFounds, 1)
        case .name:
            viewContainer.layer.borderWidth = 1
            viewContainer.layer.borderColor = UIColor.separator.cgColor
            viewContainer.layer.cornerRadius = 15
            
            viewContainerTextfield.layer.borderWidth = 1
            viewContainerTextfield.layer.borderColor = UIColor(named: "secondaryGray")!.cgColor
            viewContainerTextfield.layer.cornerRadius = 19
            textfieldSearch.placeholder = Constants.Strings.Controllers.SearchByName.exampleNumberDocument
            
            viewContainerButtonFilterAZ.layer.borderColor = UIColor(named: "secondaryGray")!.cgColor
            viewContainerButtonFilterAZ.layer.borderWidth = 1
            viewContainerButtonFilterAZ.layer.cornerRadius = 21.5
            labelResultsTo.text = String(format: Constants.Strings.Controllers.SearchResult.resultsFoundsTo, viewModel.textToSearch, viewModel.searchResponse?.totalClientes ?? 0)
        case .none:
            break
        }
    }
}


extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.clients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: SearchClientTableViewCell.self, for: indexPath)
        let client = viewModel.clients[indexPath.row]
        cell.labelDocument.text = "\(client.tipoDocumento): \(client.numeroDocumento)"
        cell.labelNameClient.text = client.nombreCompleto
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let client = viewModel.clients[indexPath.row]
        let viewModelDetailClient = DetailClientViewModel()
        viewModelDetailClient.client = client
        
        let vc = DetailClientViewController()
        vc.viewModel = viewModelDetailClient
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchResultViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            guard !viewModel.isLoading else { return }
            
            FactoryFooterLoader.showLoader(in: tableView)
            viewModel.loadMoreResults()
        }
    }
}
