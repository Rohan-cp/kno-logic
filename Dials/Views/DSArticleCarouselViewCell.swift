//
//  DSArticleCarouselViewCell.swift
//  Dials
//
//  Created by Rohan Prashanth on 22/03/24.
//

import UIKit

class DSArticleCarouselViewCell: UICollectionViewCell {
    static let cellIdentifier = "DSArticleCarouselViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imageView, titleLabel, authorLabel)
        addConstraints()
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.secondaryLabel.cgColor
        contentView.layer.cornerRadius = 4
        contentView.layer.shadowOffset = CGSize(width: -3, height: 3)
        contentView.layer.shadowOpacity = 0.2
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
          //  titleLabel.heightAnchor.constraint(equalToConstant: 60),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -7),
            titleLabel.widthAnchor.constraint(equalToConstant: 242),
            authorLabel.heightAnchor.constraint(equalToConstant: 30),
            authorLabel.widthAnchor.constraint(equalToConstant: 140),

            
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            authorLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            
            authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            titleLabel.bottomAnchor.constraint(equalTo: authorLabel.topAnchor, constant: -3),
            
            imageView.rightAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: -18),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),

           /*
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),

            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 20),
            authorLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -3),
            authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            */
        ])
        
        /*
         | Image      Title
         | Image            by Author
         */
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        authorLabel.text = nil
    }
    
    public func configure(with viewModel: DSArticleCollectionViewCellViewModel) {
        titleLabel.text = viewModel.title
        authorLabel.text = viewModel.authorText
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
    }
}
