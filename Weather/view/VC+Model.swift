import UIKit

extension VC{
    /**
     * City and colors
     */
    static func createCityAndColors()->[(color:UIColor,city:City)]{
        var cityAndColor:[(color:UIColor,city:City)] = []
        City.cities.indices.forEach {  i in
            cityAndColor.append((color:VC.colors[i],city:City.cities[i]))
        }
        return cityAndColor
    }
}
