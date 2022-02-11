//
//  StarWarsPlanetsModel.swift
//  Social_Network
//
//  Created by Arthur Raff on 18.04.2021.
//
struct StarWarsPlanetsModel: Codable {
    let name, rotationPeriod, orbitalPeriod, diameter: String?
    let climate, gravity, terrain, surfaceWater: String?
    let population: String?
    let residents, films: [String]?
    let created, edited: String?
    let url: String?
}
