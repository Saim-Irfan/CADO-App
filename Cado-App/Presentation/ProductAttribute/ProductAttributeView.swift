//
//  ProductAttributeView.swift
//  Cado-App
//
//  Created by Saim on 10/10/2023.
//

import UIKit

class ProductAttributeView: UIView {
    @IBOutlet var attributeLbl: UILabel!
    @IBOutlet var attributeSelectionTxtField: UITextField!
    
    private let picker = UIPickerView()
    

    var attributeItemList: [AttributeItem] = []
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    func commonInit() {
        let viewFromXib = Bundle.main.loadNibNamed(String(describing: ProductAttributeView.self), owner: self, options: nil)![0] as! UIView
        
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        
        attributeSelectionTxtField.inputView = picker
        
        
        picker.delegate     = self
        picker.dataSource   = self
    }
    
    
    func configure(title: String, attributeItemList: [AttributeItem]) {
        attributeLbl.text = title
        attributeSelectionTxtField.placeholder = "Select \(title)"
        
        self.attributeItemList = attributeItemList
        picker.reloadAllComponents()
    }
}




extension ProductAttributeView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        attributeSelectionTxtField.text = attributeItemList[row].value
        attributeSelectionTxtField.resignFirstResponder()
    }
}

extension ProductAttributeView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        attributeItemList.count
    }
      
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return attributeItemList[row].value
    }
}
