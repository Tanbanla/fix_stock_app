//
//  ErrorCorrectionTableViewCell.swift
//  BIVN
//
//  Created by Bi on 13/1/25.
//

import UIKit
import Localize_Swift
protocol ErrorCorrectionCellDelegate: AnyObject {
    func didEditInformationDelegate()
}


class ErrorCorrectionTableViewCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var titlePartNumberLabel: UILabel!
    @IBOutlet weak var valuePartNumberLabel: UILabel!
    @IBOutlet weak var componentNameLabel: UILabel!
    @IBOutlet weak var valueComponentNameLabel: UILabel!
    @IBOutlet weak var titleStatusLabel: UILabel!
    @IBOutlet weak var valueStatusLabel: UILabel!
    @IBOutlet weak var titleAdjustLabel: UILabel!
    @IBOutlet weak var valueAdjustLabel: UITextField!
    @IBOutlet weak var textViewErrorLabel: UILabel!
    @IBOutlet weak var errorUpdateLabel: UILabel!
    
    weak var delegateValue: ErrorCorrectionCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        valueAdjustLabel.placeholder = "Nhập số lượng điều chỉnh".localized()
        valueAdjustLabel.delegate = self
        valueAdjustLabel.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange() {
        delegateValue?.didEditInformationDelegate()
        }
    func setupUI() {
        errorUpdateLabel.isHidden = true
        errorUpdateLabel.textColor = UIColor(named: R.color.textRed.name)
        errorUpdateLabel.font = UIFont.systemFont(ofSize: 12)
        textViewErrorLabel.isHidden = true
        textViewErrorLabel.textColor = UIColor(named: R.color.textRed.name)
        textViewErrorLabel.font = UIFont.systemFont(ofSize: 12)
        titlePartNumberLabel.text = "Mã linh kiện:".localized()
        componentNameLabel.text = "Tên linh kiện:".localized()
        titleStatusLabel.text = "Trạng thái:".localized()
        titleAdjustLabel.text = "Điều chỉnh:".localized()
        titlePartNumberLabel.font = fontUtils.size14.bold
        componentNameLabel.font = fontUtils.size14.bold
        titleStatusLabel.font = fontUtils.size14.bold
        titleAdjustLabel.font = fontUtils.size14.bold
        valuePartNumberLabel.font = fontUtils.size18.bold
        valueComponentNameLabel.font = fontUtils.size14.regular
        valueStatusLabel.font = fontUtils.size18.bold
        valueAdjustLabel.font = fontUtils.size12.bold
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func showError(message: String) {
        textViewErrorLabel.text = message
        textViewErrorLabel.isHidden = false
    }
    
    func showErrorTextField(message: String) {
        errorUpdateLabel.text = message
        errorUpdateLabel.isHidden = false
    }
    
    func hideErrorTextField() {
        errorUpdateLabel.isHidden = true
    }
    
    func hideError() {
        textViewErrorLabel.isHidden = true
    }
    
    func fillData(resultErrorModel: AccessoryModels) {
        valuePartNumberLabel.text = resultErrorModel.data?.componentCode
        valueComponentNameLabel.text = resultErrorModel.data?.componentName
        if let status = StatusDisplayError(rawValue: resultErrorModel.data?.status ?? 0) {
            valueStatusLabel.text = status.displayName
            valueStatusLabel.textColor = status.color
        }
    }
    
    func fillDataChange(errorInvestigationModel: ErrorInvestigationModel?) {
        valueAdjustLabel.text = errorInvestigationModel?.errorQuantity
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn: "0123456789-")
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
