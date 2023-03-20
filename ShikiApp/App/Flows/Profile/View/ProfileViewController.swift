//
//  ProfileViewController.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 21.01.2023.
//

import UIKit

final class ProfileViewController: (UIViewController & ProfileViewInputProtocol) {

    // MARK: - Properties
    
    let presenter: ProfileViewOutputProtocol
    var model: UserViewModel?
    var isAuth: Bool {
        didSet {
            configureUI()
        }
    }

    // MARK: - Private Properties
    
    private let lineHeight: CGFloat = 1.0
    private let imageWidth: CGFloat = 100.0
    private let linkImgWidth: CGFloat = 16.0
    private let trailing: CGFloat = -16.0
    private let leading: CGFloat = 12.0
    private let leadingForLinkButton: CGFloat = 4.0
    private let topInset: CGFloat = 24.0
    private let bottom: CGFloat = -48.0
    private let versionLabelTopInset: CGFloat = 8.0
    private var ageLabelText = ""
    private var sexLabelText = ""
    
    private let topDivider: UIView = {
        let dividerView = UIView()
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.layer.borderWidth = 1
        dividerView.layer.borderColor = AppColor.line.cgColor
        return dividerView
    }()
    
    private let profileImageView: UIImageViewAsync = {
        let imageView = UIImageViewAsync()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 50
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = AppFont.Style.title
        label.textColor = AppColor.textMain
        return label
    }()
    
    private let sexAndAgeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = AppFont.Style.regularText
        label.textColor = AppColor.textMain
        return label
    }()
    
    private let linkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = AppColor.textMinor
        return imageView
    }()
    
    private let linkButton: UIButton = {
        let button = UIButton(type: .system)
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = AppFont.Style.regularText
        button.titleLabel?.textColor = AppColor.accent
        return button
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = AppColor.red
        button.titleLabel?.font = AppFont.Style.regularText
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    private let versionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFont.Style.subtitle
        label.textColor = AppColor.textMinor
        return label
    }()
    

    // MARK: - Construction
    
    init(presenter: ProfileViewOutputProtocol) {
        self.presenter = presenter
        self.isAuth = presenter.isAuth()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
    }

    // MARK: - Private functions
    
    @objc private func didPressedLogoutButton() {
        presenter.didPressedLogoutButton()
    }
    
    @objc private func didPressedLinkButton() {
        presenter.didPressedLinkButton()
    }
    
    private func configureLogoutButton() {
        let title = isAuth ? Texts.ButtonTitles.logout : Texts.ButtonTitles.login
        logoutButton.setTitle(title, for: .normal)
        logoutButton.addTarget(self, action: #selector(didPressedLogoutButton), for: .touchUpInside)
    }
    
    private func configureLinkButton() {
        linkButton.addTarget(self, action: #selector(didPressedLinkButton), for: .touchUpInside)
    }
    
    private func setupViews() {
        view.addSubviews([
            topDivider,
            profileImageView,
            nameLabel,
            sexAndAgeLabel,
            linkImageView,
            linkButton,
            logoutButton,
            versionLabel
        ])
    }
    
    private func configureUI() {
        setupViews()
        configureConstraints()
        configureLogoutButton()
        configureLinkButton()
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        versionLabel.text =  "Версия \(version ?? "?")"
        
        if let model {
            if model.website == "" || model.website == nil {
                linkImageView.image = nil
            } else {
                linkImageView.image = AppImage.OtherIcons.link
            }
            linkButton.setTitle(model.website, for: .normal)
            nameLabel.text = model.nickname
            if let age = model.fullYears { ageLabelText = String(age) }
            if let imageURLString = model.avatarURLString {
                profileImageView.downloadedImage(from: imageURLString)
            } else {
                profileImageView.image = AppImage.ErrorsIcons.noUserpicIcon
            }
            sexAndAgeLabel.text = (model.sex ?? "") + ageLabelText
        } else {
            linkImageView.image = nil
            linkButton.setTitle("", for: .normal)
            nameLabel.text = ""
            ageLabelText = ""
            profileImageView.image = nil
            sexAndAgeLabel.text = ""
        }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            topDivider.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topDivider.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topDivider.heightAnchor.constraint(equalToConstant: lineHeight),
            topDivider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topInset),
            
            profileImageView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: leading
            ),
            profileImageView.topAnchor.constraint(equalTo: topDivider.bottomAnchor, constant: topInset),
            profileImageView.widthAnchor.constraint(equalToConstant: imageWidth),
            profileImageView.heightAnchor.constraint(equalToConstant: imageWidth),
            
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: leading),
            nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: topInset),
            nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: trailing),
            
            sexAndAgeLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: leading),
            sexAndAgeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            sexAndAgeLabel.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: trailing
            ),
            
            linkImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: leading),
            linkImageView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -trailing),
            linkImageView.widthAnchor.constraint(equalToConstant: linkImgWidth),
            linkImageView.heightAnchor.constraint(equalToConstant: linkImgWidth),
            
            linkButton.leadingAnchor.constraint(equalTo: linkImageView.trailingAnchor, constant: leadingForLinkButton),
            linkButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 5),
            linkButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: trailing),
            
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: bottom),
            
            versionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            versionLabel.topAnchor.constraint(equalTo: logoutButton.bottomAnchor, constant: versionLabelTopInset)
        ])
    }
}
