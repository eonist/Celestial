import UIKit

/**
 * Create
 */
extension VC{
    /**
     * Current view
     * TODO: ⚠️️ Rename to createMiddleView
     */
    func createCurView(idx:Int) -> Page{
        let view = createView(idx: idx)
        setCenterConstraints(view)
        return view
    }
    /**
     * Creates left view
     */
    func createLeftView(idx:Int) -> Page{
        let view = createView(idx: idx)
        setLeftConstraints(view)
        return view
    }
    /**
     * Creates right view
     */
    func createRightView(idx:Int) -> Page{
        let view = createView(idx: idx)
        setRightConstraints(view)
        return view
    }
    /**
     * Creates a new page for an idx
     * TODO: ⚠️️ rename to
     */
    private func createView(idx:Int) -> Page{
        Swift.print("idx:  \(idx) 🎉👌✅")
        //let color = ViewController.citiesAndColors[idx].color
        let view = Page(idx:idx/*,color:color*/)
        self.view.addSubview(view)
        let coordinate = VC.citiesAndColors[idx].city.coordinate
        let loc:Loc = Loc.init(lat:coordinate.lat, long:coordinate.long)
        let hourlyForcast:WeatherModel = MetWeatherService().hourlyForcast(loc:loc)
        view.setWeather(hourlyForcast)
        return view
    }
    /**
     * Creates footer
     */
    func createFooter() -> Footer{
        let footer = Footer()
        self.view.addSubview(footer)
        footer.activateConstraint{ view in /*constraints*/
            let anchor = Constraint.anchor(footer, to: self.view, align: .bottomCenter, alignTo: .bottomCenter)/*Its strange that this works, since pages are added to view, and view should be full-screen*/
            let screenSize = UIScreen.main.bounds.size
            let size = Constraint.size(footer, size: CGSize(width:screenSize.width,height:Footer.footerHeight))
            return [anchor.x,anchor.y,size.w,size.h]
        }
        footer.updateWeather(idx: self.curIdx)/*init*/
        return footer
    }
}
