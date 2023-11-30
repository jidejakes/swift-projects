//
//  UniversalLibrary.swift
//  AxoCheck
//
//  Created by Olujide Jacobs on 9/20/20.
//  Copyright © 2020 jidejakes. All rights reserved.
//

// This file contains all extensions, functions, and other UI helpers that make development faster

import UIKit

// Extensions

// Get month day year from date
extension Date {
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self)
    }
    
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
    
    var year: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self)
    }
}

// Activity is used to configure our spinner
struct Activity {
    static let indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        view.style = .gray
        view.hidesWhenStopped = true
        return view
    }()
    
    static let overlay: UIView = {
        let view = UIView()
        view.translateAll()
        view.layer.backgroundColor = UIColor.black.withAlphaComponent(0.25).cgColor
        view.layer.cornerRadius = 10
        return view
    }()
}

extension UIView {
    
    // Add spinner to controls
    func addSpinner() {
        Activity.indicator.startAnimating()
        
        self.addSubview(Activity.indicator)
        
        _ = Activity.indicator.anchor(centerX: self.centerXAnchor, centerY: self.centerYAnchor)
    }
    
    func removeSpinner() {
        Activity.indicator.stopAnimating()
    }
    
    // Status bar with primary color
    func setUpStatusBar() {
        let statusBar: UIView = {
            let view = UIView()
            view.frame = UIApplication.shared.statusBarFrame
            view.backgroundColor = ColorConstants.primaryColor.withAlphaComponent(0.85)
            return view
        }()
        
        self.addSubview(statusBar)
    }
    
    // Dropdown for textfields
    func setUpDropdown() {
        let dropDown: UIImageView = {
            let image = UIImageView()
            image.image = UIImage(named: "dropdown")
            image.alpha = 0.5
            return image
        }()
        
        self.sizeToFit()
        self.tintColor = .clear
        
        self.addSubview(dropDown)
        
        _ = dropDown.anchor(right: self.trailingAnchor, centerY: self.centerYAnchor, rightConstant: 8)
    }
    
