

import UIKit
//MARK: - Structure For Filter Data
struct SavedData: Codable{
    let runwayLengthMin: String
    let runwayLengthMax: String
    let directFlightMin: String
    let directFlightMax: String
    let carriersMin: String
    let carrierMax: String
    let selectedCountry: Array<String>
}

struct FilteredCountry: Codable {
    var isSelected: Bool = false
    let country: String
}
  
//MARK: - Presentation View Model
class FIlterViewController: UIPresentationController {
    let blurEffectView: UIVisualEffectView!
    var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurEffectView.isUserInteractionEnabled = true
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        CGRect(origin: CGPoint(x: 0, y: self.containerView!.frame.height * 0.1),
               size: CGSize(width: self.containerView!.frame.width, height: self.containerView!.frame.height *
                0.9))
    }

    override func presentationTransitionWillBegin() {
        self.blurEffectView.alpha = 0
        self.containerView?.addSubview(blurEffectView)
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.blurEffectView.alpha = 0.7
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in })
    }
    
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.blurEffectView.alpha = 0
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in
            self.blurEffectView.removeFromSuperview()
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
      presentedView!.roundCorners([.topLeft, .topRight], radius: 22)
    }

    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        blurEffectView.frame = containerView!.bounds
    }

    @objc func dismissController(){
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
  }

  extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
  }


//MARK: - comments

//    let runway_length: (min: Float?, max: Float?)
//    let direct_Flights: (min: Float?, max: Float?)
//    let carriers :  (min: Float?, max: Float?)
//    let selectedCountry: Array<String>
//    var array: Array<Any> = []
//    var min: Float
//    var max: Float
//    let runway = array.reduce(into: [:]) { $0[($1 as AnyObject).0] = ($1 as AnyObject).1 }
//    var runwayLength: [String: Float] {
//            return ["min": min,
//                    "max": max]
//        }
//    var directFlight: [String: Float] {
//            return ["min": min,
//                    "age": max]
//        }
//    var carrierData: [String: Float] {
//            return ["min": min,
//                    "max": max]
//        }
    
