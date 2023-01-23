//
//  NewsfeedViewController.swift
//  ShikiApp
//
//  Created by Сергей Черных on 20.01.2023.
//

import UIKit

class NewsfeedViewController: (UIViewController & NewsfeedViewInput) {
    // MARK: - Properties
    internal var viewModels: [NewsModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Private Properties
    private let presenter: NewsfeedViewOutput
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private(set) lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private(set) lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppImage.ErrorsIcons.nonConnectionIcon
        return imageView
    }()
    
    private(set) lazy var backgroundLabel: UILabel = {
        let label = AppLabel(
            alignment: .center,
            fontSize: AppFont.openSansFont(ofSize: 16, weight: .regular),
            fontСolor: AppColor.textMinor,
            numberLines: 0
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Что-то пошло не так.\nПопробуйте позже, должно получиться"
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
    
    // MARK: - Private functions
    private func setupViews() {
        backgroundView.addSubviews([backgroundImageView, backgroundLabel])
        tableView.backgroundView = backgroundView
        view.addSubview(tableView)
    }
    
    private func configureUI() {
        setupConstraints()
        tableView.registerCell(NewsfeedTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
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
            
            backgroundImageView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            backgroundImageView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            backgroundImageView.widthAnchor.constraint(equalToConstant: 105),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 105),
            
            backgroundLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            backgroundLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 24)
        ])
    }
}

// MARK: - UITableViewDataSource
extension NewsfeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: NewsfeedTableViewCell = tableView.cell(forRowAt: indexPath) else { return UITableViewCell() }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension NewsfeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        112
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let news = viewModels[indexPath.row]
        presenter.viewDidSelectNews(news: news)
    }
}
