//
//  NewsfeedViewController.swift
//  ShikiApp
//
//  Created by Сергей Черных on 20.01.2023.
//

import UIKit

class NewsfeedViewController: (UIViewController & NewsfeedViewInput) {

    // MARK: - Properties
    
    let presenter: NewsfeedViewOutput
    var models: [NewsModel] = []

    // MARK: - Private Properties
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColor.backgroundMain
        return view
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.style = .large
        return view
    }()
    
    private var backgroundErrorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppImage.ErrorsIcons.nonConnectionIcon
        imageView.isHidden = true
        return imageView
    }()
    
    private var backgroundErrorLabel: UILabel = {
        let label = AppLabel(
            alignment: .center,
            fontSize: AppFont.openSansFont(ofSize: 16, weight: .regular),
            fontСolor: AppColor.textMinor,
            numberLines: 0
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Texts.ErrorMessage.general
        label.isHidden = true
        return label
    }()

    // MARK: - Construction
    
    init(presenter: NewsfeedViewOutput) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Functions
    
    func reloadData() {
        activityIndicator.stopAnimating()
        tableView.reloadData()
    }
    
    func showErrorBackground() {
        activityIndicator.stopAnimating()
        backgroundErrorImageView.isHidden = false
        backgroundErrorLabel.isHidden = false
    }

    // MARK: - Private functions
    
    private func setupViews() {
        backgroundView.addSubviews([backgroundErrorImageView, backgroundErrorLabel, activityIndicator])
        tableView.backgroundView = backgroundView
        view.addSubview(tableView)
    }
    
    private func configureUI() {
        setupConstraints()
        tableView.registerCell(NewsfeedTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        activityIndicator.startAnimating()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backgroundErrorImageView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            backgroundErrorImageView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            backgroundErrorImageView.widthAnchor.constraint(equalToConstant: 105),
            backgroundErrorImageView.heightAnchor.constraint(equalToConstant: 105),
            
            backgroundErrorLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            backgroundErrorLabel.topAnchor.constraint(equalTo: backgroundErrorImageView.bottomAnchor, constant: 24),
            
            activityIndicator.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
        ])
    }
}
