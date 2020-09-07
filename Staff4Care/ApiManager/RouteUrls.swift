enum Route: String {
    
    case getAvailabity               = "staff/shifts/"
    case saveAvailabity              = "staff/availability/"
    
    func url() -> String{
        return Constants.baseUrl + self.rawValue
    }
}
