
import UIKit

/**
 * Animation
 */
extension VC{
    /**
     *
     */
    func animate(to:CGFloat, onComplete:@escaping ()-> Void){
        let newConstraint = {
            guard let posConstraint = self.curView.anchor else {fatalError("err posConstraint not available")}
            NSLayoutConstraint.deactivate([posConstraint.x])
            let xConstraint = Constraint.anchor(self.curView, to: self.view, align: .left, alignTo: .left, offset: to)
            NSLayoutConstraint.activate([xConstraint/*,pos.y*/])
            self.curView.anchor?.x = xConstraint
        }
        
        let anim = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut, animations: {
            // Set the new constraints
            newConstraint()
            // Apply the new constraints on the view
            self.view.layoutIfNeeded()
        })
        anim.addCompletion{_ in
            onComplete()
        }
        anim.startAnimation()
    }
}
/**
 * Creational
 */
extension VC{
    /**
     *
     */
    func createCurView(idx:Int) -> Page{
        let view = createView(idx: idx)
        setCenterConstraints(view)
        return view
    }
    /**
     * center
     */
    func setCenterConstraints(_ view:Page) {
        view.translatesAutoresizingMaskIntoConstraints = false// (this enables you to set your own constraints)
        let screenSize:CGSize = {
            let size = UIScreen.main.bounds.size
            return CGSize(width:size.width, height:size.height - Footer.footerHeight)
        }()
        let size = Constraint.size(view, size: screenSize)
        let pos = Constraint.anchor(view, to: self.view, align: .topLeft, alignTo: .topLeft)
        let constraints = [pos.x,pos.y,size.w,size.h]
        view.size = size
        view.anchor = pos
        NSLayoutConstraint.activate(constraints)
    }
    /**
     *
     */
    func createLeftView(idx:Int) -> Page{
        let view = createView(idx: idx)
        setLeftConstraints(view)
        return view
    }
    func setLeftConstraints(_ view:Page) {
        view.translatesAutoresizingMaskIntoConstraints = false// (this enables you to set your own constraints)
        let screenSize:CGSize = {
            let size = UIScreen.main.bounds.size
            return CGSize(width:size.width, height:size.height - Footer.footerHeight)
        }()
        let size = Constraint.size(view, size: screenSize)
        let pos = Constraint.anchor(view, to: self.curView, align: .topRight, alignTo: .topLeft)
        let constraints = [pos.x,pos.y,size.w,size.h]
        view.size = size
        view.anchor = pos
        NSLayoutConstraint.activate(constraints)
    }
    /**
     *
     */
    func createRightView(idx:Int) -> Page{
        let view = createView(idx: idx)
        setRightConstraints(view)
        return view
    }
    /**
     *
     */
    func setRightConstraints(_ view:Page) {
        view.translatesAutoresizingMaskIntoConstraints = false// (this enables you to set your own constraints)
        let screenSize:CGSize = {
            let size = UIScreen.main.bounds.size
            return CGSize(width:size.width, height:size.height - Footer.footerHeight)
        }()
        let size = Constraint.size(view, size: screenSize)
        let pos = Constraint.anchor(view, to: curView, align: .topLeft, alignTo: .topRight)
        let constraints = [pos.x,pos.y,size.w,size.h]
        view.size = size
        view.anchor = pos
        NSLayoutConstraint.activate(constraints)
    }
    /**
     *
     */
    private func createView(idx:Int) -> Page{
        Swift.print("idx:  \(idx) 🎉👌✅")
//        let color = ViewController.citiesAndColors[idx].color
        let view = Page(idx:idx/*,color:color*/)
        self.view.addSubview(view)
        let coordinate = VC.citiesAndColors[idx].city.coordinate
        let loc:Loc = Loc.init(lat:coordinate.lat, long:coordinate.long)
        let hourlyForcast:WeatherModel = MetWeatherService().hourlyForcast(loc:loc)
        view.setWeather(hourlyForcast)
        return view
    }
    /**
     * Footer
     */
    func createFooter() -> Footer{
        let footer = Footer()
        self.view.addSubview(footer)
        _ = {//constraints
            footer.translatesAutoresizingMaskIntoConstraints = false//(this enables you to set your own constraints)
            let anchor = Constraint.anchor(footer, to: self.view, align: .bottomCenter, alignTo: .bottomCenter)
            let screenSize = UIScreen.main.bounds.size
            let size = Constraint.size(footer, size: CGSize(width:screenSize.width,height:Footer.footerHeight))
            NSLayoutConstraint.activate([anchor.x,anchor.y,size.w,size.h])
        }()
        footer.updateWeather(idx: self.curIdx)//init
        return footer
    }
}