    func translateAll() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // Constraints for views
    func anchor(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, centerX: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0, widthMultiplier:  CGFloat = 0, heightMultiplier: CGFloat = 0, centerXConstant: CGFloat = 0, centerYConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        
        translateAll()
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leadingAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant))
        }
        
        if let right = right {
            anchors.append(trailingAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if let centerX = centerX {
            anchors.append(centerXAnchor.constraint(equalTo: centerX, constant: centerXConstant))
        }
        
        if let centerY = centerY {
            anchors.append(centerYAnchor.constraint(equalTo: centerY, constant: -centerYConstant))
        }
        
        if widthMultiplier > 0 {
            anchors.append(widthAnchor.constraint(equalTo: (superview?.widthAnchor)!, multiplier: widthMultiplier))
        }
        
        if heightMultiplier > 0 {
            anchors.append(heightAnchor.constraint(equalTo: (superview?.heightAnchor)!, multiplier: heightMultiplier))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({ $0.isActive = true })
        return anchors
    }
    
}

extension UIViewController {
    
    // Background Gradient
    func setGradientForBackground() {
        let colorTop = UIColor(red: 255 / 255, green: 139 / 255, blue: 0 / 255, alpha: 1.0).cgColor
        let colorMiddle = UIColor(red: 198 / 255, green: 109 / 255, blue: 0 / 255, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 153 / 255, green: 83 / 255, blue: 0 / 255, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorMiddle, colorBottom]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // Start the spinner
    func activityIndicatorStart() {
        DispatchQueue.main.async {
            Activity.overlay.isHidden = false
            Activity.indicator.startAnimating()
            
            self.view.addSubview(Activity.overlay)
            Activity.overlay.addSubview(Activity.indicator)
            
            _ = Activity.overlay.anchor(centerX: self.view.centerXAnchor, centerY: self.view.centerYAnchor, widthConstant: 50, heightConstant: 50)
            _ = Activity.indicator.anchor(centerX: Activity.overlay.centerXAnchor, centerY: Activity.overlay.centerYAnchor)
        }
    }
    
    func activityIndicatorStop() {
        DispatchQueue.main.async {
            Activity.overlay.isHidden = true
            Activity.indicator.stopAnimating()
        }
    }
    
    // Network spinners
    func networkLoaderStart() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
    }
    
    func networkLoaderStop() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    // Alerts
    func alert(message: String, title: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            alertController.view.tintColor = ColorConstants.primaryColor
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func alertAndDismiss(message: String, title: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            })
            
            alertController.addAction(okAction)
            alertController.view.tintColor = ColorConstants.primaryColor
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func alertAndDismissToRoot(message: String, title: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in self.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
            })
            
            alertController.addAction(okAction)
            alertController.view.tintColor = ColorConstants.primaryColor
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func alertAndPop(message: String, title: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in self.navigationController?.popViewController(animated: true)
            })
            
            alertController.addAction(okAction)
            alertController.view.tintColor = ColorConstants.primaryColor
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func alertAndPopToRoot(message: String, title: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in self.navigationController?.popToRootViewController(animated: true)
            })
            
            alertController.addAction(OKAction)
            alertController.view.tintColor = ColorConstants.primaryColor
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func alertAndPush(message: String, title: String, vc: UIViewController) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in self.navigationController?.pushViewController(vc, animated: true)
            })
            
            alertController.addAction(okAction)
            alertController.view.tintColor = ColorConstants.primaryColor
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func alertAndLogin(message: String, title: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action)
                in self.switchView(value: true)
            })
            
            alertController.addAction(okAction)
            alertController.view.tintColor = ColorConstants.primaryColor
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func alertAndExit(message: String, title: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in self.switchView(value: false)
            })
            
            alertController.addAction(okAction)
            alertController.view.tintColor = ColorConstants.primaryColor
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    // Set root view
    func switchView(value: Bool, key: String = "status") {
        UserDefaults.standard.set(value, forKey: key)
        
        ViewSwitcher.updateRootVC()
        
        if value == false {}
    }
    
    // Internet connection check
    func internetCheck(text: String) {
        let textLabel: AuthLabel = {
            let label = AuthLabel()
            label.textColor = ColorConstants.primaryColor
            label.textAlignment = .center
            label.text = text
            label.numberOfLines = 0
            return label
        }()
        
        let reloadButton: AuthButton = {
            let button = AuthButton()
            button.setTitle("Reload", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            button.layer.cornerRadius = 10
            button.backgroundColor = ColorConstants.primaryColor
            button.addTarget(self, action: #selector(reload), for: .touchUpInside)
            return button
        }()
        
        self.view.addSubview(textLabel)
        self.view.addSubview(reloadButton)
        
        _ = textLabel.anchor(left: self.view.safeAreaLayoutGuide.leadingAnchor, right: self.view.safeAreaLayoutGuide.trailingAnchor, centerY: self.view.centerYAnchor, leftConstant: 16, rightConstant: 16)
        _ = reloadButton.anchor(textLabel.bottomAnchor, centerX: textLabel.centerXAnchor, topConstant: 8, widthConstant: 125)
    }
    
    @objc func reload() {
        switchView(value: true)
    }
}

extension String {
    
    // Formatting text for currency textField
    func currencyFormatting() -> String {
        if let value = Double(self) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 0
            formatter.currencySymbol = "₦"
            if let str = formatter.string(for: value) {
                return str
            }
        }
        return ""
    }
    
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
        
        guard let characterSpacing = characterSpacing else { return attributedString }
        
        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))
        
        return attributedString
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let passRegEx = "(?=[^a-z]*[a-z])(?=.*[A-Z])(?=[^0-9]*[0-9])[a-zA-Z0-9_!@#$%^&*]{8,}"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passRegEx)
        return passwordPred.evaluate(with: self)
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}

extension UserDefaults {
    private static var index = 0
    static func createCleanForTest(label: StaticString = #file) -> UserDefaults {
        index += 1
        let suiteName = "UnitTest-UserDefaults-\(label)-\(index)"
        UserDefaults().removePersistentDomain(forName: suiteName)
        return UserDefaults(suiteName: suiteName)!
    }
}

// Classes

// To disable paste into texfield
class CustomUITextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}

// Image from API
class CustomImageView: UIImageView {
    
    var imageCache = NSCache<AnyObject, AnyObject>()
    
    var imageUrlString: String?
    
    func load(urlString: String) {
        imageCache = NSCache()
        
        imageUrlString = urlString
        
        image = nil
        
        let url = URL(string: urlString)
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url ?? URL(fileURLWithPath: urlString), completionHandler:
            { (data, response, error) in
                if error != nil {
                    _ = error
                    return
                }
                
                DispatchQueue.global().async {
                    if let imageToCache = UIImage(data: data!) {
                        if self.imageUrlString == urlString {
                            DispatchQueue.main.async {
                                self.image = imageToCache
                                self.imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                            }
                        }
                    }
                }
        }).resume()
    }
}

