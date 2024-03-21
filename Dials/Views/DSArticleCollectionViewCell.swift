//
//  DSArticleCollectionViewCell.swift
//  Dials
//
//  Created by Rohan Prashanth on 20/03/24.
//

import UIKit

final class DSArticleCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "DSArticleCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imageView, titleLabel, authorLabel)
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.widthAnchor.constraint(equalToConstant: 242),
            authorLabel.heightAnchor.constraint(equalToConstant: 40),
            authorLabel.widthAnchor.constraint(equalToConstant: 140),

            
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            authorLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            
            
            authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            titleLabel.bottomAnchor.constraint(equalTo: authorLabel.topAnchor, constant: -3),
            
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            imageView.rightAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: -18),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
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
        
        print("enddd")
        imageView.backgroundColor = .green
        titleLabel.backgroundColor = .red
        authorLabel.backgroundColor = .blue
        
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
        authorLabel.text = viewModel.author
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
