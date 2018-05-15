import Foundation

class WeatherXMLParser:NSObject,XMLParserDelegate {
    var forcasts: [Forcast] = []
    var elementName: String = ""//name of each element name at variouse stages in the xml hierarchy
    /**
     * PARAM: url: API url to xml to be parsed
     * EXAMPLE URL: "https://api.met.no/weatherapi/locationforecast/1.9/?lat=59.91&lon=10.75"
     */
    func initiate(url:String){
//      let url:String = "https://api.met.no/weatherapi/locationforecast/1.9/?lat=59.91&lon=10.75"
        if let path =  URL.init(string: url){//{//Bundle.main.url(forResource: "met_5", withExtension: "xml")
            if let parser = XMLParser(contentsOf: path) {//gets the content and creates the Parser instance
                parser.delegate = self//set this class as the Parsers delegate
                let success:Bool = parser.parse()//initiates the parsing
                if success {
                    print("success")
                } else {
                    print("parse failure!")
                }
            }
        }
    }
    /**
     * Temp variables for the parser
     */
    var from:String = ""
    var to:String = ""
    var temperature:String?
    var symbol:String?
   
    /**
     * At the begining of an element
     */
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        self.elementName = elementName

        if elementName == "time" {
            self.from = attributeDict["from"] ?? ""
            self.to =  attributeDict["to"] ?? ""
            self.symbol = nil//reset
            self.temperature = nil//reset
        } else if elementName == "symbol" {
            self.symbol =  attributeDict["number"]//use id for the weatherTypeName
        } else if elementName == "temperature" {
            self.temperature =  attributeDict["value"]
        }
    }
    /**
     * At the end of an element
     */
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "time" {//when a book element completes parsing. Use the temp data and populate the Book struct, then append that book struct
            let forcast = Forcast.init(from: self.from, to: self.to, symbol:self.symbol,temperature: self.temperature)
            forcasts.append(forcast)
        }
    }
}
/**
 * Used as a store for each Forcast item in the XML
 */
struct Forcast{
    let from:String
    let to:String
    let symbol:String?
    let temperature:String?
}

