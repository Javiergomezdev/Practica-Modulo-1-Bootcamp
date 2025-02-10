//
//  RoutesSErvice.swift
//  SnowTrails
//
//  Created by Javier Gomez on 6/2/25.
//
import Foundation

class RoutesService {
    private var points: [GeoPoint] = []
    private var routes: [Route] = []
    
    init() {
        loadDefaultPoints()
        loadDefaultsRoutes()
        
    }
    
    private func loadDefaultPoints() {
        let alpinaGrande = GeoPoint(name: "Alpina Grande", latitude: 46.0000, longitude: 7.5000, elevation: 1500.0)
        let alpinaPequena = GeoPoint(name: "Alpina Pequeña",latitude: 46.0022, longitude: 7.5200, elevation: 1200.0)
        let picoNevado = GeoPoint(name: "Pico Nevado",latitude: 41.6000, longitude: 7.6000, elevation: 1600.0)
        let valleBlanco = GeoPoint(name: "Valle Nevado",latitude: 45.9000, longitude: 7.4000, elevation: 1400.0)
        let cumbreAzul = GeoPoint(name: "Cumbre Azul",latitude: 46.0500, longitude: 7.5500, elevation: 1550.0)
        let lagoHelado = GeoPoint(name: "Lago Helado",latitude: 46.2000, longitude: 7.7000, elevation: 1700.0)
        let bosqueNevado = GeoPoint(name: "Bosque Nevado",latitude: 46.3000, longitude: 7.8000, elevation: 1800.0)
        let cerroPlateado = GeoPoint(name: "Cerro Plateado",latitude: 46.1500, longitude: 7.6500, elevation: 1650.0)
        let cascadaBlanca = GeoPoint(name: "Cascada Blanca",latitude: 46.2500, longitude: 7.7500, elevation: 1750.0)
        let refugioAlpino = GeoPoint(name: "Refugio Alpino",latitude: 46.0500, longitude: 7.4500, elevation: 1450.0)
        let refugioAislado = GeoPoint(name: "Refugio Aislado", latitude: 46.000, longitude: 7.4000, elevation: 1400.0)
        
        points.append(alpinaGrande)
        points.append(alpinaPequena)
        points.append(picoNevado)
        points.append(valleBlanco)
        points.append(cumbreAzul)
        points.append(lagoHelado)
        points.append(bosqueNevado)
        points.append(cerroPlateado)
        points.append(cascadaBlanca)
        points.append(refugioAlpino)
        points.append(refugioAislado)
        
    }
    private func findPoint(byName name: String) -> GeoPoint? {
        let foundPoint = points.first { $0.name == name }
        return foundPoint
    }
    private func loadDefaultsRoutes() {
        if let alpinaGrande = findPoint(byName: "Alpina Grande"), let picoNevado = findPoint(byName: "Pico Nevado"), let lagoHelado = findPoint(byName: "Lago Helado") {
            let route1 = Route(name: "Ruta del Pico Nevado y Lago Helado", points: [alpinaGrande, picoNevado, lagoHelado])
            routes.append(route1)
        }
        if let alpinaGrande = findPoint(byName: "Alpina Grande"), let valleBlanco = findPoint(byName: "Valle Blanco"), let refugioAlpino = findPoint(byName: "Refugio Alpino") {
            let route2 = Route(name: "Ruta de Valle Blanco y Refugeo Alpino", points: [alpinaGrande, valleBlanco, refugioAlpino])
            routes.append(route2)
        }
        if let alpinaGrande = findPoint(byName: "Alpina Grande"), let cumbreAzul = findPoint(byName: "Cumbre Azul"), let cerroPlateado = findPoint(byName: "Cerro Plateado") {
            let route3 = Route(name: "Ruta del Aplina Grande y Cerro Plateado", points: [alpinaGrande, cumbreAzul, cerroPlateado])
            routes.append(route3)
        }
        if let lagoHelado = findPoint(byName: "Lago Helado"), let bosqueNevado = findPoint(byName: "Bosque Nevado"), let cascadaBlanca = findPoint(byName: "Casacada Blanca") {
            let route4 = Route(name: "Ruta del Bosque Nevado y Cascada blanca", points: [lagoHelado, bosqueNevado, cascadaBlanca])
            routes.append(route4)
        }
        if let alpinaGrande = findPoint(byName: "Alpina Grande"), let picoNevado = findPoint(byName: "Pico Nevado"), let lagoHelado = findPoint(byName: "Lago Helado"), let bosqueNevado = findPoint(byName: "Bosque Nevado"), let cascadaBlanca = findPoint(byName: "Casacada Blanca"){
            let route5 = Route(name: "Ruta completa de Alpina Grande a Cascada blanca", points: [lagoHelado, bosqueNevado, cascadaBlanca])
            routes.append(route5)
        }
        if let refugioAislado = findPoint(byName: "Refugio Aislado"){
            let route6 = Route(name: "Ruta del Refugio Aislado", points: [refugioAislado])
            routes.append(route6)
        }
        if let alpinaGrande = findPoint(byName: "Alpina Grande"), let alpinaPequeña = findPoint(byName: "Bosque Nevado"), let cascadaBlanca = findPoint(byName: "Casacada Blanca") {
            let route7 = Route(name: "Ruta del Bosque Nevado y Cascada blanca", points: [alpinaGrande, alpinaPequeña])
            routes.append(route7)
        }
    }
    func getAllRoutes() -> [Route] {
        return routes
    }
    func distanceBetween(point1: GeoPoint, point2: GeoPoint) -> Double {
        let radioTierra = 6371000.0
        
        //convertimos a RAdianes
        let latitude1Rad = point1.latitude * .pi / 180
        let longitude1Rad = point1.longitude * .pi / 180
        let latitude2Rad = point2.latitude * .pi / 180
        let longitude2Rad = point2.longitude * .pi / 180
        
        //diferencias de las coordenadas
        let deltaLatitudeRad = latitude2Rad - latitude1Rad
        let deltaLongitudeRad = longitude2Rad - longitude1Rad
        let deltaAltitude = point2.elevation - point1.elevation
        
        let a = pow(radioTierra * deltaLatitudeRad, 2)
        let b = pow(radioTierra * cos(latitude1Rad) * deltaLongitudeRad, 2)
        let c = pow(deltaAltitude,2)
        
        
        let distancia = sqrt(a + b + c)
        
        return distancia
    }
    func distancePointsRoute(of route: Route) -> Double {
            guard route.points.count > 1 else { return 0.0 }
        let distances = zip(route.points, route.points.dropFirst()).map { (point1, point2) in
            distanceBetween(point1: point1, point2: point2)
            }
            return distances.reduce(0, +)
        }
    
    
        
}
