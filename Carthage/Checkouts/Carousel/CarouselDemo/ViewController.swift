import UIKit

class ViewController: UIViewController {
   lazy var carousel:CardCarousel = {
      let carousel = CardCarousel(frame: UIScreen.main.bounds)
      view.addSubview(carousel)
      return carousel
   }()
   override func viewDidLoad() {
      super.viewDidLoad()
//      view.backgroundColor = .gray
//      self.view.isUserInteractionEnabled = true
      _ = carousel
   }
   override var prefersStatusBarHidden:Bool {return true}/*hides statusbar*/
}
