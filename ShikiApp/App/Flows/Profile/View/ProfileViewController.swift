//
//  ProfileViewController.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 21.01.2023.
//

import UIKit

class ProfileViewController: (UIViewController & ProfileViewInputProtocol) {

    // MARK: - Properties

    let presenter: ProfileViewOutputProtocol
    var model: UserViewModel?
    var isAuth: Bool {
        didSet {
            configureLogoutButton()
        }
    }

    // MARK: - Private Properties

    private let lineHeight: CGFloat = 1
    private let imageWidth: CGFloat = 100
    private let linkImgWidth: CGFloat = 16
    private let trailing = -16.0
    private let leading = 12.0
    private let leadingForLinkButton = 5.84
    private let topInset = 24.0
    private let bottom = -48.0
    private let versionLabelTopInset = 8


    private let topDivider: UIView = {
        let dividerView = UIView()
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.layer.borderWidth = 1
        dividerView.layer.borderColor = AppColor.line.cgColor
        return dividerView
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 50
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = AppFont.openSansFont(ofSize: 20, weight: .semiBold)
        label.textColor = AppColor.textMain
        return label
    }()

    private let sexAndAgeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = AppFont.openSansFont(ofSize: 16, weight: .regular)
        label.textColor = AppColor.textMain
        return label
    }()

    private let linkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = AppColor.textMinor
        imageView.image = AppImage.OtherIcons.link
        return imageView
    }()

    private let linkButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = AppFont.openSansFont(ofSize: 16, weight: .regular)
        button.titleLabel?.textColor = AppColor.accent
        return button
    }()

    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = AppColor.red
        button.titleLabel?.font = AppFont.openSansFont(ofSize: 16, weight: .regular)
        button.titleLabel?.textAlignment = .center
        return button
    }()

    private let versionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFont.openSansFont(ofSize: 12, weight: .regular)
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
        configureUI()
        presenter.fetchData()
    }

    // MARK: - Functions
    
    @objc func didPressedLogoutButton() {
        presenter.didPressedLogoutButton()
    }

    // MARK: - Private functions

    private func configureLogoutButton() {
        let loginItem = UIBarButtonItem(
            image: isAuth ? AppImage.NavigationsBarIcons.logout : AppImage.NavigationsBarIcons.login,
            style: .plain,
            target: self,
            action: #selector(didPressedLogoutButton)
        )
        loginItem.tintColor = AppColor.textMain
        navigationItem.rightBarButtonItem = loginItem
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
        setupConstraints1()
        setupConstraints2()
        profileImageView.image = AppImage.ErrorsIcons.noUserpicIcon
        nameLabel.text = Texts.DummyTextForProfileVC.nameLabelText
        sexAndAgeLabel.text = Texts.DummyTextForProfileVC.sexAndAgeLabelText
        linkButton.setTitle(Texts.DummyTextForProfileVC.webLinkText, for: .normal)
        logoutButton.setTitle(Texts.DummyTextForProfileVC.logoutButtonText, for: .normal)
        versionLabel.text = Texts.DummyTextForProfileVC.versionLabelText
    }

    private func setupConstraints1() {
        NSLayoutConstraint.activate([
            topDivider.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topDivider.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topDivider.heightAnchor.constraint(equalToConstant: lineHeight),
            topDivider.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topInset
            ),
      
            profileImageView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: leading
            ),
            profileImageView.topAnchor.constraint(
                equalTo: topDivider.bottomAnchor, constant: topInset
            ),
            profileImageView.widthAnchor.constraint(equalToConstant: imageWidth),
            profileImageView.heightAnchor.constraint(equalToConstant: imageWidth),
      
            nameLabel.leadingAnchor.constraint(
                equalTo: profileImageView.trailingAnchor, constant: leading
            ),
            nameLabel.topAnchor.constraint(
                equalTo: profileImageView.topAnchor, constant: topInset
            ),
            nameLabel.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: trailing
            )
        ])
    }
    
    private func setupConstraints2() {
        NSLayoutConstraint.activate([
            sexAndAgeLabel.leadingAnchor.constraint(
                equalTo: profileImageView.trailingAnchor, constant: leading
            ),
            sexAndAgeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            sexAndAgeLabel.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: trailing
            ),
      
            linkImageView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: leading
            ),
            linkImageView.topAnchor.constraint(
                equalTo: profileImageView.bottomAnchor, constant: -trailing
            ),
            linkImageView.widthAnchor.constraint(equalToConstant: linkImgWidth),
            linkImageView.heightAnchor.constraint(equalToConstant: linkImgWidth),
      
            linkButton.leadingAnchor.constraint(
                equalTo: linkImageView.trailingAnchor, constant: leadingForLinkButton
            ),
            linkButton.topAnchor.constraint(
                equalTo: profileImageView.bottomAnchor, constant: 5
            ),
      
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: bottom
            ),
      
            versionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            versionLabel.topAnchor.constraint(
                equalTo: logoutButton.bottomAnchor,
                constant: CGFloat(versionLabelTopInset)
            )
        ])
    }
}
