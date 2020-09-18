
import Foundation
struct StaffModel : Codable {
	let staff_list : Staff_list?
	let response_code : Int?
	let message : String?
	let status : Bool?

	enum CodingKeys: String, CodingKey {

		case staff_list = "staff_list"
		case response_code = "response_code"
		case message = "message"
		case status = "status"
	}
}


struct Staff_list : Codable {
    let user_id : String?
    let name : String?
    let father_name : String?
    let designation : String?
    let company : String?
    let date_of_birth : String?
    let postcode : String?
    let longitude : String?
    let latitude : String?
    let experience : String?
    let registration_no : String?
    let ethnic_background : String?
    let habit : String?
    let address : String?
    let sort_code_1 : String?
    let sort_code_2 : String?
    let sort_code_3 : String?
    let account_no : String?
    let bank_name : String?
    let created_date : String?
    let modified_date : String?
    let gendar : String?
    let my_summary : String?
    let about_me : String?
    let my_experience : String?
    let my_qualification : String?
    let my_rates : String?
    let document_url : String?
    let holidays : [String]?

    enum CodingKeys: String, CodingKey {

        case user_id = "user_id"
        case name = "name"
        case father_name = "father_name"
        case designation = "designation"
        case company = "company"
        case date_of_birth = "date_of_birth"
        case postcode = "postcode"
        case longitude = "longitude"
        case latitude = "latitude"
        case experience = "experience"
        case registration_no = "registration_no"
        case ethnic_background = "ethnic_background"
        case habit = "habit"
        case address = "address"
        case sort_code_1 = "sort_code_1"
        case sort_code_2 = "sort_code_2"
        case sort_code_3 = "sort_code_3"
        case account_no = "account_no"
        case bank_name = "bank_name"
        case created_date = "created_date"
        case modified_date = "modified_date"
        case gendar = "gendar"
        case my_summary = "my_summary"
        case about_me = "about_me"
        case my_experience = "my_experience"
        case my_qualification = "my_qualification"
        case my_rates = "my_rates"
        case document_url = "document_url"
        case holidays = "holidays"
    }

}
