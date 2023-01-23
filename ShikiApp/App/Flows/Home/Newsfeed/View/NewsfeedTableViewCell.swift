//
//  NewsfeedTableViewCell.swift
//  ShikiApp
//
//  Created by Сергей Черных on 20.01.2023.
//

import UIKit

class NewsfeedTableViewCell: UITableViewCell {
    // MARK: - Private properties
    private(set) lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private(set) lazy var dateLabel: UILabel = {
        let label = AppLabel(alignment: .left, fontSize: AppFont.openSansFont(ofSize: 12, weight: .regular), fontСolor: AppColor.textMinor)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = AppLabel(alignment: .left, fontSize: AppFont.openSansFont(ofSize: 16, weight: .bold))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    private(set) lazy var subtitleLabel: UILabel = {
        let label = AppLabel(alignment: .left, fontSize: AppFont.openSansFont(ofSize: 16, weight: .regular))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var strokeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColor.line
        return view
    }()
    
    private(set) lazy var accentBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.accent
        return view
    }()
    
    // MARK: - Construction
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        newsImageView.image = nil
        [dateLabel, titleLabel, subtitleLabel].forEach { $0.text = nil }
    }
    
    // MARK: - Private functions
    private func configureUI() {
        self.selectedBackgroundView = accentBackgroundView
        self.addSubviews([newsImageView, dateLabel, titleLabel, subtitleLabel, strokeView])
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: self.topAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            newsImageView.widthAnchor.constraint(equalToConstant: 88),
            newsImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            dateLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            
            titleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 2),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 8),
            subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            
            strokeView.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 8),
            strokeView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            strokeView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            strokeView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    // MARK: - Functions
    func configure(with cellModel: NewsViewModel) {
        newsImageView.image = cellModel.image
        dateLabel.text = cellModel.date
        titleLabel.text = cellModel.title
        subtitleLabel.text = cellModel.subtitle
    }
}
