//
//  NewsfeedTableViewCell.swift
//  ShikiApp
//
//  Created by Сергей Черных on 20.01.2023.
//

import UIKit

class NewsfeedTableViewCell: UITableViewCell {
    // MARK: - Private properties
    internal struct Constants {
        static let lineWidth: CGFloat = 1
        static let imageWidth: CGFloat = 88
        static let trailingInset: CGFloat = -16
        static let leadingInset: CGFloat = 8
        static let topInset: CGFloat = 12
        static let bottomInset: CGFloat = -12
        static let verticalSpacing: CGFloat = 2
    }
    
    private var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var dateLabel: UILabel = {
        let label = AppLabel(alignment: .left, fontSize: AppFont.openSansFont(ofSize: 12, weight: .regular), fontСolor: AppColor.textMinor)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var titleLabel: UILabel = {
        let label = AppLabel(alignment: .left, fontSize: AppFont.openSansFont(ofSize: 16, weight: .bold))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    private var subtitleLabel: UILabel = {
        let label = AppLabel(alignment: .left, fontSize: AppFont.openSansFont(ofSize: 16, weight: .regular))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var strokeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColor.line
        return view
    }()
    
    private var accentBackgroundView: UIView = {
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
            newsImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth),
            newsImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            dateLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: Constants.leadingInset),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.trailingInset),
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.topInset),
            
            titleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: Constants.leadingInset),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.trailingInset),
            titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: Constants.verticalSpacing),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: Constants.leadingInset),
            subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.trailingInset),
            subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Constants.bottomInset),
            
            strokeView.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: Constants.leadingInset),
            strokeView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.trailingInset),
            strokeView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            strokeView.heightAnchor.constraint(equalToConstant: Constants.lineWidth)
        ])
    }
    
    private func textIsShort(_ text: String?) -> Bool {
        let widthTitle = contentView.bounds.width - Constants.imageWidth - Constants.leadingInset + Constants.trailingInset
        let titleHeight = text?.getTextHeight(width: widthTitle, font: titleLabel.font) ?? 0
        let oneLineTitleHeight = "".getTextHeight(width: widthTitle, font: titleLabel.font)
        if titleHeight < (oneLineTitleHeight * 2) {
            return true
        }
        return false
    }
    
    // MARK: - Functions
    func configure(with cellModel: NewsModel) {
        newsImageView.image = cellModel.image
        dateLabel.text = cellModel.date
        titleLabel.text = cellModel.title
        subtitleLabel.text = cellModel.subtitle
        
        if textIsShort(titleLabel.text) {
            titleLabel.numberOfLines = 1
            subtitleLabel.numberOfLines = 2
        }
    }
}
