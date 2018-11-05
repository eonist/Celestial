import UIKit

class ViewController: UIViewController {
   lazy var carousel:CardCarousel = createCardCarousel()
   override func viewDidLoad() {
      super.viewDidLoad()
//      view.backgroundColor = .gray
//      self.view.isUserInteractionEnabled = true
      _ = carousel
   }
   override var prefersStatusBarHidden:Bool {return true}/*hides statusbar*/
}
/**
 * Create
 */
extension ViewController{
   /**
    * Creates CardCarousel
    */
   func createCardCarousel() -> CardCarousel{
      let carousel = CardCarousel(frame: UIScreen.main.bounds)
      view.addSubview(carousel)
      return carousel
   }
}
