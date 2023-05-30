
import UIKit

class FeedHeaderView: UIView {
    
    // MARK: - UI Components
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = "Discover"
        return label
    }()
    
    lazy var backToMainButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .red
        return button
    }()

    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        
        backgroundColor = .white
        
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor(named: "HeaderShadowColor")?.cgColor
        layer.shadowRadius = 35
        
        addSubview(titleLabel)
        addSubview(backToMainButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        backToMainButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -19),
            
            backToMainButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backToMainButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),

        ])
        
    }

}
