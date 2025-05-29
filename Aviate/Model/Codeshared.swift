import Foundation

struct Codeshared: Codable {

    var airlineName: String?
    var airlineIata: String?
    var airlineIcao: String?
    var flightNumber: String?
    var flightIata: String?
    var flightIcao: String?

    private enum CodingKeys: String, CodingKey {
        case airlineName = "airline_name"
        case airlineIata = "airline_iata"
        case airlineIcao = "airline_icao"
        case flightNumber = "flight_number"
        case flightIata = "flight_iata"
        case flightIcao = "flight_icao"
    }

}
