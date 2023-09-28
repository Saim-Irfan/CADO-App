//
//  RegisterVC.swift
//  Cado-App
//
//  Created by Saim on 22/09/2023.
//

import UIKit

class RegisterVC: UIViewController {
    static let storyboardIdentifier = "registerVC"
    
    @IBOutlet var mainErrorLabel: UILabel!
    
    @IBOutlet var firstNameTxtField: CustomTextField!
    @IBOutlet var firstNameErrorLabel: UILabel!
    
    @IBOutlet var lastNameTxtField: CustomTextField!
    @IBOutlet var lastNameErrorLabel: UILabel!
    
    @IBOutlet var emailTxtField: CustomTextField!
    @IBOutlet var emailErrorLabel: UILabel!
    
    @IBOutlet var passwordTxtField: CustomTextField!
    @IBOutlet var passwordErrorLabel: UILabel!
    
    @IBOutlet var dobTxtField: CustomTextField!
    @IBOutlet var calenderView: UIView!
    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet var femaleRadioBtn: RadioButton!
    @IBOutlet var maleRadioBtn: RadioButton!
    
    @IBOutlet var countryTxtField: CustomTextField!
    @IBOutlet var countryTableView: UITableView!
    
    @IBOutlet var termsRadioBtn: RadioButton!
    
    @IBOutlet var registerBtn: PrimaryButton!
    
    @IBOutlet var toSignInLbl: UILabel!
    
    private var selectedDateOfBirth: Date? = nil
    private var gender: Gender? = nil
    private var agreeOnTerms: Bool = false
    private let countryList = ["United Kingdom", "Pakistan", "UAE"]
    
    let userManager = UserManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryTableView.dataSource = self
        countryTableView.delegate = self
        
        configureTextFieldDelegates()
        
        registerBtn.setDisabled()
        
