//
//  OrderHistoryVC.swift
//  Cado-App
//
//  Created by Saim on 05/10/2023.
//

import UIKit

class OrderHistoryVC: UIViewController {
    static let tabbarIndex = 4
    
    typealias Datasource = UITableViewDiffableDataSource<Int, Int>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Int>

    
    @IBOutlet var startShoppingLbl: UILabel!
    
    @IBOutlet var orderHistoryTblView: UITableView!
    
    private let orderManager = OrderManager()
    private let searchController = UISearchController()
    
    private var datasource: Datasource!
    private var orderList: [Order] = []
    private var filteredOrderList: [Order] = []
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "Orders"
        
        let loggedInUserId = LoggedUser.getLoggedInUserId()!
        self.orderList = orderManager.getAll(byUserId: loggedInUserId)
        
        if self.orderList.isEmpty {
            orderHistoryTblView.isHidden = true
        }
        else {
            orderHistoryTblView.isHidden = false
            
            setupSearchBar()
            configureDatasource()
            applySnapshot(orderList)
            orderHistoryTblView.reloadData()
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeToHomePage))
        startShoppingLbl.isUserInteractionEnabled = true
        startShoppingLbl.addGestureRecognizer(tapGesture)
        
        orderHistoryTblView.delegate    = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.navigationItem.searchController = nil
    }
    
    func configureDatasource() {
        datasource = Datasource(tableView: orderHistoryTblView, cellProvider: { tableView, indexPath, orderId in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: OrderHistoryTblCell.storyboardIdentifier) as! OrderHistoryTblCell
            guard let order = self.orderList.first (where: { order in
                order.id == orderId
            }) else {
                return UITableViewCell()
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMM yyyy"
            
            let formattedDate = dateFormatter.string(from: order.date)
            
            cell.orderIdLbl.text = "Order #\(order.id)"
            cell.orderDateLbl.text = formattedDate
            cell.orderStatusLbl.text = order.status.rawValue
            
            return cell
        })
    }
    
    func applySnapshot(_ orderList: [Order]) {
        var snapshot = Snapshot()
        
        let sectionIdentifierList = Array(0..<orderList.count)
        snapshot.appendSections(sectionIdentifierList)
        
        for sectionIndex in sectionIdentifierList {
            snapshot.appendItems([orderList[sectionIndex].id], toSection: sectionIndex)
        }
        
        datasource.apply(snapshot)
    }
    
    func setupSearchBar() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        
        
        let offset = UIOffset(horizontal: (searchController.searchBar.frame.width - 200) / 2, vertical: 0)
        searchController.searchBar.setPositionAdjustment(offset, for: .search)
        
        searchController.searchBar.searchTextField.backgroundColor = .white
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search your orders"
        
        tabBarController?.navigationItem.hidesSearchBarWhenScrolling = false
        tabBarController?.navigationItem.searchController = searchController
    }
    
    @objc func changeToHomePage() {
        tabBarController?.selectedIndex = HomeVC.tabbarIndex
    }
}


extension OrderHistoryVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
        if searchText.isEmpty {
            applySnapshot(orderList)
        }
        else {
            let filteredFollowerList = orderList.filter {
                return $0.id.description.contains(searchText.lowercased())
            }
            
            applySnapshot(filteredFollowerList)
        }
    }
}

extension OrderHistoryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderDetailVC = storyboard?.instantiateViewController(withIdentifier: OrderDetailVC.storyboardIdentifier) as! OrderDetailVC
        
        orderDetailVC.orderId = orderList[indexPath.row].id
        
        navigationController?.pushViewController(orderDetailVC, animated: true)
    }
}
