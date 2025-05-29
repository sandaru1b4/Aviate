import Foundation

struct Arrival: Codable {

    var airport: String?
    var timezone: String?
    var iata: String?
    var icao: String?
    var terminal: String?
    var gate: String?
    var scheduled: String?
    var delay: Int?
    var estimated: String?

    private enum CodingKeys: String, CodingKey {
        case airport = "airport"
        case timezone = "timezone"
        case iata = "iata"
        case icao = "icao"
        case terminal = "terminal"
        case gate = "gate"
        case scheduled = "scheduled"
        case delay = "delay"
        case estimated = "estimated"
    }

}