class CustomSegmentControl: UIControl {
    
    private var componentOrientation: ComponentOrientation = ComponentOrientation.LeftRight
    
    private var labels = [UILabel]()
    private var icons = [UIImageView]()
    private var selectedLabel = UILabel()
    
    private var imageIcon = UIImageView()
    private var selectedImageIcon = UIImageView()
    
    private var withIcon: Bool = true
    
    private func setOrientation(orientation: ComponentOrientation) {
        switch orientation {
        case .LeftRight:
            componentOrientation = ComponentOrientation.LeftRight
        case .TopDown :
            componentOrientation = ComponentOrientation.TopDown
        }
    }
    
    private var thumbColor: UIColor = .white {
        didSet {
            setThumbColor()
        }
    }
    
    private func setThumbColor() {
        thumbView.backgroundColor = thumbColor
    }
    
    private var textColor: UIColor = .white
    
    private func setTextColor() {
        for i in 0..<labels.count {
            labels[i].textColor = textColor
            labels[i].font = UIFont(name: "HelveticaNeue", size: 14.0)
        }
    }
    
    private var selectedTextColor: UIColor = .black {
        didSet{
            setSelectedTextColor()
        }
    }
    
    private func setSelectedTextColor() {
        selectedLabel.textColor = selectedTextColor
    }
    
    private var thumbView = UIView()
    
    private var items:[String] = []
    
    private var icon:[UIImage] = []
    private var selected_icon:[UIImage] = []
    
    var selectedIndex:Int = 0 {
        didSet{
            displayNewSelectedIndex()
        }
    }
    
    init(FrameWithoutIcon frame: CGRect, items: [String], backgroundColor: UIColor, thumbColor: UIColor, textColor: UIColor, selectedTextColor: UIColor) {
        super.init(frame: frame)
        self.items = items
        self.backgroundColor = backgroundColor
        self.thumbColor = thumbColor
        self.textColor = textColor
        self.selectedTextColor = selectedTextColor
        self.componentOrientation = ComponentOrientation.TopDown
        self.withIcon = false
        setupView()
    }
    
