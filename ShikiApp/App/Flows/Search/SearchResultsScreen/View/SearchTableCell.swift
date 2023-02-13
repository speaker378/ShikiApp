//
//  SearchTableCell.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 05.02.2023.
//

import UIKit

class SearchTableCell: UITableViewCell {

    // MARK: - Private properties
    
    private let lineWidth: CGFloat = 1
    private let imageWidth: CGFloat = 88
    private let scoreWidth: CGFloat = 39
    private let scoreHeight: CGFloat = 24
    private let scoreTopInset: CGFloat = 8
    private let scoreLeading: CGFloat = 8
    private let trailing = -16.0
    private let leading = 8.0
    private let topInset = 12.0
    private let bottom = -12.0
    private let verticalSpacing = 2.0
    
    private var contentImageView: UIImageViewAsync = {
        let imageView = UIImageViewAsync()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private var scoreLabel: UILabel = {
        let label = AppLabel(
            alignment: .center,
            fontSize: AppFont.openSansFont(ofSize: 16, weight: .bold),
            fontСolor: AppColor.textInvert
        )
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var titleLabel: UILabel = {
        let label = AppLabel(alignment: .left, fontSize: AppFont.openSansFont(ofSize: 16, weight: .bold))
        label.textColor = AppColor.textMain
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    private var subtitleLabel: UILabel = {
        let label = AppLabel(alignment: .left, fontSize: AppFont.openSansFont(ofSize: 16, weight: .regular))
        label.textColor = AppColor.textMain
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
        super.prepareForReuse()
        contentImageView.image = nil
        [scoreLabel, titleLabel, subtitleLabel].forEach { $0.text = nil }
    }

    // MARK: - Functions

    func configure(with cellModel: SearchModel) {
        contentImageView.downloadedImage(from: cellModel.imageUrlString, contentMode: .scaleAspectFill)
        titleLabel.text = cellModel.title
        scoreLabel.text = cellModel.score.value
        scoreLabel.backgroundColor = cellModel.score.color
        subtitleLabel.text = cellModel.subtitle
        
        if textIsShort(titleLabel.text) {
            titleLabel.numberOfLines = 1
            subtitleLabel.numberOfLines = 2
        }
    }

    // MARK: - Private functions

    private func configureUI() {
        self.selectedBackgroundView = accentBackgroundView
        self.addSubviews([contentImageView, scoreLabel, titleLabel, subtitleLabel, strokeView])
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentImageView.topAnchor.constraint(equalTo: topAnchor),
            contentImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentImageView.widthAnchor.constraint(equalToConstant: imageWidth),
            contentImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scoreLabel.leadingAnchor.constraint(equalTo: contentImageView.leadingAnchor, constant: leading),
            scoreLabel.widthAnchor.constraint(equalToConstant: scoreWidth),
            scoreLabel.heightAnchor.constraint(equalToConstant: scoreHeight),
            scoreLabel.topAnchor.constraint(equalTo: contentImageView.topAnchor, constant: scoreTopInset),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentImageView.trailingAnchor, constant: leading),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailing),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: topInset),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: contentImageView.trailingAnchor, constant: leading),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailing),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: verticalSpacing),
            
            strokeView.leadingAnchor.constraint(equalTo: contentImageView.trailingAnchor, constant: leading),
            strokeView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailing),
            strokeView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            strokeView.heightAnchor.constraint(equalToConstant: lineWidth)
        ])
    }
    
    private func textIsShort(_ text: String?) -> Bool {
        let widthTitle = contentView.bounds.width - imageWidth - leading + trailing
        let titleHeight = text?.getTextHeight(width: widthTitle, font: titleLabel.font) ?? 0
        let oneLineTitleHeight = "".getTextHeight(width: widthTitle, font: titleLabel.font)
        if titleHeight < (oneLineTitleHeight * 2) {
            return true
        }
        return false
    }
}
