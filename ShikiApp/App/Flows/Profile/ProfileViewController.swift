//
//  ProfileViewController.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 21.01.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var userUrlString: String = ""
    
    // MARK: - Properties
    // Canvas view
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        view.addSubview(topGrayDivider)
        topGrayDivider.backgroundColor = .systemGray6
        topGrayDivider.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 1)
        
        view.addSubview(profileImageView)
        profileImageView.anchor(top: topGrayDivider.bottomAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 16, width: 100, height: 100)
        
        view.addSubview(nameLabel)
        nameLabel.anchor(top: topGrayDivider.bottomAnchor, left: profileImageView.rightAnchor, paddingTop: 32, paddingLeft: 8)
        
        view.addSubview(sexLabel)
        sexLabel.anchor(top: nameLabel.bottomAnchor, left: profileImageView.rightAnchor, paddingTop: 5, paddingLeft: 8)
        
        view.addSubview(ageLabel)
        ageLabel.anchor(top: nameLabel.bottomAnchor, left: sexLabel.rightAnchor, paddingTop: 5, paddingLeft: 5)
        
        view.addSubview(linkImageView)
        linkImageView.anchor(top: profileImageView.bottomAnchor, left: view.leftAnchor, paddingTop: 12, paddingLeft: 15)
        
        view.addSubview(websiteButton)
        websiteButton.anchor(top: profileImageView.bottomAnchor, left: linkImageView.rightAnchor, paddingTop: 7, paddingLeft: 5)
        
        view.addSubview(logoutButton)
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.anchor(bottom: view.bottomAnchor, paddingBottom: 48)
        
        view.addSubview(versionLabel)
        versionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        versionLabel.anchor(top: logoutButton.bottomAnchor, paddingTop: 5)
        
        view.addSubview(bottomGrayDivider)
        bottomGrayDivider.backgroundColor = .systemGray6
        bottomGrayDivider.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,  paddingBottom: 1, height: 1)
        
        return view
    }()
    
    let topGrayDivider: UIView = {
        let dividerView = UIView()
        dividerView.backgroundColor = .black
        return dividerView
    }()
    
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = UIColor.systemGray3
        //Circle cut
        //imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .darkGray
        return label
    }()
    
    let sexLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .systemGray2
        return label
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .systemGray2
        return label
    }()
    
    let linkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor.systemGray2
        imageView.image = UIImage(systemName: "link")
        return imageView
    }()
    
    let websiteButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.textAlignment = .left
        button.addTarget(ProfileViewController.self, action: #selector(handleUserWebpage), for: .touchUpInside)
        return button
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выйти из аккаунта", for: .normal)
        button.tintColor = .red
        button.titleLabel?.textAlignment = .center
        //button.addTarget(ProfileViewController.self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()
    
    let versionLabel: UILabel = {
        let label = UILabel()
        label.text = "Версия 1.0.0 (1)"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .systemGray3
        return label
    }()
    
    let bottomGrayDivider: UIView = {
        let dividerView = UIView()
        return dividerView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Профиль"
        fetchProfile()
        view.backgroundColor = .systemBackground
        
        view.addSubview(containerView)
        
        containerView.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: view.height/5, width: view.width, height: view.height/5*3.5)
    }
    
    private func fetchProfile() {
        APICaller.shared.getCurrentUserProfile { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.updateUI(with: model)
                case .failure(let error):
                    print("Profile Error: \(error.localizedDescription)")
                    self?.failedToGetProfile()
                }
            }
        }
    }
    
    private func updateUI(with model: UserProfileDTO) {
       
        if let imageUrl = URL(string: model.image?.x148 ?? "") {
            profileImageView.loadImageFromURL(url: imageUrl)
        } else {
            return
        }
            
        nameLabel.text = model.nickname
        websiteButton.setTitle(model.website, for: .normal)
        
        if let ageString = model.fullYears {
            ageLabel.text = String(ageString)
        }
        
        
        if model.sex == "male" || model.sex == "female" {
            if model.fullYears ?? 0 > 0 {
            let sexValueInRussian = model.sex != "male" ? "женщина," : "мужчина,"
            sexLabel.text = sexValueInRussian
            } else {
                let sexValueInRussian = model.sex != "male" ? "женщина" : "мужчина"
                sexLabel.text = sexValueInRussian
                }
        } else {
            return
        }
        
        userUrlString = model.website ?? "shikimori.one"
        print(userUrlString)
    }
    
    private func failedToGetProfile() {
        let label = UILabel(frame: .zero)
        label.text = "Не удалось загрузить профиль"
        label.sizeToFit()
        label.textColor = .black
        view.addSubview(label)
        label.center = view.center
    }
    
    // MARK: - Selectors
    
    @objc func handleUserWebpage() {
        if let url = URL(string: "https://"+userUrlString) {
                    UIApplication.shared.open(url)
        }
    }
    
    @objc func handleLogout() {
        print("Выход из приложения")
    }
}

// MARK: - enables custom color, intakes same integer numbers, as in Storyboard custom window
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let mainBlue = UIColor.rgb(red: 0, green: 150, blue: 255)
}

// MARK: - enables layout without Storyboard. Good for use in future projects.
extension UIView {
    ///When we call anchor, we do not always input all params, hence optionals
    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        paddingTop: CGFloat? = 0,
        paddingLeft: CGFloat? = 0,
        paddingBottom: CGFloat? = 0,
        paddingRight: CGFloat? = 0,
        width: CGFloat? = nil,
        height: CGFloat? = nil
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
                //We can force unwrap here because we know it's always have a default value
                topAnchor.constraint(equalTo: top, constant: paddingTop!).isActive = true
        }
        
        if let left = left {
                leftAnchor.constraint(equalTo: left, constant: paddingLeft!).isActive = true
        }
        
        if let bottom = bottom {
            if let paddingBottom = paddingBottom {
                bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
            }
        }
        
        if let right = right {
            if let paddingRight = paddingRight {
                rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
            }
        }
        
        if let width = width {
                widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
                heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

// MARK: - basic image loader (no cashing)
extension UIImageView {
    func loadImageFromURL(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