    init(FrameWithIcon frame: CGRect, items: [String], icons: [UIImage], selectedIcons: [UIImage], backgroundColor: UIColor, thumbColor: UIColor, textColor: UIColor, selectedTextColor: UIColor, orientation: ComponentOrientation) {
        super.init(frame: frame)
        self.items = items
        self.icon = icons
        self.selected_icon = selectedIcons
        self.backgroundColor = backgroundColor
        self.thumbColor = thumbColor
        self.textColor = textColor
        self.selectedTextColor = selectedTextColor
        self.componentOrientation = orientation
        setupView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    private func getIconFrameByOrientation(orientation:ComponentOrientation, index:Int, text:String) -> CGRect {
        let width = self.bounds.width/CGFloat(items.count)
        let height = self.bounds.height
        let iconX = getIconX(itemWidth: width, textWidth: evaluateStringWidth(textToEvaluate: text))
        let x = width*CGFloat(index-1)
        
        switch orientation {
        case .LeftRight:
            let evaluateIconX = x + iconX
            let iconRect = CGRect(x: evaluateIconX, y: 0, width: 16, height: height)
            return iconRect
        case .TopDown:
            let centre:CGFloat = x + ((width - 16) / 2)
            let iconRect = CGRect(x: centre, y: 7, width: 16, height: 16)
            return iconRect
        }
    }
    
    private func getTextFrameByOrintation(orientation:ComponentOrientation, text:String, index:Int) -> CGRect {
        let height = self.bounds.height
        let width = self.bounds.width / CGFloat(items.count)
        let textX = getTextX(itemWidth: width, textWidth: evaluateStringWidth(textToEvaluate: text))
        let xPosition = CGFloat(index) * width
        let evaluateTextX = xPosition + textX
        
        switch orientation {
        case .LeftRight:
            let textRect = CGRect(x: evaluateTextX, y: 0, width: width, height: height)
            return textRect
        case .TopDown:
            let centre = evaluateTextX - 13
            let textRect:CGRect?
            if withIcon {
                textRect = CGRect(x: centre, y: 18, width: width, height: 25)
            }else {
                textRect = CGRect(x: centre, y: 0, width: width, height: height)
            }
            return textRect!
        }
    }
    
    
    private func setupView() {
        layer.cornerRadius = 5
        setupLabels()
        insertSubview(thumbView, at: 0)
    }
    
    private func setupLabels() {
        
        for label in labels {
            label.removeFromSuperview()
        }
        
        labels.removeAll(keepingCapacity: true)
        
        for index in 1...items.count {
            
            let view = UIView.init(frame: .zero)
            
            let label = UILabel(frame: .zero)
            label.text = items[index - 1]
            label.textColor = textColor
            view.addSubview(label)
            labels.append(label)
            
            let text = items[index - 1]
            
            if withIcon {
                self.imageIcon = UIImageView(frame: getIconFrameByOrientation(orientation: self.componentOrientation, index: index, text: text))
                self.imageIcon.contentMode = .scaleAspectFit
                self.imageIcon.image = icon[index - 1]
                
                view.addSubview(self.imageIcon)
                icons.append(self.imageIcon)
            }
            
            self.addSubview(view)
            
        }
        setTextColor()
    }
    
    private func getIconX(itemWidth:CGFloat, textWidth:CGFloat) -> CGFloat{
        let iconWidth:CGFloat = 16.0
        let avg = (iconWidth + textWidth)
        let space:CGFloat = (itemWidth - avg) / 2
        
        return space + 2
    }
    
    private func getTextX(itemWidth:CGFloat, textWidth:CGFloat) -> CGFloat {
        let iconWidth:CGFloat = 16.0
        let avg = (iconWidth + textWidth)
        let space:CGFloat = (itemWidth - avg) / 2
        
        let x = space + iconWidth
        
        return x + 8
    }
    
    internal override func layoutSubviews() {
        super.layoutSubviews()
        
        var selectedFrame = self.bounds
        let newWidth = selectedFrame.width / CGFloat(items.count)
        selectedFrame.size.width = newWidth
        
        selectedFrame.origin.x = selectedFrame.origin.x + 4
        selectedFrame.origin.y = selectedFrame.origin.y + 4
        selectedFrame.size.width = selectedFrame.width - 8
        selectedFrame.size.height = selectedFrame.height - 8
        
        if selectedIndex > 0 {
            setTextColor()
            setSelectedTextColor()
            thumbView.frame = setDefaultSelectionPoint(index: selectedIndex)
        }else {
            thumbView.frame = selectedFrame
        }
        
        thumbView.backgroundColor = thumbColor
        thumbView.layer.cornerRadius = 5
        
        for index in 0...labels.count - 1 {
            let label = labels[index]
            
            let text = items[index]
            
            
            label.frame = getTextFrameByOrintation(orientation: self.componentOrientation, text: text, index: index)
            
        }
    }
    
    private func evaluateStringWidth (textToEvaluate: String) -> CGFloat{
        let lbl = UILabel(frame: .zero)
        lbl.text = textToEvaluate
        lbl.sizeToFit()
        return lbl.frame.width
    }
    
    internal override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        let labelWidth = self.bounds.width / CGFloat(items.count)
        
        var calculatedIndex : Int?
        for (index, item) in labels.enumerated() {
            
            let text = items[index]
            
            let iconX = getIconX(itemWidth: labelWidth, textWidth: evaluateStringWidth(textToEvaluate: text))
            
            let frame = CGRect(x: item.frame.origin.x - (iconX * 2), y: 0, width: item.frame.width, height: self.bounds.height)
            
            if frame.contains(location){
                calculatedIndex = index
            }else{
                item.textColor = textColor
                if withIcon {
                    icons[index].image = icon[index]
                }
                
            }
        }
        
        if calculatedIndex != nil {
            selectedIndex = calculatedIndex!
            sendActions(for: .valueChanged)
        }
        return false
    }
    
