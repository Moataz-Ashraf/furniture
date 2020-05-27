import UIKit

enum MenuOption: Int, CustomStringConvertible{
    
    case Items
    case Booked
    case AddItems
    case Settings
    case cat
    
    var description: String {
        switch self{
        case .Items:
            return "My Collection"
        case .Booked:
            return "Booked"
        case .AddItems:
            return "Add New Items"
        case .Settings:
            return "Settings"
        case .cat:
            return "cat"
        }
    }
    
    var image: UIImage{
        switch self{
            case .Items:
                return #imageLiteral(resourceName: "design-eye-catchy-decoration-and-furniture-logo-for-our-company-within-12-hours.jpg")
            case .Booked:
                return #imageLiteral(resourceName: "shopping-items")
            case .AddItems:
                return #imageLiteral(resourceName: "023-shelves-2")
            case .Settings:
                return UIImage(named: "baseline_settings_white_24dp") ?? UIImage()
            case .cat:
                return UIImage()
        }
    }
}
