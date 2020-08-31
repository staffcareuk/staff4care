/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct AvailabilityShiftsModel : Codable {
	let shifts_list : [Shifts_list]?
	let response_code : Int?
	let status : Bool?
	let message : String?

	enum CodingKeys: String, CodingKey {

		case shifts_list = "shifts_list"
		case response_code = "response_code"
		case status = "status"
		case message = "message"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		shifts_list = try values.decodeIfPresent([Shifts_list].self, forKey: .shifts_list)
		response_code = try values.decodeIfPresent(Int.self, forKey: .response_code)
		status = try values.decodeIfPresent(Bool.self, forKey: .status)
		message = try values.decodeIfPresent(String.self, forKey: .message)
	}

}
struct Shifts_list : Codable {
    let shift_id : String?
    let shift_title : String?
    let shift_day : String?
    let shift_start_time : String?
    let shift_end_time : String?
    let created_date : String?
    let modified_date : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case shift_id = "shift_id"
        case shift_title = "shift_title"
        case shift_day = "shift_day"
        case shift_start_time = "shift_start_time"
        case shift_end_time = "shift_end_time"
        case created_date = "created_date"
        case modified_date = "modified_date"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        shift_id = try values.decodeIfPresent(String.self, forKey: .shift_id)
        shift_title = try values.decodeIfPresent(String.self, forKey: .shift_title)
        shift_day = try values.decodeIfPresent(String.self, forKey: .shift_day)
        shift_start_time = try values.decodeIfPresent(String.self, forKey: .shift_start_time)
        shift_end_time = try values.decodeIfPresent(String.self, forKey: .shift_end_time)
        created_date = try values.decodeIfPresent(String.self, forKey: .created_date)
        modified_date = try values.decodeIfPresent(String.self, forKey: .modified_date)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