    private func displayNewSelectedIndex(){
        selectedLabel = labels[selectedIndex]
        selectedLabel.textColor = selectedTextColor
        
        if withIcon {
            selectedImageIcon = icons[selectedIndex]
            selectedImageIcon.image = selected_icon[selectedIndex]
        }
        
        
        let text = items[selectedIndex]
        
        let labelWidth = self.bounds.width / CGFloat(items.count)
        let iconX = getTextX(itemWidth: labelWidth, textWidth: evaluateStringWidth(textToEvaluate: text))
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            
            var labelFrame = self.selectedLabel.bounds
            
            if self.componentOrientation == ComponentOrientation.TopDown {
                labelFrame.origin.x = self.selectedLabel.frame.origin.x - iconX + 4 + 13
            }else{
                labelFrame.origin.x = self.selectedLabel.frame.origin.x - iconX + 4
            }
            
            labelFrame.origin.y = 4
            labelFrame.size.width = self.selectedLabel.frame.width - 8
            labelFrame.size.height = self.bounds.height - 8
            
            
            self.thumbView.frame = self.setDefaultSelectionPoint(index: self.selectedIndex)
            
        }, completion: nil)
        
        
    }
    
    private func setDefaultSelectionPoint(index:Int) -> CGRect{
        let selectedLabel = labels[index]
        var selectedFrame = selectedLabel.bounds
        
        if withIcon {
            selectedImageIcon = icons[selectedIndex]
            selectedImageIcon.image = selected_icon[selectedIndex]
        }
        
        let text = items[selectedIndex]
        let labelWidth = self.bounds.width / CGFloat(items.count)
        let iconX = getTextX(itemWidth: labelWidth, textWidth: evaluateStringWidth(textToEvaluate: text))
        
        if self.componentOrientation == ComponentOrientation.TopDown {
            selectedFrame.origin.x = self.selectedLabel.frame.origin.x - iconX + 4 + 13
        }else{
            selectedFrame.origin.x = self.selectedLabel.frame.origin.x - iconX + 4
        }
        selectedFrame.origin.y = 4
        selectedFrame.size.width = self.selectedLabel.frame.width - 8
        selectedFrame.size.height = self.bounds.height - 8
        return selectedFrame
    }
    
}

enum ComponentOrientation {
    case TopDown
    case LeftRight
}

class ShortDatePickerView: UIPickerView  {
    
    enum Component: Int {
        case Month = 0
        case Year = 1
    }
    
    let LABEL_TAG = 43
    let bigRowCount = 1000
    let numberOfComponentsRequired = 2
    
    let months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    var years: [String] {
        get {
            var years: [String] = [String]()
            
            for i in minYear...maxYear {
                years.append("\(i)")
            }
            
            return years;
        }
    }
    
    var bigRowMonthsCount: Int {
        get {
            return bigRowCount * months.count
        }
    }
    
    var bigRowYearsCount: Int {
        get {
            return bigRowCount * years.count
        }
    }
    
    var monthSelectedTextColor: UIColor?
    var monthTextColor: UIColor?
    var yearSelectedTextColor: UIColor?
    var yearTextColor: UIColor?
    var monthSelectedFont: UIFont?
    var monthFont: UIFont?
    var yearSelectedFont: UIFont?
    var yearFont: UIFont?
    
    let rowHeight: NSInteger = 44
    
    // Will be returned in user's current TimeZone settings
    
    var date: Date {
        get {
            let month = self.months[selectedRow(inComponent: Component.Month.rawValue) % months.count]
            let year = self.years[selectedRow(inComponent: Component.Year.rawValue) % years.count]
            let formatter = DateFormatter()
            formatter.dateFormat = "MM yyyy"
            return formatter.date(from: "\(month) \(year)")!
        }
    }
    
