

import Foundation
struct AvailabityModel : Codable {
	let shifts : Shifts?
	let response_code : Int?
	let message : String?
	let status : Bool?

	enum CodingKeys: String, CodingKey {

		case shifts = "shifts"
		case response_code = "response_code"
		case message = "message"
		case status = "status"
    }
}

struct Shifts : Codable {
    let monday : [Monday]?
    let tuesday : [Tuesday]?
    let wednesday : [Wednesday]?
    let thursday : [Thursday]?
    let friday : [Friday]?
    let saturday : [Saturday]?
    let sunday : [Sunday]?

    enum CodingKeys: String, CodingKey {

        case monday = "Monday"
        case tuesday = "Tuesday"
        case wednesday = "Wednesday"
        case thursday = "Thursday"
        case friday = "Friday"
        case saturday = "Saturday"
        case sunday = "Sunday"
    }
}


struct Friday : Codable {
    let shift_id : String?
    let shift_title : String?
    let shift_day : String?
    let shift_start_time : String?
    let shift_end_time : String?
    let created_date : String?
    let modified_date : String?
    let status : String?
    var is_available : Bool?

    enum CodingKeys: String, CodingKey {

        case shift_id = "shift_id"
        case shift_title = "shift_title"
        case shift_day = "shift_day"
        case shift_start_time = "shift_start_time"
        case shift_end_time = "shift_end_time"
        case created_date = "created_date"
        case modified_date = "modified_date"
        case status = "status"
        case is_available = "is_available"
    }
}

struct Monday : Codable {
    let shift_id : String?
    let shift_title : String?
    let shift_day : String?
    let shift_start_time : String?
    let shift_end_time : String?
    let created_date : String?
    let modified_date : String?
    let status : String?
    var is_available : Bool?

    enum CodingKeys: String, CodingKey {

        case shift_id = "shift_id"
        case shift_title = "shift_title"
        case shift_day = "shift_day"
        case shift_start_time = "shift_start_time"
        case shift_end_time = "shift_end_time"
        case created_date = "created_date"
        case modified_date = "modified_date"
        case status = "status"
        case is_available = "is_available"
    }
}

struct Saturday : Codable {
    let shift_id : String?
    let shift_title : String?
    let shift_day : String?
    let shift_start_time : String?
    let shift_end_time : String?
    let created_date : String?
    let modified_date : String?
    let status : String?
    var is_available : Bool?

    enum CodingKeys: String, CodingKey {

        case shift_id = "shift_id"
        case shift_title = "shift_title"
        case shift_day = "shift_day"
        case shift_start_time = "shift_start_time"
        case shift_end_time = "shift_end_time"
        case created_date = "created_date"
        case modified_date = "modified_date"
        case status = "status"
        case is_available = "is_available"
    }
}

struct Sunday : Codable {
    let shift_id : String?
    let shift_title : String?
    let shift_day : String?
    let shift_start_time : String?
    let shift_end_time : String?
    let created_date : String?
    let modified_date : String?
    let status : String?
    var is_available : Bool?

    enum CodingKeys: String, CodingKey {

        case shift_id = "shift_id"
        case shift_title = "shift_title"
        case shift_day = "shift_day"
        case shift_start_time = "shift_start_time"
        case shift_end_time = "shift_end_time"
        case created_date = "created_date"
        case modified_date = "modified_date"
        case status = "status"
        case is_available = "is_available"
    }

}


struct Thursday : Codable {
    let shift_id : String?
    let shift_title : String?
    let shift_day : String?
    let shift_start_time : String?
    let shift_end_time : String?
    let created_date : String?
    let modified_date : String?
    let status : String?
    var is_available : Bool?

    enum CodingKeys: String, CodingKey {

        case shift_id = "shift_id"
        case shift_title = "shift_title"
        case shift_day = "shift_day"
        case shift_start_time = "shift_start_time"
        case shift_end_time = "shift_end_time"
        case created_date = "created_date"
        case modified_date = "modified_date"
        case status = "status"
        case is_available = "is_available"
    }
}

struct Tuesday : Codable {
    let shift_id : String?
    let shift_title : String?
    let shift_day : String?
    let shift_start_time : String?
    let shift_end_time : String?
    let created_date : String?
    let modified_date : String?
    let status : String?
    var is_available : Bool?

    enum CodingKeys: String, CodingKey {

        case shift_id = "shift_id"
        case shift_title = "shift_title"
        case shift_day = "shift_day"
        case shift_start_time = "shift_start_time"
        case shift_end_time = "shift_end_time"
        case created_date = "created_date"
        case modified_date = "modified_date"
        case status = "status"
        case is_available = "is_available"
    }
}

struct Wednesday : Codable {
    let shift_id : String?
    let shift_title : String?
    let shift_day : String?
    let shift_start_time : String?
    let shift_end_time : String?
    let created_date : String?
    let modified_date : String?
    let status : String?
    var is_available : Bool?

    enum CodingKeys: String, CodingKey {

        case shift_id = "shift_id"
        case shift_title = "shift_title"
        case shift_day = "shift_day"
        case shift_start_time = "shift_start_time"
        case shift_end_time = "shift_end_time"
        case created_date = "created_date"
        case modified_date = "modified_date"
        case status = "status"
        case is_available = "is_available"
    }

}

