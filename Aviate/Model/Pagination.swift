
import Foundation

struct Pagination: Codable {

    var offset: Int?
    var limit: Int?
    var count: Int?
    var total: Int?

    private enum CodingKeys: String, CodingKey {
        case offset = "offset"
        case limit = "limit"
        case count = "count"
        case total = "total"
    }

}
