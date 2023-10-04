//
//  AddAddressVC.swift
//  Cado-App
//
//  Created by Saim on 04/10/2023.
//

import UIKit

class AddAddressVC: UIViewController {
    static let storyboardIdentifier = "addAddressVC"

    @IBOutlet var firstNameTxtField: CustomTextField!
    @IBOutlet var lastNameTxtField: CustomTextField!
    @IBOutlet var mobileTxtField: CustomTextField!
    @IBOutlet var streetNameTxtField: CustomTextField!
    @IBOutlet var residenceTxtField: CustomTextField!
    
    @IBOutlet var cityTxtField: CustomTextField!
    @IBOutlet var cityTableView: UITableView!
    
    @IBOutlet var instructionTxtView: UITextView!
    
    
    private let addressManager = RecipientAddressManager()
    
    private let availableCities = ["Dubai", "Al Ain", "Abu Dhabi", "Ajman", "Sharjah"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cityTableView.layer.borderWidth = 0.5
        cityTableView.dataSource = self
        cityTableView.delegate = self
    }
    
    

    @IBAction func cityFieldEditingDidBegine(_ sender: CustomTextField) {
        cityTableView.isHidden = false
        sender.endEditing(true)
    }
    
    
    @IBAction func addAddressBtnTapped(_ sender: Any) {
        if validateFields() == false {
            return
        }
        
        let loggedInUserId = LoggedUser.getLoggedInUserId()!
        
        let newAddress = RecipientAddress(userId: loggedInUserId, firstName: firstNameTxtField.text!, lastName: lastNameTxtField.text!, mobileNumber: mobileTxtField.text!, street: streetNameTxtField.text!, residence: residenceTxtField.text!, city: cityTxtField.text!, instruction: instructionTxtView.text!)
        
        addressManager.create(newAddress)
        
        navigationController?.popViewController(animated: true)
    }
    
    
    func validateFields() -> Bool {
        var areFieldsValidated = true
        
        firstNameTxtField.setAsValid()
        lastNameTxtField.setAsValid()
        mobileTxtField.setAsValid()
        streetNameTxtField.setAsValid()
        residenceTxtField.setAsValid()
        cityTxtField.setAsValid()
        
        if firstNameTxtField.text!.isEmpty {
            firstNameTxtField.setAsInvalid()
            areFieldsValidated = false
        }
        
        if lastNameTxtField.text!.isEmpty {
            lastNameTxtField.setAsInvalid()
            areFieldsValidated = false
        }
        
        if mobileTxtField.text!.isEmpty {
            mobileTxtField.setAsInvalid()
            areFieldsValidated = false
        }
        
        if streetNameTxtField.text!.isEmpty {
            streetNameTxtField.setAsInvalid()
            areFieldsValidated = false
        }
        
        if residenceTxtField.text!.isEmpty {
            residenceTxtField.setAsInvalid()
            areFieldsValidated = false
        }
        
        if cityTxtField.text!.isEmpty {
            cityTxtField.setAsInvalid()
            areFieldsValidated = false
        }

        return areFieldsValidated
    }
    
}


extension AddAddressVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        availableCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityTblViewCell")!
        
        cell.textLabel?.text = availableCities[indexPath.row]
        
        return cell
    }
}


extension AddAddressVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cityTxtField.text = availableCities[indexPath.row]
        cityTableView.isHidden = true
    }
}
