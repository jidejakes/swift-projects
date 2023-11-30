//
//  ViewController.swift
//  End Sars
//
//  Created by Olujide Jacobs on 10/11/20.
//  Copyright © 2020 jidejakes. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI
import Alamofire
import PDFKit

class InformationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = titleHeaders.randomElement()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize view
        setGradientForBackground()
        configureUI()
        
        let agreementOpened = UserDefaults.standard.bool(forKey: "agreementOpened")
        
        if agreementOpened != true {
            let time = DispatchTime.now() + 1
            
            DispatchQueue.main.asyncAfter(deadline: time) {
                self.openAgreement()
            }
        }
    }
    
    // Hide home bar/button
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    private let infoString = """

    What is SARS?

    SARS is a branch of the Nigeria Police Force under the Force Criminal Investigation and Intelligence Department (FCIID). The squad deals with crimes associated with armed robbery, car snatching, kidnapping, cattle rustling, and crimes associated with firearms.

    Why Nigerian Youths are concerned about the operations of SARS.

    The sadness, pain and anger of the Citizens have grown into protests across the nation over the last few days, causing the government to address the people. However, the Youths aren't buying it.

    Nigerians have called for the government to disband the deployment of the Nigeria Police Force Special Anti-Robbery Squad, questioning the existence of SARS because they don't seem to perform their actual assignments. They’re also calling for a complete reform of the Nigerian Police Force.

    The campaigners are both on social media and in the streets organizing protests across Nigeria, promising to continue if the government refuses to disband the force.

    What can I do to help raise awareness with the ongoing issue in Nigeria?
    
    The quickest way to raise awareness around the globe is to make your voice heard by sharing your story or contacting branches of the government to relay your concerns. You can perform some of the actions below.

    """
    
    private let agreement = """

    Hi! Welcome to Yuut!. This is a safe space for us all to stay current on issues affecting the youth in Nigeria and share our stories while also reaching out to designated officials for assistance.

    There is only ONE rule Yuut! needs you to agree to before using it.

    We do NOT condone any form of abuse or oppression. The main goal is to keep a safe community. Due to the sensitivity of the ongoing issue, Stories that have been flagged as abusive or objectionable would be removed. Aside from that, Yuut! periodically checks for abusive content every 24 hours and could flag it if found abusive to other users. Please let's stay safe and protect this house. It is our sole responsibility.

    Please indicate your agreement to this Simple house rule.

    """
    
    // Title headers
    private let titleHeaders = ["#StopPoliceBrutality", "#OneNigeria", "#TogetherWeStand", "#SOROSOKE", "#EnoughIsEnough", "#StopPoliceBrutalityNow", "#PeaceAndUnity", "#SPEAKUP", "#SayNoToOppression"]
    
    // Define headers and menu
    private let actionHeaders = ["Stay Informed", "Share your voice", "House rules"]
    private let actionMenu = [["Read more on Ongoing Issues", "Know Your rights"], ["Contact designated officials", "View/Share a Story"], ["House rules"]]
    
    private let rowId = "rowId"
    
    // Enable scrolling in view
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.frame = self.view.bounds
        view.clipsToBounds = true
        view.contentInsetAdjustmentBehavior = .never
        view.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 0)
        return view
    }()
    
    // Placeholder for menu
    private let actionView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let quickInfoAboutCurrentSituation: AuthLabel = {
        let label = AuthLabel()
        label.numberOfLines = 0
        return label
    }()
    
    // Menu configuration
    private let actionTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.clipsToBounds = true
        return tableView
    }()
    
    private func configureUI() {
        // Customize navBar
        navigationController?.navigationBar.tintColor = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "emergency"), style: .plain, target: self, action: #selector(callHotline))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareApp))
        
        // Set tableView delegates
        actionTableView.delegate = self
        actionTableView.dataSource = self
        actionTableView.register(ActionCell.self, forCellReuseIdentifier: rowId)
        
        // Set up content in view
        quickInfoAboutCurrentSituation.text = infoString
        
        view.addSubview(scrollView)
        scrollView.addSubview(quickInfoAboutCurrentSituation)
        scrollView.addSubview(actionView)
        actionView.addSubview(actionTableView)
        
        _ = scrollView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leadingAnchor, bottom: view.bottomAnchor, right: view.trailingAnchor)
        _ = quickInfoAboutCurrentSituation.anchor(scrollView.topAnchor, left: scrollView.safeAreaLayoutGuide.leadingAnchor, right: scrollView.safeAreaLayoutGuide.trailingAnchor, leftConstant: 16, rightConstant: 16)
        _ = actionView.anchor(quickInfoAboutCurrentSituation.bottomAnchor, left: scrollView.safeAreaLayoutGuide.leadingAnchor, bottom: scrollView.bottomAnchor, right: scrollView.safeAreaLayoutGuide.trailingAnchor, topConstant: 12, heightConstant: 375)
        _ = actionTableView.anchor(actionView.topAnchor, left: actionView.leadingAnchor, bottom: actionView.bottomAnchor, right: actionView.trailingAnchor)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return actionMenu.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actionMenu[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < actionHeaders.count {
            return actionHeaders[section]
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Initialize cell properties
        let cell = actionTableView.dequeueReusableCell(withIdentifier: rowId, for: indexPath) as! ActionCell
        
        // Set up separator spacing
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: CGRect(x: 5, y: 5, width: cell.bounds.width - 10, height: cell.bounds.height - 10), cornerRadius: 25).cgPath
        
        cell.selectionStyle = .gray
        
        cell.layer.mask = maskLayer
        cell.layer.backgroundColor = UIColor.black.cgColor
        
        cell.actionTitle.text = actionMenu[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = actionMenu[indexPath.section][indexPath.item]
        let agreement = UserDefaults.standard.bool(forKey: "agreement")
        
        if agreement != true {
            self.alert(message: "Please accept the house rules to enable app features", title: "Yuut!")
        } else {
            if actionMenu[indexPath.section][indexPath.item] == "Read more on Ongoing Issues" {
                showWebPage(link: "https://www.morebranches.com/category/news")
            } else if actionMenu[indexPath.section][indexPath.item] == "Know Your rights" {
                let vc = RightsViewController()
                vc.navigationItem.title = title
                navigationController?.pushViewController(vc, animated: true)
            } else if actionMenu[indexPath.section][indexPath.item] == "Contact designated officials" {
                let vc = GovernmentOfficialsViewController()
                vc.navigationItem.title = title
                navigationController?.pushViewController(vc, animated: true)
            } else if actionMenu[indexPath.section][indexPath.item] == "View/Share a Story" {
                let vc = StoryViewController()
                vc.navigationItem.title = title
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        if actionMenu[indexPath.section][indexPath.item] == "House rules" {
            openAgreement()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
    
    // Show Safari view
    private func showWebPage(link: String) {
        if let url = URL(string: link) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = false
            config.barCollapsingEnabled = true
            
            let vc = SFSafariViewController(url: url, configuration: config)
            vc.delegate = self
            vc.dismissButtonStyle = .close
            vc.preferredControlTintColor = ColorConstants.primaryColor
            
            present(vc, animated: true, completion: nil)
        }
    }
    
    // Call emergency
    @objc private func callHotline() {
        UIApplication.shared.open(URL(string: "tel://017001755")!, options: [:], completionHandler: nil)
    }
    
    // Share App
    @objc private func shareApp() {
        let url = URL(string: "https://apps.apple.com/us/app/yuut/id1535449710")!
        let vc = UIActivityViewController(activityItems: ["Stay current on the latest issues affecting the Nigerian Youth", url], applicationActivities: nil)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        } else {
            vc.popoverPresentationController?.sourceView = self.view
        }
        
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    func openAgreement() {
        UserDefaults.standard.set(true, forKey: "agreementOpened")
        
        let alertController = UIAlertController(title: "HOUSE RULES", message: agreement, preferredStyle: .alert)
        let disagreeAction = UIAlertAction(title: "Disagree", style: .destructive, handler: { (action) in
            UserDefaults.standard.set(false, forKey: "agreement")
        })
        let agreeAction = UIAlertAction(title: "Agree", style: .default, handler: { (action) in
            UserDefaults.standard.set(true, forKey: "agreement")
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(disagreeAction)
        alertController.addAction(agreeAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

class RightsViewController: UIViewController, SFSafariViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showDocument()
    }
    
    private var pdfView: PDFView = {
        let view = PDFView()
        view.backgroundColor = .clear
        return view
    }()
    
    private func configureUI() {
        view.backgroundColor = ColorConstants.primaryColor
        
        view.addSubview(pdfView)
        
        _ = pdfView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.bottomAnchor, right: view.safeAreaLayoutGuide.trailingAnchor)
    }
    
    @objc private func showDocument() {
        if let path = Bundle.main.path(forResource: "rights", ofType: "pdf") {
            if let pdfDocument = PDFDocument(url: URL(fileURLWithPath: path)) {
                pdfView.displayMode = .singlePageContinuous
                pdfView.autoScales = true
                pdfView.displayDirection = .vertical
                pdfView.document = pdfDocument
            }
        }
    }
}

struct ExpandableStates {
    var isExpanded: Bool
    var names: [String]
}

class GovernmentOfficialsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate, MFMailComposeViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientForBackground()
        configureUI()
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    // States and Region
    private var methodHeaders = ["Abia", "Adamawa", "Akwa Ibom", "Anambra", "Bauchi", "Bayelsa", "Benue", "Borno", "Cross River", "Delta", "Ebonyi", "Edo", "Ekiti", "Enugu", "FCT", "Gombe", "Imo", "Jigawa", "Kaduna", "Kano", "Katsina", "Kebbi", "Kogi", "Kwara", "Lagos", "Nassarawa", "Niger", "Ogun", "Ondo", "Osun", "Oyo", "Plateau", "Rivers", "Sokoto", "Taraba", "Yobe", "Zamfara"]
    
    private var menu = [ExpandableStates(isExpanded: false, names: ["Abia North", "Abia South", "Abia Central"]),
                        ExpandableStates(isExpanded: false, names: ["Adamawa North", "Adamawa South", "Adamawa Central"]),
                        ExpandableStates(isExpanded: false, names: ["Akwa Ibom North East", "Akwa Ibom North West", "Akwa Ibom South"]),
                        ExpandableStates(isExpanded: false, names: ["Anambra North", "Anambra South", "Anambra Central"]),
                        ExpandableStates(isExpanded: false, names: ["Bauchi North", "Bauchi South", "Bauchi Central"]),
                        ExpandableStates(isExpanded: false, names: ["Bayelsa East", "Bayelsa West", "Bayelsa Central"]),
                        ExpandableStates(isExpanded: false, names: ["Benue North West", "Benue South"]),
                        ExpandableStates(isExpanded: false, names: ["Borno North", "Borno South", "Borno Central"]),
                        ExpandableStates(isExpanded: false, names: ["Cross River North", "Cross River South", "Cross River Central"]),
                        ExpandableStates(isExpanded: false, names: ["Delta North", "Delta South", "Delta Central"]),
                        ExpandableStates(isExpanded: false, names: ["Ebonyi North", "Ebonyi South", "Ebonyi Central"]),
                        ExpandableStates(isExpanded: false, names: ["Edo North", "Edo South", "Edo Central"]),
                        ExpandableStates(isExpanded: false, names: ["Ekiti North", "Ekiti South", "Ekiti Central"]),
                        ExpandableStates(isExpanded: false, names: ["Enugu East", "Enugu West", "Enugu North"]),
                        ExpandableStates(isExpanded: false, names: ["Abuja"]),
                        ExpandableStates(isExpanded: false, names: ["Gombe North", "Gombe South", "Gombe Central"]),
                        ExpandableStates(isExpanded: false, names: ["Imo East", "Imo West", "Imo North"]),
                        ExpandableStates(isExpanded: false, names: ["Jigawa North East", "Jigawa West", "Jigawa South West"]),
                        ExpandableStates(isExpanded: false, names: ["Kaduna North", "Kaduna South"]),
                        ExpandableStates(isExpanded: false, names: ["Kano North", "Kano South", "Kano Central"]),
                        ExpandableStates(isExpanded: false, names: ["Katsina North", "Katsina South", "Katsina Central"]),
                        ExpandableStates(isExpanded: false, names: ["Kebbi North", "Kebbi South", "Kebbi Central"]),
                        ExpandableStates(isExpanded: false, names: ["Kogi East", "Kogi Central"]),
                        ExpandableStates(isExpanded: false, names: ["Kwara North", "Kwara South", "Kwara Central"]),
                        ExpandableStates(isExpanded: false, names: ["Lagos East", "Lagos West", "Lagos Central"]),
                        ExpandableStates(isExpanded: false, names: ["Nassarawa East", "Nassarawa North", "Nassarawa South"]),
                        ExpandableStates(isExpanded: false, names: ["Niger East", "Niger North", "Niger South"]),
                        ExpandableStates(isExpanded: false, names: ["Ogun East", "Ogun West", "Ogun Central"]),
                        ExpandableStates(isExpanded: false, names: ["Ondo North", "Ondo South", "Ondo Central"]),
                        ExpandableStates(isExpanded: false, names: ["Osun East", "Osun West", "Osun Central"]),
                        ExpandableStates(isExpanded: false, names: ["Oyo North", "Oyo South", "Oyo Central"]),
                        ExpandableStates(isExpanded: false, names: ["Plateau North", "Plateau South", "Plateau Central"]),
                        ExpandableStates(isExpanded: false, names: ["Rivers East", "Rivers West", "Rivers South East"]),
                        ExpandableStates(isExpanded: false, names: ["Sokoto East", "Sokoto North"]),
                        ExpandableStates(isExpanded: false, names: ["Taraba North", "Taraba South", "Taraba Central"]),
                        ExpandableStates(isExpanded: false, names: ["Yobe East", "Yobe North", "Yobe South"]),
                        ExpandableStates(isExpanded: false, names: ["Zamfara West", "Zamfara North", "Zamfara Central"]),
    ]
    
    private let rowId = "rowId"
    
    private var name = String()
    private var phone = String()
    private var email = String()
    
    private let hintLabel: AuthLabel = {
        let label = AuthLabel()
        label.text = "Select a state to view/hide regions"
        return label
    }()
    
    private let officialsTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .clear
        tableView.clipsToBounds = true
        return tableView
    }()
    
    private func configureUI() {
        officialsTableView.delegate = self
        officialsTableView.dataSource = self
        officialsTableView.register(ActionCell.self, forCellReuseIdentifier: rowId)
        
        view.addSubview(hintLabel)
        view.addSubview(officialsTableView)
        
        _ = hintLabel.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leadingAnchor, right: view.safeAreaLayoutGuide.trailingAnchor, topConstant: 12, leftConstant: 16, rightConstant: 16)
        _ = officialsTableView.anchor(hintLabel.bottomAnchor, left: view.leadingAnchor, bottom: view.bottomAnchor, right: view.trailingAnchor, topConstant: 12)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !menu[section].isExpanded {
            return 0
        }
        return menu[section].names.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section < methodHeaders.count {
            let stateButton = UIButton()
            stateButton.setTitle(methodHeaders[section], for: .normal)
            stateButton.backgroundColor = .lightGray
            stateButton.tag = section
            stateButton.addTarget(self, action: #selector(self.handleHeaderToggle), for: .touchUpInside)
            return stateButton
        }
        return UIButton()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Initialize cell properties
        let cell = officialsTableView.dequeueReusableCell(withIdentifier: rowId, for: indexPath) as! ActionCell
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: CGRect(x: 5, y: 5, width: cell.bounds.width - 10, height: cell.bounds.height - 10), cornerRadius: 25).cgPath
        
        cell.selectionStyle = .gray
        
        cell.layer.mask = maskLayer
        cell.layer.backgroundColor = UIColor.black.cgColor
        
        cell.actionTitle.text = menu[indexPath.section].names[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = menu[indexPath.section].names[indexPath.row]
        
        //Abia
        if menu[indexPath.section].names[indexPath.row] == "Abia North" {
            self.name = "Sen. O. Kalu"
            self.phone = "8034000001"
            self.email = "okalu@orjikalu.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Abia South" {
            self.name = "Sen. E. Abaribe"
            self.phone = "8033129452"
            self.email = "enyiabaribe@yahoo.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Abia Central" {
            self.name = "Sen. T. Orji"
            self.phone = "7082800000"
            self.email = "senatortaorji@gmail.com"
        }
            
            // Adamawa
        else if menu[indexPath.section].names[indexPath.row] == "Adamawa North" {
            self.name = "Sen. I. Abbo"
            self.phone = "8066285112"
            self.email = "faradugun@gmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Adamawa South" {
            self.name = "Sen. B. Yaroe"
            self.phone = "8034050460"
            self.email = "bdyaroe@gmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Adamawa Central" {
            self.name = "Sen. A. Ahmed"
            self.phone = ""
            self.email = "aishatu.ahmed@nass.gov.ng"
        }
            
            //Akwa Ibom
        else if menu[indexPath.section].names[indexPath.row] == "Akwa Ibom North East" {
            self.name = "Sen. B. Akpan"
            self.phone = "8055555188"
            self.email = "akpanalbert@hotmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Akwa Ibom North West" {
            self.name = "Sen. C. Ekpeyong"
            self.phone = "8027785234"
            self.email = "chrisekpesg@yahoo.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Akwa Ibom South" {
            self.name = "Sen. A. Eyakenyi"
            self.phone = "8035054282"
            self.email = "konssie@yahoo.com"
        }
            
            // Anambra
        else if menu[indexPath.section].names[indexPath.row] == "Anambra North" {
            self.name = "Sen. A. Oduah"
            self.phone = "8055084340"
            self.email = "senatorstella@gmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Anambra South" {
            self.name = "Sen. I. Ubah"
            self.phone = "9096655596"
            self.email = "senatorifeanyiubah@gmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Anambra Central" {
            self.name = "Sen. E. Uche"
            self.phone = "8037620002"
            self.email = "u.ekwunife@yahoo.com"
        }
            
            // Bauchi
        else if menu[indexPath.section].names[indexPath.row] == "Bauchi North" {
            self.name = "Sen. A. Bulkachuwa"
            self.phone = ""
            self.email = "adamu.bulkachuwa@nass.gov.ng"
        } else if menu[indexPath.section].names[indexPath.row] == "Bauchi South" {
            self.name = "Sen. L. Gamau"
            self.phone = ""
            self.email = "lawal.gumau@nass.gov.ng"
        } else if menu[indexPath.section].names[indexPath.row] == "Bauchi Central" {
            self.name = "Sen. H. Jika"
            self.phone = "8038666690"
            self.email = "jikahalliru@gmail.com"
        }
            
            // Bayelsa
        else if menu[indexPath.section].names[indexPath.row] == "Bayelsa East" {
            self.name = "Sen. D. Wangagra"
            self.phone = ""
            self.email = "degi.wangagha@nass.gov.ng"
        } else if menu[indexPath.section].names[indexPath.row] == "Bayelsa West" {
            self.name = "Sen. D. Diri"
            self.phone = "8036668698"
            self.email = "douyediri@gmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Bayelsa Central" {
            self.name = "Sen. O. EWHRUDJAKPO"
            self.phone = "9031352791"
            self.email = "ogagadick@gmail.com"
        }
            
            // Benue
        else if menu[indexPath.section].names[indexPath.row] == "Benue North West" {
            self.name = "Sen. E. Orker-Jev"
            self.phone = ""
            self.email = "emmanuel.orkerjev@nass.gov.ng"
        } else if menu[indexPath.section].names[indexPath.row] == "Benue South" {
            self.name = "Sen A. Morro"
            self.phone = "8068870606"
            self.email = "abahmoro@yahoo.com"
        }
            
            // Borno
        else if menu[indexPath.section].names[indexPath.row] == "Borno North" {
            self.name = "Sen. A. Kyari"
            self.phone = ""
            self.email = "abubakar.kyari@nass.gov.ng"
        } else if menu[indexPath.section].names[indexPath.row] == "Borno South" {
            self.name = "Sen. K. Shettima"
            self.phone = "8034459047"
            self.email = "kashimshettima@gmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Borno Central" {
            self.name = "Sen. M. Ndume"
            self.phone = "8109480004"
            self.email = "mohammed.ndume@nass.gov.ng"
        }
            
            // Cross River
        else if menu[indexPath.section].names[indexPath.row] == "Cross River North" {
            self.name = "Sen. R. Oko"
            self.phone = ""
            self.email = "rose.oko@nass.gov.ng"
        } else if menu[indexPath.section].names[indexPath.row] == "Cross River South" {
            self.name = "Sen. G. Bassey"
            self.phone = "8034444555"
            self.email = "gershombassey@gmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Cross River Central" {
            self.name = "Sen. S. Onor"
            self.phone = "8030998460"
            self.email = "irunandu@yahoo.com"
        }
            
            // Delta
        else if menu[indexPath.section].names[indexPath.row] == "Delta North" {
            self.name = "Sen. P. Nwaoboshi"
            self.phone = "8037200999"
            self.email = "pnwaoboshi@yahoo.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Delta South" {
            self.name = "Sen. J. Manager"
            self.phone = "8143103829"
            self.email = "jamesmanager2013@gmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Delta Central" {
            self.name = "Sen. O. Omo-Agege"
            self.phone = "7033399937"
            self.email = "senator.ovieomoagege@gmail.com"
        }
            
            // Ebonyi
        else if menu[indexPath.section].names[indexPath.row] == "Ebonyi North" {
            self.name = "Sen. S. Egwu"
            self.phone = "8039665848"
            self.email = "drsamominyiegwu@gmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Ebonyi South" {
            self.name = "Sen. M. Nnachi"
            self.phone = "8034528595"
            self.email = "michaelamannachi@gmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Ebonyi Central" {
            self.name = "Sen. J. Ogba"
            self.phone = "8037791346"
            self.email = "onwaigboasa@yahoo.com"
        }
            
            // Edo
        else if menu[indexPath.section].names[indexPath.row] == "Edo North" {
            self.name = "Sen. F. Alimikhena"
            self.phone = "8155555884"
            self.email = "falimikhena@yahoo.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Edo South" {
            self.name = "Sen. M. Urhoghide"
            self.phone = "8033855557"
            self.email = "matthewurhoghide@yahoo.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Edo Central" {
            self.name = "Sen. C. Ordia"
            self.phone = "8038403877"
            self.email = "engineercliffordordia@gmail.com"
        }
            
            // Ekiti
        else if menu[indexPath.section].names[indexPath.row] == "Ekiti North" {
            self.name = "Sen. O. Adetumbi"
            self.phone = "8064487689"
            self.email = "senator.adetunmbi@gmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Ekiti South" {
            self.name = "Sen. A. Adeyeye"
            self.phone = "8023051100"
            self.email = "dadeyeye34@gmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Ekiti Central" {
            self.name = "Sen. M. Bamidele"
            self.phone = "80911112"
            self.email = "amicusng@gmail.com"
        }
            
            // Enugu
        else if menu[indexPath.section].names[indexPath.row] == "Enugu East" {
            self.name = "Sen. C. Nnamani"
            self.phone = "8022255522"
            self.email = "ebeanoglobal875@gmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Enugu West" {
            self.name = "Sen. I. Ekweremadu"
            self.phone = "8075757000"
            self.email = "ikeekweremadu@yahoo.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Enugu North" {
            self.name = "Sen. C. Utazi"
            self.phone = ""
            self.email = "chukwuka.utazi@nass.gov.ng"
        }
            
            // FCT
        else if menu[indexPath.section].names[indexPath.row] == "Abuja" {
            self.name = "Sen. A. Tanimu"
            self.phone = "8034509106"
            self.email = "philipaduda2@yahoo.com"
        }
            
            // Gombe
        else if menu[indexPath.section].names[indexPath.row] == "Gombe North" {
            self.name = "Sen. S. Alkali"
            self.phone = "8026032222"
            self.email = "saidualkali905@gmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Gombe South" {
            self.name = "Sen. A. Kilawangs"
            self.phone = ""
            self.email = "amos.kilawangs@nass.gov.ng"
        } else if menu[indexPath.section].names[indexPath.row] == "Gombe Central" {
            self.name = "Sen. D. Mohammed"
            self.phone = "7068686699"
            self.email = "mdgoje1@gmail.com"
        }
            
            // Imo
        else if menu[indexPath.section].names[indexPath.row] == "Imo East" {
            self.name = "Sen. E. Onyewuchi"
            self.phone = "8032012132"
            self.email = "ezeonyewuchi@gmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Imo West" {
            self.name = "Sen. R. Okorocha"
            self.phone = ""
            self.email = "rochas.okorocha@nass.gov.ng"
        } else if menu[indexPath.section].names[indexPath.row] == "Imo North" {
            self.name = "Sen. B. Uwajumogu"
            self.phone = ""
            self.email = "benjamin.uwajumogu@nass.gov.ng"
        }
            
            // Jigawa
        else if menu[indexPath.section].names[indexPath.row] == "Jigawa North East" {
            self.name = "Sen. I. Hadejia"
            self.phone = ""
            self.email = "ibrahim.hadejia@nass.gov.ng"
        } else if menu[indexPath.section].names[indexPath.row] == "Jigawa West" {
            self.name = "Sen. D. Sankara"
            self.phone = "8037032577"
            self.email = "dsankara@yahoo.co.uk"
        } else if menu[indexPath.section].names[indexPath.row] == "Jigawa South West" {
            self.name = "Sen. S. Mohammed"
            self.phone = "8022902648"
            self.email = "nakudu@yahoo.com"
        }
            
            // Kaduna
        else if menu[indexPath.section].names[indexPath.row] == "Kaduna North" {
            self.name = "Sen. S. Kwari"
            self.phone = "8033019005"
            self.email = "suleimankwari@yahoo.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Kaduna South" {
            self.name = "Sen. D. La'ah"
            self.phone = "8118887772"
            self.email = "laah.danjuma@yahoo.com"
        }
            
            // Kano
        else if menu[indexPath.section].names[indexPath.row] == "Kano North" {
            self.name = "Sen. I. Jibrin"
            self.phone = ""
            self.email = "ibrahim.jibrin@nass.gov.ng"
        } else if menu[indexPath.section].names[indexPath.row] == "Kano South" {
            self.name = "Sen. K. Gaya"
            self.phone = ""
            self.email = "kabiru.gaya@nass.gov.ng"
        } else if menu[indexPath.section].names[indexPath.row] == "Kano Central" {
            self.name = "Sen. I. Shekarau"
            self.phone = "8099199111"
            self.email = "ishekarau55@yahoo.com"
        }
            
            // Katsina
        else if menu[indexPath.section].names[indexPath.row] == "Katsina North" {
            self.name = "Sen. A. Babba-Kaita"
            self.phone = ""
            self.email = "ahmad.babba@nass.gov.ng"
        } else if menu[indexPath.section].names[indexPath.row] == "Katsina South" {
            self.name = "Sen. B. Mandiya"
            self.phone = ""
            self.email = "bellom2001@yahoo.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Katsina Central" {
            self.name = "Sen. K. Barkiya"
            self.phone = "8138360742"
            self.email = "barkamazadu00@yahoo.com"
        }
            
            // Kebbi
        else if menu[indexPath.section].names[indexPath.row] == "Kebbi North" {
            self.name = "Sen. Y. Abdullahi"
            self.phone = ""
            self.email = "yahaya.abdullahi@nass.gov.ng"
        } else if menu[indexPath.section].names[indexPath.row] == "Kebbi South" {
            self.name = "Sen. B. Na'Allah"
            self.phone = ""
            self.email = "bala.naallah@nass.gov.ng"
        } else if menu[indexPath.section].names[indexPath.row] == "Kebbi Central" {
            self.name = "Sen. M. Aliero"
            self.phone = "7066847000"
            self.email = "senatoraliero@yahoo.com"
        }
            
            // Kogi
        else if menu[indexPath.section].names[indexPath.row] == "Kogi East" {
            self.name = "Sen. J. Isah"
            self.phone = "8185651909"
            self.email = "isahj@ymail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Kogi Central" {
            self.name = "Sen. O. Yakubu"
            self.phone = "7032642674"
            self.email = "yakubu.oseni75@yahoo.com"
        }
            
            // Kwara
        else if menu[indexPath.section].names[indexPath.row] == "Kwara North" {
            self.name = "Sen. S. Kwari"
            self.phone = "8033019005"
            self.email = "suleimankwari@yahoo.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Kwara South" {
            self.name = "Sen. A. Yisa"
            self.phone = "7055221111"
            self.email = "ylashiru@gmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Kwara Central" {
            self.name = "Sen. I. Olorigbigbe"
            self.phone = "8033581695"
            self.email = "oloridoc@yahoo.com"
        }
            
            // Lagos
        else if menu[indexPath.section].names[indexPath.row] == "Lagos East" {
            self.name = "Sen. S. Adeola"
            self.phone = "8074000040"
            self.email = "adeolaolamilekan2005@yahoo.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Lagos West" {
            self.name = "Sen. S. Osinowo"
            self.phone = "8033049369"
            self.email = "bayoosinowo@gmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Lagos Central" {
            self.name = "Sen. Oluremi Tinubu"
            self.phone = "8095300251"
            self.email = "info@oluremitinubu.com"
        }
            
            // Nassarawa
        else if menu[indexPath.section].names[indexPath.row] == "Nassarawa East" {
            self.name = "Sen. G. Awkashiki"
            self.phone = "8099321703"
            self.email = "godiyaakwashiki123@gmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Nassarawa North" {
            self.name = "Sen. A. Adamu"
            self.phone = ""
            self.email = "abdullahi.adamu@nass.gov.ng"
        } else if menu[indexPath.section].names[indexPath.row] == "Nassarawa South" {
            self.name = "Sen. U. Almakura"
            self.phone = "8077253989"
            self.email = "tankoalmakura@yahoo.co.uk"
        }
            
            // Niger
        else if menu[indexPath.section].names[indexPath.row] == "Niger East" {
            self.name = "Sen. M. Musa"
            self.phone = "8033114615"
            self.email = "sani_313@hotmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Niger North" {
            self.name = "SEN. ALIYU ABDULLAHI"
            self.phone = "8052046555"
            self.email = "draliyuabdullahii@gmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Niger South" {
            self.name = "Sen. M. Bima"
            self.phone = "8173479797"
            self.email = "sangibima@gmail.com"
        }
            
            // Ogun
        else if menu[indexPath.section].names[indexPath.row] == "Ogun East" {
            self.name = "Sen. R. Mustapha"
            self.phone = "8033047403"
            self.email = "adeoshy@gmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Ogun West" {
            self.name = "Sen. T. Odebiyi"
            self.phone = "8036058080"
            self.email = "toluodebiyi@gmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Ogun Central" {
            self.name = "Sen. I. Amosun"
            self.phone = "8033213993"
            self.email = "amks2@yahoo.com"
        }
            
            // Ondo
        else if menu[indexPath.section].names[indexPath.row] == "Ondo North" {
            self.name = "Sen. R. Boroffice"
            self.phone = "8176406557"
            self.email = "rboroffice@yahoo.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Ondo South" {
            self.name = "Sen. N. Tofowomo"
            self.phone = "8054546666"
            self.email = "tofowomo_1960@yahoo.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Ondo Central" {
            self.name = "Sen. A. Akinyelure"
            self.phone = "8091707000"
            self.email = "akinyelure1@yahoo.com"
        }
            
            // Osun
        else if menu[indexPath.section].names[indexPath.row] == "Osun East" {
            self.name = "Sen. F. Fadahunsi"
            self.phone = "8052242211"
            self.email = "adefadahunsi19@gmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Osun West" {
            self.name = "Sen. A. Oriolowo"
            self.phone = "8033565979"
            self.email = "yemlee12@gmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Osun Central" {
            self.name = "Sen. S. Basiru"
            self.phone = "8034753343"
            self.email = "ajibolabasiru@hotmail.com"
        }
            
            // Oyo
        else if menu[indexPath.section].names[indexPath.row] == "Oyo North" {
            self.name = "Sen. B. Omotayo"
            self.phone = "8037053375"
            self.email = "rabab1004@yahoo.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Oyo South" {
            self.name = "Sen. A. Balogun"
            self.phone = "8132956057"
            self.email = "kbalogun7707@gmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Oyo Central" {
            self.name = "Sen. T. Folarin"
            self.phone = "8055544411"
            self.email = "yfolarin@gmail.com"
        }
            
            // Plateau
        else if menu[indexPath.section].names[indexPath.row] == "Plateau North" {
            self.name = "Sen. I. Gyang"
            self.phone = "8097777712"
            self.email = "dridgyang@gmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Plateau South" {
            self.name = "Senator I. Longjan"
            self.phone = "7044442045"
            self.email = "talk2longjan@gmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Plateau Central" {
            self.name = "Sen. H. Dimka"
            self.phone = "8033359443"
            self.email = "dewansamson4@gmail.com"
        }
            
            // Rivers
        else if menu[indexPath.section].names[indexPath.row] == "Rivers East" {
            self.name = "Sen. G. Sekibo"
            self.phone = ""
            self.email = "george.sekibo@nass.gov.ng"
        } else if menu[indexPath.section].names[indexPath.row] == "Rivers West" {
            self.name = "Sen. B. Apiafi"
            self.phone = ""
            self.email = "betty.apiafi@nass.gov.ng"
        } else if menu[indexPath.section].names[indexPath.row] == "Rivers South East" {
            self.name = "Sen. B. Mpigi"
            self.phone = "8037419000"
            self.email = "mpigib@yahoo.com"
        }
            
            // Sokoto
        else if menu[indexPath.section].names[indexPath.row] == "Sokoto East" {
            self.name = "Sen. A. Wamakko"
            self.phone = "7033181818"
            self.email = "abdullahi.gobir@nass.gov.ng"
        } else if menu[indexPath.section].names[indexPath.row] == "Sokoto North" {
            self.name = "SEN. ALIYU ABDULLAHI"
            self.phone = "8052046555"
            self.email = "amwamakko@yahoo.com"
        }
            
            // Taraba
        else if menu[indexPath.section].names[indexPath.row] == "Taraba North" {
            self.name = "Sen. S. Lau"
            self.phone = ""
            self.email = "shuaibu.lau@nass.gov.ng"
        } else if menu[indexPath.section].names[indexPath.row] == "Taraba South" {
            self.name = "Sen. E. Bwacha"
            self.phone = "7063795588"
            self.email = "info@senatorbwacha.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Taraba Central" {
            self.name = "Sen. Y. Yusuf"
            self.phone = "8033109493"
            self.email = "yusufawakili@gmail.com"
        }
            
            // Yobe
        else if menu[indexPath.section].names[indexPath.row] == "Yobe East" {
            self.name = "Sen. I. Gaidam"
            self.phone = ""
            self.email = "ibrahim.gaidam@nass.gov.ng"
        } else if menu[indexPath.section].names[indexPath.row] == "Yobe North" {
            self.name = "Senate President Lawan"
            self.phone = "7055090323"
            self.email = ""
        } else if menu[indexPath.section].names[indexPath.row] == "Yobe South" {
            self.name = "Sen. I. Bomai"
            self.phone = ""
            self.email = "ibrahim.bomami@nass.gov.ng"
        }
            
            // Zamfara
        else if menu[indexPath.section].names[indexPath.row] == "Zamfara West" {
            self.name = "Sen. A. Yari"
            self.phone = "8033412454"
            self.email = "yariabdulazeez@gmail.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Zamfara North" {
            self.name = "Sen. K. Tijani"
            self.phone = "8186567173"
            self.email = "tykaura@yahoo.com"
        } else if menu[indexPath.section].names[indexPath.row] == "Zamfara Central" {
            self.name = "Sen. H. Gusau"
            self.phone = ""
            self.email = "hassan.gusau@nass.gov.ng"
        }
        
        showAlertWithContactInfo(title: title, name: self.name, phone: self.phone, email: self.email)
    }
    
    @objc private func handleHeaderToggle(button: UIButton) {
        let section = button.tag
        
        var indexPaths = [IndexPath]()
        
        for row in menu[section].names.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let isExpanded = menu[section].isExpanded
        menu[section].isExpanded = !isExpanded
        
        if isExpanded {
            officialsTableView.deleteRows(at: indexPaths, with: .automatic)
        } else {
            officialsTableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
    
    @objc private func showAlertWithContactInfo(title: String, name: String, phone: String, email: String) {
        let alertController = UIAlertController(title: title, message: "How do you want to contact \(name)?", preferredStyle: .alert)
        
        let emailAction = UIAlertAction(title: "Email", style: .default, handler: { (action) in
            if self.email == "" {
                self.alert(message: "No email Available", title: "Yuut!")
            } else {
                self.sendEmail(name: name, email: email)
            }
        })
        
        let callAction = UIAlertAction(title: "Phone Call", style: .destructive, handler: { (action) in
            if self.phone == "" {
                self.alert(message: "No number Available", title: "Yuut!")
            } else {
                if let url = URL(string: "tel://+234\(phone)") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(emailAction)
        alertController.addAction(callAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func sendEmail(name: String, email: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            
            present(mail, animated: true)
        } else {
            self.alert(message: "Unable to send Mail Currently. Please try again later.", title: "Error")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}

// Custom cell for buttons
class ActionCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    let actionTitle: AuthLabel = {
        let label = AuthLabel()
        label.textColor = ColorConstants.primaryColor
        return label
    }()
    
    private func configureUI() {
        addSubview(actionTitle)
        
        _ = actionTitle.anchor(left: safeAreaLayoutGuide.leadingAnchor, centerY: centerYAnchor, leftConstant: 36)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class StoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextViewDelegate {
    
    override func viewDidLoad() {
        configureUI()
        fetchStories()
    }
    
    // Initialize stories
    var stories: [Story]? = [] {
        didSet {
            DispatchQueue.main.async {
                self.storiesCollectionView.reloadData()
            }
        }
    }
    
    let cellId = "cellId"
    
    let storyTextField: UITextView = {
        let textField = UITextView()
        textField.autocapitalizationType = .sentences
        textField.textColor = .lightGray
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 5
        textField.tintColor = .lightGray
        textField.text = "Share a Story. Max 240 Characters"
        return textField
    }()
    
    let postButton: AuthButton =  {
        let button = AuthButton()
        button.layer.backgroundColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 15
        button.setTitle("Post Anonymously", for: .normal)
        button.addTarget(self, action: #selector(postStory), for: .touchUpInside)
        return button
    }()
    
    let storiesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = true
        collectionView.clipsToBounds = true
        return collectionView
    }()
    
    private func configureUI() {
        view.backgroundColor = .white
        
        storyTextField.delegate = self
        
        storiesCollectionView.delegate = self
        storiesCollectionView.dataSource = self
        storiesCollectionView.register(GenericCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        view.addSubview(storyTextField)
        view.addSubview(postButton)
        view.addSubview(storiesCollectionView)
        
        _ = storyTextField.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leadingAnchor, right: view.safeAreaLayoutGuide.trailingAnchor, topConstant: 12, leftConstant: 16, rightConstant: 16, heightConstant: 100)
        _ = postButton.anchor(storyTextField.bottomAnchor, left: storyTextField.leadingAnchor, right: storyTextField.trailingAnchor, topConstant: 12, heightConstant: 40)
        _ = storiesCollectionView.anchor(postButton.bottomAnchor, left: view.leadingAnchor, bottom: view.bottomAnchor, right: view.trailingAnchor, topConstant: 12)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == storyTextField {
            if storyTextField.textColor == .lightGray {
                storyTextField.text = ""
                storyTextField.textColor = .white
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == storyTextField {
            if storyTextField.text == "" {
                storyTextField.text = "Share a Story. Max 240 Characters"
                storyTextField.textColor = .lightGray
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.count + (text.count - range.length) <= 240
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GenericCollectionViewCell
        
        cell.layer.backgroundColor = ColorConstants.primaryColor.cgColor
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 2
        
        cell.story = stories?[indexPath.item]
        
        let slug = stories?[indexPath.item].slug ?? ""
        
        cell.reportAction = { (cellAction) in
            print("Reported \(slug)")
            
            let alertController = UIAlertController(title: "Report Story", message: "Did you find the content of this story Offensive?", preferredStyle: .actionSheet)
            let reportAction = UIAlertAction(title: "Yes, Report it", style: .destructive, handler: { (action) in
                // Login
                let loginHeaders: HTTPHeaders = ["Content-Type": "application/json"]
                let loginParameters: [String: Any] = [
                    "email": "jide@gidieats.com",
                    "password": "jidejide"
                ]
                
                AF.request("https://api.gidieats.com/api/v1/accounts/login", method: .post, parameters: loginParameters, encoding: JSONEncoding.default, headers: loginHeaders).responseJSON { response in
                    
                    let info = serializeResponse(data: response.data ?? Data())
                    switch response.result {
                    case .success(_):
                        if info["isSuccess"] as? Bool ?? false == true {
                            if info["data"] != nil {
                                let userData = info["data"] as? [String: Any] ?? [:]
                                let role = userData["roles"] as? [String] ?? [""]
                                
                                if role.contains("Partner") == true {
                                    let token = userData["token"] as? String ?? ""
                                    let refreshToken = userData["refreshToken"] as? String ?? ""
                                    
                                    print(token)
                                    print(refreshToken)
                                    
                                    // Add Story
                                    let deleteHeaders: HTTPHeaders = ["Content-Type": "application/json",
                                                                      "Authorization": "Bearer \(token)"
                                    ]
                                    
                                    AF.request("https://api.gidieats.com/api/v1/deals/\(slug)", method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: deleteHeaders).responseJSON { response in
                                        
                                        print(response.debugDescription)
                                        
                                        let info = serializeResponse(data: response.data ?? Data())
                                        switch response.result {
                                        case .success(_):
                                            if info["isSuccess"] as? Bool ?? false == true {
                                                if info["data"] != nil {
                                                    
                                                    // Logout
                                                    let logoutHeaders: HTTPHeaders = ["Content-Type": "application/json",
                                                                                      "Authorization": "Bearer \(token)"
                                                    ]
                                                    
                                                    let logoutParameters: [String: Any] = ["refreshToken": refreshToken]
                                                    
                                                    AF.request("https://api.gidieats.com/api/v1/accounts/logout", method: .post, parameters: logoutParameters, encoding: JSONEncoding.default, headers: logoutHeaders).responseJSON { response in
                                                        
                                                        let info = serializeResponse(data: response.data ?? Data())
                                                        switch response.result {
                                                        case .success(_):
                                                            if info["isSuccess"] as? Bool ?? false == true {
                                                                self.fetchStories()
                                                                self.alert(message: "Thanks for pointing this out. Yuut! strives to improve it's safety everyday.", title: "Yuut!")
                                                            } else {
                                                                self.alert(message: "Something went wrong. Please try again", title: "Yuut!")
                                                            }
                                                        case .failure(_):
                                                            self.alert(message: "Something went wrong. Please try again", title: "Yuut!")
                                                        }
                                                    }
                                                    // End logout
                                                    
                                                }
                                            } else {
                                                self.alert(message: "Something went wrong. Please try again", title: "Yuut!")
                                            }
                                        case .failure (_):
                                            self.alert(message: "Something went wrong. Please try again", title: "Yuut!")
                                        }
                                    }
                                    // End report
                                    
                                } else {
                                    self.alert(message: "Something went wrong. Please try again", title: "Yuut!")
                                }
                            }
                        } else {
                            self.alert(message: "Something went wrong. Please try again", title: "Yuut!")
                        }
                    case .failure(_):
                        self.alert(message: "Something went wrong. Please try again", title: "Yuut!")
                    }
                }
                // End Login
            })
            
            let ignoreAction = UIAlertAction(title: "No it's not", style: .cancel, handler: nil)
            
            alertController.addAction(reportAction)
            alertController.addAction(ignoreAction)
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                alertController.popoverPresentationController?.sourceRect = cell.reportButton.frame
                alertController.popoverPresentationController?.sourceView = cell
            } else {
                alertController.popoverPresentationController?.sourceView = self.view
            }
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: UIScreen.main.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let data = stories?[indexPath.item].story
        let contentBound = data?.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont(name: "Optima", size: 18)!], context: nil)
        
        return CGSize(width: (contentBound?.width ?? 0) - 32, height: (contentBound?.height ?? 0) + 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
    }
    
    @objc private func postStory() {
        view.endEditing(true)
        
        let storyString = storyTextField.text!
        
        if storyString == "Share a Story. Max 240 Characters" {
            self.alert(message: "Write an actual story", title: "Yuut!")
        } else {
            
            if storyString == "" {
                self.alert(message: "Enter a story", title: "Yuut!")
            } else if (storyString.lowercased()).contains("#endsars") || (storyString.lowercased()).contains("#sarsmustend") || (storyString.lowercased()).contains("#endswat") {
                self.alert(message: "Please remove any potentially harmful comment", title: "Yuut!")
            } else if storyString.count > 240 {
                self.alert(message: "Max 240 Characters", title: "Yuut!")
            } else if storyString.count < 140 {
                self.alert(message: "Min 140 Characters", title: "Yuut!")
            } else {
                postButton.setTitle("", for: .normal)
                postButton.addSpinner()
                
                // Login
                let loginHeaders: HTTPHeaders = ["Content-Type": "application/json"]
                let loginParameters: [String: Any] = [
                    "email": "jide@gidieats.com",
                    "password": "jidejide"
                ]
                
                AF.request("https://api.gidieats.com/api/v1/accounts/login", method: .post, parameters: loginParameters, encoding: JSONEncoding.default, headers: loginHeaders).responseJSON { response in
                    
                    let info = serializeResponse(data: response.data ?? Data())
                    switch response.result {
                    case .success(_):
                        if info["isSuccess"] as? Bool ?? false == true {
                            if info["data"] != nil {
                                let userData = info["data"] as? [String: Any] ?? [:]
                                let role = userData["roles"] as? [String] ?? [""]
                                
                                if role.contains("Partner") == true {
                                    let token = userData["token"] as? String ?? ""
                                    let refreshToken = userData["refreshToken"] as? String ?? ""
                                    
                                    print(token)
                                    print(refreshToken)
                                    
                                    // Add Story
                                    let storyHeaders: HTTPHeaders = ["Content-Type": "application/json",
                                                                     "Authorization": "Bearer \(token)"
                                    ]
                                    
                                    let storyParameters: [String: Any] = [
                                        "name": storyString,
                                        "description": "N/A",
                                        "discountPrice": 1000,
                                        "valuePrice": 2000,
                                        "expiryDate": "01/01/2022",
                                        "imageUrl": "https://www.google.com"
                                    ]
                                    
                                    AF.request("https://api.gidieats.com/api/v1/deals", method: .post, parameters: storyParameters, encoding: JSONEncoding.default, headers: storyHeaders).responseJSON { response in
                                        
                                        print(response.debugDescription)
                                        
                                        let info = serializeResponse(data: response.data ?? Data())
                                        switch response.result {
                                        case .success(_):
                                            if info["isSuccess"] as? Bool ?? false == true {
                                                if info["data"] != nil {
                                                    
                                                    // Logout
                                                    let logoutHeaders: HTTPHeaders = ["Content-Type": "application/json",
                                                                                      "Authorization": "Bearer \(token)"
                                                    ]
                                                    
                                                    let logoutParameters: [String: Any] = ["refreshToken": refreshToken]
                                                    
                                                    AF.request("https://api.gidieats.com/api/v1/accounts/logout", method: .post, parameters: logoutParameters, encoding: JSONEncoding.default, headers: logoutHeaders).responseJSON { response in
                                                        
                                                        let info = serializeResponse(data: response.data ?? Data())
                                                        switch response.result {
                                                        case .success(_):
                                                            if info["isSuccess"] as? Bool ?? false == true {
                                                                
                                                                DispatchQueue.main.async {
                                                                    self.fetchStories()
                                                                    self.postButton.removeSpinner()
                                                                    self.postButton.setTitle("Post Anonymously", for: .normal)
                                                                    self.storyTextField.text = "Share a Story. Max 240 Characters"
                                                                    self.storyTextField.textColor = .lightGray
                                                                }
                                                                
                                                            } else {
                                                                DispatchQueue.main.async {
                                                                    self.postButton.removeSpinner()
                                                                    self.postButton.setTitle("Post Anonymously", for: .normal)
                                                                    self.storyTextField.text = "Share a Story. Max 240 Characters"
                                                                    self.storyTextField.textColor = .lightGray
                                                                }
                                                                self.alert(message: "Something went wrong. Please try again", title: "Yuut!")
                                                            }
                                                        case .failure(_):
                                                            DispatchQueue.main.async {
                                                                self.postButton.removeSpinner()
                                                                self.postButton.setTitle("Post Anonymously", for: .normal)
                                                                self.storyTextField.text = "Share a Story. Max 240 Characters"
                                                                self.storyTextField.textColor = .lightGray
                                                            }
                                                            self.alert(message: "Something went wrong. Please try again", title: "Yuut!")
                                                        }
                                                    }
                                                    // End logout
                                                    
                                                }
                                            } else {
                                                DispatchQueue.main.async {
                                                    self.postButton.removeSpinner()
                                                    self.postButton.setTitle("Post Anonymously", for: .normal)
                                                    self.storyTextField.text = "Share a Story. Max 240 Characters"
                                                    self.storyTextField.textColor = .lightGray
                                                }
                                                self.alert(message: "Something went wrong. Please try again", title: "Yuut!")
                                            }
                                        case .failure (_):
                                            DispatchQueue.main.async {
                                                self.postButton.removeSpinner()
                                                self.postButton.setTitle("Post Anonymously", for: .normal)
                                                self.storyTextField.text = "Share a Story. Max 240 Characters"
                                                self.storyTextField.textColor = .lightGray
                                            }
                                            self.alert(message: "Something went wrong. Please try again", title: "Yuut!")
                                        }
                                    }
                                    // End adding Story
                                    
                                } else {
                                    DispatchQueue.main.async {
                                        self.postButton.removeSpinner()
                                        self.postButton.setTitle("Post Anonymously", for: .normal)
                                        self.storyTextField.text = "Share a Story. Max 240 Characters"
                                        self.storyTextField.textColor = .lightGray
                                    }
                                    self.alert(message: "Something went wrong. Please try again", title: "Yuut!")
                                }
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.postButton.removeSpinner()
                                self.postButton.setTitle("Post Anonymously", for: .normal)
                                self.storyTextField.text = "Share a Story. Max 240 Characters"
                                self.storyTextField.textColor = .lightGray
                            }
                            self.alert(message: "Something went wrong. Please try again", title: "Yuut!")
                        }
                    case .failure(_):
                        DispatchQueue.main.async {
                            self.postButton.removeSpinner()
                            self.postButton.setTitle("Post Anonymously", for: .normal)
                            self.storyTextField.text = "Share a Story. Max 240 Characters"
                            self.storyTextField.textColor = .lightGray
                        }
                        self.alert(message: "Something went wrong. Please try again", title: "Yuut!")
                    }
                }
                // End Login
                
            }
        }
    }
    
    @objc func fetchStories() {
        
        // Add spinner to navBar and sstart animating
        DispatchQueue.main.async {
            self.networkLoaderStart()
        }
        
        let urlString = "https://api.gidieats.com/api/v1/deals?pageNumber=0&itemsPerPage=20"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                _ = error
                return
            }
            do {
                let jsonData = try JSONDecoder().decode(StoryData.self, from: data!)
                
                print(jsonData)
                
                self.stories = [Story]()
                
                for dictionary in jsonData.data {
                    let story = Story(slug: dictionary.slug, story: dictionary.story, timeCreated: dictionary.timeCreated)
                    self.stories?.append(story)
                }
                
                // Stop spinner
                DispatchQueue.main.async {
                    self.networkLoaderStop()
                }
                
                DispatchQueue.main.async {
                    if self.stories?.count ?? 0 == 0 {
                        self.alert(message: "No Story has been shared yet. Be the first.", title: "Yuut!")
                    }
                }
                
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
    
}

class GenericCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    var story: Story? {
        didSet {
            if let story = story?.story {
                storyLabel.text = story
            }
            if let timeCreated = story?.timeCreated {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMMM dd, yyyy"
                let date = dateFormatter.date(from: timeCreated)
                dateFormatter.dateFormat = "EEE MMM dd, yyyy"
                let newDate = dateFormatter.string(from: date ?? Date())
                
                timeCreatedLabel.text = newDate
            }
        }
    }
    
    var reportAction: ((UICollectionViewCell) -> Void)?
    
    let storyLabel: AuthLabel = {
        let label = AuthLabel()
        label.numberOfLines = 0
        return label
    }()
    
    let timeCreatedLabel: AuthLabel = {
        let label = AuthLabel()
        label.font = label.font.withSize(12)
        label.textColor = .lightGray
        return label
    }()
    
    let reportButton: AuthButton = {
        let button = AuthButton()
        button.setTitle("Report", for: .normal)
        return button
    }()
    
    private func configureUI() {
        backgroundColor = .white
        
        reportButton.addTarget(self, action: #selector(reportStory), for: .touchUpInside)
        
        addSubview(storyLabel)
        addSubview(timeCreatedLabel)
        addSubview(reportButton)
        
        _ = storyLabel.anchor(safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leadingAnchor, right: safeAreaLayoutGuide.trailingAnchor, topConstant: 12, leftConstant: 16, rightConstant: 16)
        _ = reportButton.anchor(left: storyLabel.leadingAnchor ,bottom: safeAreaLayoutGuide.bottomAnchor, bottomConstant: -4)
        _ = timeCreatedLabel.anchor(right: storyLabel.trailingAnchor, centerY: reportButton.centerYAnchor)
    }
    
    @objc func reportStory() {
        reportAction?(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct Story: Decodable {
    var slug, story, timeCreated: String?
    
    enum CodingKeys: String, CodingKey {
        case slug
        case story = "name"
        case timeCreated
    }
}

struct StoryData: Decodable {
    var data: [Story]
    var page: Int?
    var size: Int?
    var count: Int?
    var status: Int?
    var isSuccess: Bool?
}

//Serializing data from backend
public func serializeResponse(data: Data) -> [String: Any] {
    do {
        let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        return result ?? [:]
    } catch _ {
        return [:]
    }
}
