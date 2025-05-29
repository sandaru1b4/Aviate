import Foundation

struct Departure: Codable {

    var airport: String?
    var timezone: String?
    var iata: String?
    var icao: String?
    var terminal: String?
    var gate: String?
    var delay: Int?
    var scheduled: String?
    var estimated: String?
//    var actual: Any?
//    var estimatedRunway: Any?
//    var actualRunway: Any?

    private enum CodingKeys: String, CodingKey {
        case airport = "airport"
        case timezone = "timezone"
        case iata = "iata"
        case icao = "icao"
        case terminal = "terminal"
        case gate = "gate"
        case delay = "delay"
        case scheduled = "scheduled"
        case estimated = "estimated"
//        case actual = "actual"
//        case estimatedRunway = "estimated_runway"
//        case actualRunway = "actual_runway"
    }

}
