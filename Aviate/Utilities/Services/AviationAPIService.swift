//
//  AviationAPIService.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import Foundation

class AviationAPIService: AviationAPIServiceProtocol {
    private let apiClient: APIClientProtocol
    private let accessKey: String
    
    init(apiClient: APIClientProtocol = APIClient(baseURL: "https://api.aviationstack.com", apiKey: "2402c3e8ed6b6305eb833d250b1fb593")) {
        self.apiClient = apiClient
        self.accessKey = "2402c3e8ed6b6305eb833d250b1fb593"
    }
    
    func fetchAirlines(offset: Int? = nil, limit: Int? = nil) async throws -> [Airline]? {
        do {
            let response: AirlineResponse = try await apiClient.request(
                endpoint: .airlines(accessKey: accessKey, offset: offset, limit: limit)
            )
            return response.data
        } catch {
            throw error
        }
    }
    
    func fetchFlights(airlineIATA: String?, flightStatus: String? = nil, offset: Int? = nil, limit: Int? = nil) async throws -> [FlightData]? {
        do {
            let response: FlightResponse = try await apiClient.request(
                endpoint: .flights(
                    accessKey: accessKey,
                    airlineIATA: airlineIATA,
                    flightStatus: flightStatus,
                    offset: offset,
                    limit: limit
                )
            )
            return response.data
        } catch {
            throw error
        }
    }
    
    func fetchFlightDetails(flightNumber: String) async throws -> FlightData? {
        do {
            let response: FlightResponse = try await apiClient.request(
                endpoint: .flights(accessKey: accessKey, flightNumber: flightNumber)
            )
            guard let flight = response.data.first else {
                throw APIError.invalidResponse
            }
            return flight
        } catch {
            throw error
        }
    }
}


enum APIError: Error {
    case invalidURL
    case invalidResponse
    case statusCode(Int)
    case decodingError(Error)
    case unknown(Error)
}

protocol APIClientProtocol {
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T
}

struct APIClient: APIClientProtocol {
    private let session: URLSession
    private let baseURL: String
    private let apiKey: String
    
    init(session: URLSession = .shared, baseURL: String, apiKey: String) {
        self.session = session
        self.baseURL = baseURL
        self.apiKey = apiKey
    }
    
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        if let headers = endpoint.headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let body = endpoint.body {
            request.httpBody = try? JSONEncoder().encode(body)
        }
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.statusCode(httpResponse.statusCode)
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } catch {
                throw APIError.decodingError(error)
            }
        } catch {
            throw APIError.unknown(error)
        }
    }
}

// Models/Endpoint.swift
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct Endpoint {
    let path: String
    let method: HTTPMethod
    let queryItems: [URLQueryItem]
    let headers: [String: String]?
    let body: Encodable?
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.aviationstack.com"
        components.path = "/v1" + path
        
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        
        return components.url
    }
}

extension Endpoint {
    static func airlines(accessKey: String, offset: Int? = nil, limit: Int? = nil) -> Endpoint {
        var queryItems = [URLQueryItem(name: "access_key", value: accessKey)]
        
        if let offset = offset {
            queryItems.append(URLQueryItem(name: "offset", value: String(offset)))
        }
        
        if let limit = limit {
            queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
        }
        
        return Endpoint(
            path: "/airlines",
            method: .get,
            queryItems: queryItems,
            headers: nil,
            body: nil
        )
    }
    
    static func flights(accessKey: String,
                        airlineIATA: String? = nil,
                        flightNumber: String? = nil,
                        flightStatus: String? = nil,
                        offset: Int? = nil,
                        limit: Int? = nil) -> Endpoint {
        var queryItems = [URLQueryItem(name: "access_key", value: accessKey)]
        
        if let airlineIATA = airlineIATA {
            queryItems.append(URLQueryItem(name: "airline_iata", value: airlineIATA))
        }
        
        if let flightNumber = flightNumber {
            queryItems.append(URLQueryItem(name: "flight_iata", value: flightNumber))
        }
        
        if let flightStatus = flightStatus {
            queryItems.append(URLQueryItem(name: "flight_status", value: flightStatus))
        }
        
        if let offset = offset {
            queryItems.append(URLQueryItem(name: "offset", value: String(offset)))
        }
        
        if let limit = limit {
            queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
        }
        
        return Endpoint(
            path: "/flights",
            method: .get,
            queryItems: queryItems,
            headers: nil,
            body: nil
        )
    }
}
