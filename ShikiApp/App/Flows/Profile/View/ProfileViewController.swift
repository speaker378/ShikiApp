//
//  ProfileViewController.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 21.01.2023.
//

//  As per https://www.youtube.com/watch?v=2z5uWBRGjFI
//  Layouts per Akulov Ivan, https://youtu.be/T92q6dHyE0E

import UIKit

class ProfileViewController: (UIViewController & ProfileViewInputProtocol) {

    // MARK: - Properties

    let presenter: ProfileViewOutputProtocol
    var model: UserProfileDTO?

    private var userUrlString: String = ""

    // MARK: - Private Properties

    private let lineWidth: CGFloat = 1
    private let imageWidth: CGFloat = 100
    private let linkImgWidth: CGFloat = 20
    private let trailing = -16.0
    private let leading = 12.0
    private let topInset = 12.0
    private let bottom = -60.0
    private let labelWidthMultiplier = 0.5


    private let topDivider: UIView = {
        let dividerView = UIView()
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.layer.borderWidth = 1
        dividerView.layer.borderColor = UIColor.systemGray5.cgColor
        return dividerView
    }()


    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = AppImage.ErrorsIcons.noUserpicIcon
        imageView.tintColor = UIColor.systemGray3
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Texts.DummyTextForProfileVC.nameLabelText
        label.textAlignment = .left
        label.font = AppFont.openSansFont(ofSize: 26, weight: .semiBold)
        label.textColor = AppColor.textMain
        return label
    }()

    private let sexAndAgeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Texts.DummyTextForProfileVC.sexAndAgeLabelText
        label.textAlignment = .left
        label.font = AppFont.openSansFont(ofSize: 20, weight: .regular)
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
        button.setTitle(Texts.DummyTextForProfileVC.webLinkText, for: .normal)
        button.titleLabel?.font = AppFont.openSansFont(ofSize: 20, weight: .regular)
        button.titleLabel?.textColor = AppColor.accent
        return button
    }()

    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Texts.DummyTextForProfileVC.logoutButtonText, for: .normal)
        button.tintColor = .red
        button.titleLabel?.font = AppFont.openSansFont(ofSize: 20, weight: .regular)
        button.titleLabel?.textAlignment = .center
        return button
    }()

    private let versionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Texts.DummyTextForProfileVC.versionLabelText
        label.font = AppFont.openSansFont(ofSize: 14, weight: .regular)
        label.textColor = AppColor.textMinor
        return label
    }()


    // MARK: - Construction

    init(presenter: ProfileViewOutputProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        super.loadView()
        setupViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        presenter.fetchData()
    }

    // MARK: - Private functions

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
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topDivider.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: lineWidth
            ),
            topDivider.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -lineWidth
            ),
            topDivider.heightAnchor.constraint(
                equalToConstant: lineWidth
            ),
            topDivider.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: topInset
            ),
      
            profileImageView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: leading
            ),
            profileImageView.topAnchor.constraint(
                equalTo: topDivider.bottomAnchor,
                constant: topInset
            ),
            profileImageView.widthAnchor.constraint(
                equalToConstant: imageWidth
            ),
            profileImageView.heightAnchor.constraint(
                equalToConstant: imageWidth
            ),
      
            nameLabel.leadingAnchor.constraint(
                equalTo: profileImageView.trailingAnchor,
                constant: leading
            ),
            nameLabel.topAnchor.constraint(
                equalTo: profileImageView.topAnchor,
                constant: topInset
            ),
            nameLabel.widthAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.widthAnchor,
                multiplier: labelWidthMultiplier
            ),
      
            sexAndAgeLabel.leadingAnchor.constraint(
                equalTo: profileImageView.trailingAnchor,
                constant: leading
            ),
            sexAndAgeLabel.topAnchor.constraint(
                equalTo: nameLabel.bottomAnchor
            ),
            sexAndAgeLabel.widthAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.widthAnchor,
                multiplier: labelWidthMultiplier
            ),
      
            linkImageView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: leading
            ),
            linkImageView.topAnchor.constraint(
                equalTo: profileImageView.bottomAnchor,
                constant: topInset+topInset
            ),
            linkImageView.widthAnchor.constraint(
                equalToConstant: linkImgWidth
            ),
            linkImageView.heightAnchor.constraint(
                equalToConstant: linkImgWidth
            ),
      
            linkButton.leadingAnchor.constraint(
                equalTo: linkImageView.trailingAnchor,
                constant: leading
            ),
            linkButton.topAnchor.constraint(
                equalTo: profileImageView.bottomAnchor,
                constant: topInset
            ),
      
            logoutButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            logoutButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: bottom
            ),
      
            versionLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            versionLabel.topAnchor.constraint(
                equalTo: logoutButton.bottomAnchor,
                constant: topInset
            )
        ])
    }
}
