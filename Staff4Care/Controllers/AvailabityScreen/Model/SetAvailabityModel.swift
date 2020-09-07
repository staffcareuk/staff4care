

import Foundation
struct SetAvailabityModel : Codable {
	let message : String?
	let token : String?
	let status : Bool?
	let response_code : Int?

	enum CodingKeys: String, CodingKey {
 
		case message = "message"
		case token = "token"
		case status = "status"
		case response_code = "response_code"
	}
}