    var minYear: Int!
    var maxYear: Int!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadDefaultParameters()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadDefaultParameters()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadDefaultParameters()
    }
    
    func loadDefaultParameters() {
        minYear = Calendar.current.dateComponents([.year], from: Date()).year
        maxYear = minYear! + 10
        
        self.delegate = self
        self.dataSource = self
        
        monthSelectedTextColor = .black
        monthTextColor = .black
        
        yearSelectedTextColor = .black
        yearTextColor = .black
        
        monthSelectedFont = .boldSystemFont(ofSize: 17)
        monthFont = .boldSystemFont(ofSize: 17)
        
        yearSelectedFont = .boldSystemFont(ofSize: 17)
        yearFont = .boldSystemFont(ofSize: 17)
    }
    
    
    func setup(minYear: NSInteger, andMaxYear maxYear: NSInteger) {
        self.minYear = minYear
        
        if maxYear > minYear {
            self.maxYear = maxYear
        } else {
            self.maxYear = minYear + 10
        }
    }
    
    func selectToday() {
        selectRow(todayIndexPath.row, inComponent: Component.Month.rawValue, animated: false)
        selectRow(todayIndexPath.section, inComponent: Component.Year.rawValue, animated: false)
    }
    
    
    var todayIndexPath: NSIndexPath {
        get {
            var row = 0.0
            var section = 0.0
            
            for cellMonth in months {
                if cellMonth == currentMonthName {
                    row = Double(months.firstIndex(of: cellMonth)!)
                    row = row + Double(bigRowMonthsCount / 2)
                    break
                }
            }
            
            for cellYear in years {
                if cellYear == currentYearName {
                    section = Double(years.firstIndex(of: cellYear)!)
                    section = section + Double(bigRowYearsCount / 2)
                    break
                }
            }
            
            return NSIndexPath(row: Int(row), section: Int(section))
        }
    }
    
    var currentMonthName: String {
        get {
            let formatter = DateFormatter()
            let locale = Locale.init(identifier: "en_US")
            formatter.locale = locale
            formatter.dateFormat = "MM"
            return formatter.string(from: Date())
        }
    }
    
    var currentYearName: String {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy"
            return formatter.string(from: Date())
        }
    }
    
    func selectedColorForComponent(component: NSInteger) -> UIColor {
        if component == Component.Month.rawValue {
            return monthSelectedTextColor!
        }
        return yearSelectedTextColor!
    }
    
    func colorForComponent(component: NSInteger) -> UIColor {
        if component == Component.Month.rawValue {
            return monthTextColor!
        }
        return yearTextColor!
    }
    
    
    func selectedFontForComponent(component: NSInteger) -> UIFont {
        if component == Component.Month.rawValue {
            return monthSelectedFont!
        }
        return yearSelectedFont!
    }
    
    func fontForComponent(component: NSInteger) -> UIFont {
        if component == Component.Month.rawValue {
            return monthFont!
        }
        return yearFont!
    }
    
    
    func titleForRow(row: Int, forComponent component: Int) -> String? {
        if component == Component.Month.rawValue {
            return self.months[row % self.months.count]
        }
        return self.years[row % self.years.count]
    }
    
    
    func labelForComponent(component: NSInteger) -> UILabel {
        let frame = CGRect(x: 0.0, y: 0.0, width: bounds.size.width, height: CGFloat(rowHeight))
        let label = UILabel(frame: frame)
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        label.tag = LABEL_TAG
        return label
    }
}

extension ShortDatePickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return numberOfComponentsRequired
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == Component.Month.rawValue) {
            return bigRowMonthsCount
        } else {
            return bigRowYearsCount
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return self.bounds.size.width / CGFloat(numberOfComponentsRequired)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var selected = false
        
        if component == Component.Month.rawValue {
            let monthName = self.months[(row % self.months.count)]
            if monthName == currentMonthName {
                selected = true
            }
        } else {
            let yearName = self.years[(row % self.years.count)]
            if yearName == currentYearName {
                selected = true
            }
        }
        
        var returnView: UILabel
        if view?.tag == LABEL_TAG {
            returnView = view as! UILabel
        } else {
            returnView = labelForComponent(component: component)
        }
        
        returnView.font = selected ? selectedFontForComponent(component: component) : fontForComponent(component: component)
        returnView.textColor = selected ? selectedColorForComponent(component: component) : colorForComponent(component: component)
        
        returnView.text = titleForRow(row: row, forComponent: component)
        
        return returnView
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat(rowHeight)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
}

// UIControls

// General button configure
class AuthButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        translateAll()
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        self.layer.cornerRadius = 15
        self.layer.backgroundColor = ColorConstants.primaryColor.cgColor
    }
}

class AuthLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
        translateAll()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
        translateAll()
    }
    
    private func setupLabel() {
        self.textColor = .black
        self.textAlignment = .center
        self.font = FontConstants.defaultFont
    }
}

class AuthTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
    }
    
    private func setupTextField() {
        translateAll()
        self.backgroundColor = .clear
        self.layer.delegate = self
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.textColor = .black
        self.tintColor = .lightGray
        self.textAlignment = .left
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.borderStyle = .roundedRect
        self.font = FontConstants.defaultFont
    }
}

// Switch between views
class ViewSwitcher {
    static func updateRootVC() {
        let status = UserDefaults.standard.bool(forKey: "status")
        
        var rootVc: UIViewController?
        
        if status == true {
            rootVc = UINavigationController(rootViewController: InformationViewController())
        } else {
            rootVc = UINavigationController(rootViewController: InformationViewController())
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVc
    }
}

// Constants
struct ColorConstants {
    static let primaryColor = #colorLiteral(red: 0.7764705882, green: 0.4274509804, blue: 0, alpha: 1)
}

struct FontConstants {
    static let defaultFont = UIFont(name: "Market_Deco", size: 16)
}
