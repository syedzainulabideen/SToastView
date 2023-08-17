import UIKit
import Foundation

public class SToastView: UIView {
    private lazy var toastLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    private lazy var toastDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    private lazy var labelStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [toastLabel, toastDescriptionLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.setTitle(self.currentConfig.rightButtonText, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(self.actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let toastImage: UIImageView = {
        let label = UIImageView()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private weak var parentViewController: UIViewController?
    private var currentConfig: ToastConfiguration = .successConfig
    private var direction: SToastDirection = .top
    var actionHandler:(() -> ())?
        
    init(parentViewController: UIViewController? = nil) {
        self.parentViewController = parentViewController
        super.init(frame: CGRect.zero)
    }
    
    func setup() {
        
        backgroundColor = UIColor.black
        layer.cornerRadius = 30
        clipsToBounds = true
        
        addSubview(labelStack)
        
        if let validIcon = self.currentConfig.type.icon {
            toastImage.image = validIcon
            addSubview(toastImage)
            
            NSLayoutConstraint.activate([
                toastImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                toastImage.widthAnchor.constraint(equalToConstant: 35),
                toastImage.heightAnchor.constraint(equalToConstant: 35),
                toastImage.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
        
        if let validString = self.currentConfig.rightButtonText {
            actionButton.setTitle(validString, for: .normal)
            addSubview(actionButton)
            
            NSLayoutConstraint.activate([
                actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                actionButton.widthAnchor.constraint(equalToConstant: 65),
                actionButton.heightAnchor.constraint(equalToConstant: 30),
                actionButton.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
        
        NSLayoutConstraint.activate([
            labelStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            labelStack.leadingAnchor.constraint(equalTo: self.currentConfig.type.icon == nil ? leadingAnchor : toastImage.trailingAnchor, constant: 8),
            labelStack.trailingAnchor.constraint(equalTo: self.currentConfig.rightButtonText == nil ? trailingAnchor  : actionButton.leadingAnchor, constant: -8),
            labelStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutContainerViews() {
        
    }
    
    @objc func actionButtonTapped() {
        self.actionHandler?()
    }
    
    public func show(withMessage message: String, description: String? = nil, completion: @escaping () -> ()) {
        self.setup()
        self.actionHandler = completion
        
        toastLabel.text = message
        if let desciptionMessage = description {
            toastDescriptionLabel.text = desciptionMessage
        }
        else {
            toastDescriptionLabel.isHidden = true
        }
        
        
        guard let validTopViewController = parentViewController ?? self.topViewController() else {
            return
        }
        
        addSubviewToTopViewController(viewController: validTopViewController)
        frame = CGRect(x: initialXValue, y: initialYValue, width: frame.width, height: frame.height)
        UIView.animate(withDuration: self.currentConfig.animationDuration, animations: {
            self.frame.origin.y = self.presentedYValue
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + self.currentConfig.displayDuration) {
                self.hide()
            }
        }
    }
}


private extension SToastView {
    func hide() {
        UIView.animate(withDuration: self.currentConfig.animationDuration, animations: {
            self.frame.origin.y = self.initialYValue
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    func addSubviewToTopViewController(viewController: UIViewController) {
        viewController.view.addSubview(self)
        frame.size.width = toastViewWidth
        frame.size.height = toastViewHeight
    }
}

private extension SToastView {
    var containerWidth:CGFloat {
        return self.parentViewController?.view.frame.width ?? 0
    }
    
    var containerHeight:CGFloat {
        return self.parentViewController?.view.frame.height ?? 0
    }
    
    var toastViewWidth:CGFloat {
        return containerWidth * self.currentConfig.widthPercentage
    }
    
    var toastViewHeight:CGFloat {
        return self.currentConfig.height
    }
    
    var showingY:CGFloat {
        return self.direction == .bottom ? (containerHeight - frame.height - self.currentConfig.edgeDistance) : self.currentConfig.edgeDistance
    }
    
    var initialYValue:CGFloat {
        let value = self.direction == .bottom  ? containerHeight + self.frame.height : -self.frame.height
        return value
    }
    
    var presentedYValue:CGFloat {
        let value = self.direction == .bottom  ? (containerHeight - frame.height - self.currentConfig.edgeDistance) : self.currentConfig.edgeDistance
        return value
    }
    
    var initialXValue:CGFloat {
        let value = (containerWidth - (containerWidth * self.currentConfig.widthPercentage)) / 2.0
        return value
    }
}


extension SToastView {
    func topViewController() -> UIViewController? {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let topController = scene.windows.first?.rootViewController {
            return topController.getTopViewController()
        }
        
        return nil
    }
}

extension UIViewController {
    func getTopViewController() -> UIViewController? {
        if let nav = self as? UINavigationController {
            return nav.visibleViewController?.getTopViewController()
        }
        
        if let tab = self as? UITabBarController {
            if let selected = tab.selectedViewController {
                return selected.getTopViewController()
            }
        }
        
        if let presented = self.presentedViewController {
            return presented.getTopViewController()
        }
        
        return self
    }
}