        configureToSignInLbl()
    }
    
    func checkValidation() {
        registerBtn.setDisabled()
        
        let isFirstNameValid    = firstNameErrorLabel.isHidden
        let isLastNameValid     = lastNameErrorLabel.isHidden
        let isEmailValid        = emailErrorLabel.isHidden
        let isPasswordValid     = passwordErrorLabel.isHidden
        let isCountryValid      = !countryTxtField.text!.isEmpty
        
        
        if !isFirstNameValid || !isLastNameValid || !isEmailValid || !isPasswordValid || !isCountryValid || !agreeOnTerms {
            return
        }
        
        guard let _ = selectedDateOfBirth else {
            return
        }
        
        guard let _ = gender else {
            return
        }
        
        registerBtn.setEnabled()
    }
    
    func configureTextFieldDelegates() {
        firstNameTxtField.delegate  = self
        lastNameTxtField.delegate   = self
        emailTxtField.delegate      = self
        passwordTxtField.delegate   = self
    }
    
    func configureToSignInLbl() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toLoginScreen))
        
        toSignInLbl.isUserInteractionEnabled = true
        toSignInLbl.addGestureRecognizer(tapGesture)
    }
    
    @objc func toLoginScreen() {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: LoginVC.storyboardIdentifier) as! LoginVC
        
        if var viewControllers = navigationController?.viewControllers {
            viewControllers.removeLast()
            viewControllers.append(loginVC)
            navigationController?.setViewControllers(viewControllers, animated: true)
        }
    }
    
    @IBAction func firstNameChanged(_ sender: CustomTextField) {
        guard let firstName = sender.text, firstName.isEmpty == false else {
            firstNameErrorLabel.showWarningLabel(text: "The first name field should not be empty")
            sender.setAsInvalid()
            
            checkValidation()
            return
        }
        
        firstNameErrorLabel.hideLabel()
        sender.setAsValid()
        
//        checkValidation()
    }
    
    @IBAction func lastNameChanged(_ sender: CustomTextField) {
        guard let lastName = sender.text, lastName.isEmpty == false else {
            lastNameErrorLabel.showWarningLabel(text: "The last name field should not be empty")
            sender.setAsInvalid()
            
//            checkValidation()
            return
        }
        
        lastNameErrorLabel.hideLabel()
        sender.setAsValid()
        
//        checkValidation()
    }
    
    @IBAction func emailChanged(_ sender: CustomTextField) {
        
        guard let email = sender.text, email.isEmpty == false else {
            emailErrorLabel.showWarningLabel(text: "The email field should not be empty")
            sender.setAsInvalid()
            
//            checkValidation()
            return
        }
        
        if validate(email: email) == false {
            emailErrorLabel.showWarningLabel(text: "Email format is invalid")
            sender.setAsInvalid()
            
//            checkValidation()
            return
        }
        
        emailErrorLabel.hideLabel()
        sender.setAsValid()
        
//        checkValidation()
    }
    
    private func validate(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailPred.evaluate(with: email)
    }
    
    @IBAction func passwordChanged(_ sender: CustomTextField) {
        guard let password = sender.text, password.isEmpty == false else {
            passwordErrorLabel.showWarningLabel(text: "The password field cannot be empty")
            sender.setAsInvalid()
            
//            checkValidation()
            return
        }
        
        if validate(password: password) == false {
            passwordErrorLabel.showWarningLabel(text: "The password must contain atleast 6 characters including UPPER CASE, lower case and numbers")
            sender.setAsInvalid()
            
//            checkValidation()
            return
        }
        
        passwordErrorLabel.hideLabel()
        sender.setAsValid()
        
//        checkValidation()
    }
    
    func validate(password: String) -> Bool {
        let passwordRegEx = "(?=.*[A-Z])(?=.*[a-z])(?=.*\\d).{6,}"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        
        return passwordPred.evaluate(with: password)
    }
    
    
    @IBAction func dateDoneBtnTapped(_ sender: UIBarButtonItem) {
        let date = datePicker.date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        
        let formattedDate = dateFormatter.string(from: date)
        
        dobTxtField.text = formattedDate
        selectedDateOfBirth = date
        
        calenderView.isHidden = true
        dobTxtField.resignFirstResponder()
        
        checkValidation()
    }
    
    
    @IBAction func dobChanged(_ sender: CustomTextField) {
        calenderView.isHidden = false
        dobTxtField.endEditing(true)
        
        checkValidation()
    }
    
    @IBAction func femaleRadioTapped(_ sender: Any) {
        gender = .female
        femaleRadioBtn.setAsEnabled()
        maleRadioBtn.setAsDisabled()
        
        checkValidation()
    }
    
    @IBAction func maleRadioTapped(_ sender: Any) {
        gender = .male
        maleRadioBtn.setAsEnabled()
        femaleRadioBtn.setAsDisabled()
        
        checkValidation()
    }
    
    @IBAction func countryChanged(_ sender: CustomTextField) {
        countryTableView.isHidden = false
        countryTxtField.endEditing(true)
        
        checkValidation()
    }
    
    
    @IBAction func termsRadioTapped(_ sender: Any) {
        if agreeOnTerms {
            termsRadioBtn.setAsDisabled()
        }
        else {
            termsRadioBtn.setAsEnabled()
        }
        
        agreeOnTerms = !agreeOnTerms
        
        checkValidation()
    }
    
    
    @IBAction func registerBtnTapped(_ sender: Any) {
        let firstName = firstNameTxtField.text!
        let lastName = lastNameTxtField.text!
        let email = emailTxtField.text!
        let password = passwordTxtField.text!
        let date = selectedDateOfBirth!
        let gender = gender!
        let country = countryTxtField.text!
        
        if userManager.findBy(email: email) != nil {
            mainErrorLabel.showWarningLabel(text: "The user with this email already exists")
            return
        }
        else {
            mainErrorLabel.hideLabel()
        }
        
        
        userManager.create(User(firstName: firstName, lastName: lastName, email: email, password: password, dob: date, gender: gender, country: country))
        
        toLoginScreen()
    }
}

extension RegisterVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkValidation()
    }
}

extension RegisterVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell")!
        
        cell.textLabel?.text = countryList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry = countryList[indexPath.row]
        countryTxtField.text = selectedCountry
        
        countryTableView.isHidden = true
    }
}
