# P_Swipable

[![CI Status](https://img.shields.io/travis/Meggapixxel/P_Swipable.svg?style=flat)](https://travis-ci.org/Meggapixxel/P_Swipable)
[![Version](https://img.shields.io/cocoapods/v/P_Swipable.svg?style=flat)](https://cocoapods.org/pods/P_Swipable)
[![License](https://img.shields.io/cocoapods/l/P_Swipable.svg?style=flat)](https://cocoapods.org/pods/P_Swipable)
[![Platform](https://img.shields.io/cocoapods/p/P_Swipable.svg?style=flat)](https://cocoapods.org/pods/P_Swipable)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

UIViewController usage
```swift
class SwipeableViewController: UIViewController, P_Swipeable {

    private lazy var heightConstraint = view.heightAnchor.constraint(equalToConstant: minSwipeableViewHeight)
    override func viewDidLoad() {
        super.viewDidLoad()

        heightConstraint.isActive = true
        
        prepareSwipeable() // Step 1
    }
    
    // Step 2
    var swipeDirection: SwipeDirection { .down }
    
    func updateConstraints(to height: CGFloat, animated: Bool) {
        if animated {
            heightConstraint.constant = height
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                options: .curveEaseInOut,
                animations: { self.swipeableView.superview?.layoutIfNeeded() },
                completion: nil
            )
        } else {
            heightConstraint.constant = height
        }
    }
    
}

class SwipeableMasterVC: UIViewController {

    private let swipeableController = SwipeableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(swipeableController)
        view.addSubview(swipeableController.view)
        swipeableController.didMove(toParent: self)
        swipeableController.view.translatesAutoresizingMaskIntoConstraints = false
        swipeableController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        swipeableController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        swipeableController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

}

navigationController?.pushViewController(SwipeableMasterVC(), animated: true)
```

UIView  usage
```swift
class ConstraintSwipeableView: UIView, P_Swipeable {
    
    private lazy var heightConstraint = heightAnchor.constraint(equalToConstant: minSwipeableViewHeight)
    
    let swipeDirection: SwipeDirection
    
    required init(swipeDirection: SwipeDirection) {
        self.swipeDirection = swipeDirection
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        heightConstraint.isActive = true
        prepareSwipeable()
    }
    
    func updateConstraints(to height: CGFloat, animated: Bool) {
        if animated {
            heightConstraint.constant = height
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                options: .curveEaseInOut,
                animations: { self.swipeableView.superview?.layoutIfNeeded() },
                completion: nil
            )
        } else {
            heightConstraint.constant = height
        }
    }
    
}

class SwipeableViewViewController: BaseViewController {

    private let topSwipeableView = ConstraintSwipeableView(swipeDirection: .down)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(topSwipeableView)
        topSwipeableView.translatesAutoresizingMaskIntoConstraints = false
        topSwipeableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topSwipeableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topSwipeableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        topSwipeableView.backgroundColor = .tertiarySystemBackground
    }
    
}
```

## Requirements

- iOS 11.0+
- Swift 5.0+

## Installation

P_Swipable is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'P_Swipable'
```

## Author

Meggapixxel, zhydenkodeveloper@gmail.com

## License

P_Swipable is available under the MIT license. See the LICENSE file for more info.
