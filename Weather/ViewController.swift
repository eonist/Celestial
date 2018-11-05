import UIKit
import Carousel

//createView
   //add correct temp, image, city ✅
//createFooter
   //add the little icons etc
   //set correct width
   //setData on idx change
//add cool design 🚫
//psuedo code the slide-up feature 👈
//solve the setting of idx stuff, you dont need to set all idx. its diff for left and right
//can we do animated gradiens like that meteor guy?
   
class ViewController: UIViewController {
   lazy var carousel:CardCarousel = {
      let carousel = CardCarousel(frame: UIScreen.main.bounds)
      view.addSubview(carousel)
      return carousel
   }()
   override func viewDidLoad() {
      super.viewDidLoad()
     
      view.backgroundColor = .black
//      self.view.isUserInteractionEnabled = true
      _ = carousel
   }
   override var prefersStatusBarHidden:Bool {return true}/*hides statusbar*/
}
