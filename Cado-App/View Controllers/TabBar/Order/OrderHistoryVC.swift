//
//  OrderHistoryVC.swift
//  Cado-App
//
//  Created by Saim on 05/10/2023.
//

import UIKit

class OrderHistoryVC: UIViewController {
    static let tabbarIndex = 2

    @IBOutlet var orderHistoryTblView: UITableView!
    
    private let orderManager = OrderManager()
    
    private var orderList: [Order] = []
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "Orders"
        
        let loggedInUserId = LoggedUser.getLoggedInUserId()!
        self.orderList = orderManager.getAll(byUserId: loggedInUserId)
        
        if self.orderList.isEmpty {
            orderHistoryTblView.isHidden = true
        }
        else {
            orderHistoryTblView.isHidden = false
            orderHistoryTblView.reloadData()
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        orderHistoryTblView.dataSource  = self
        orderHistoryTblView.delegate    = self
    }
}

extension OrderHistoryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderHistoryTblCell.storyboardIdentifier) as! OrderHistoryTblCell
        let order = orderList[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        
        let formattedDate = dateFormatter.string(from: order.date)
        
        cell.orderIdLbl.text = "Order #\(order.id)"
        cell.orderDateLbl.text = formattedDate
        cell.orderStatusLbl.text = order.status.rawValue
        
        return cell
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
