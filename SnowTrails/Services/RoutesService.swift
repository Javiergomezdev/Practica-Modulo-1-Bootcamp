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
    
    /// Carga los puntos geográficos por defecto.
    private func loadDefaultPoints() {
        let alpinaGrande = GeoPoint(name: "Alpina Grande", latitude: 46.0000, longitude: 7.5000, elevation: 1500.0)
        let alpinaPequena = GeoPoint(name: "Alpina Pequeña", latitude: 46.0022, longitude: 7.5200, elevation: 1200.0)
        let picoNevado = GeoPoint(name: "Pico Nevado", latitude: 46.1000, longitude: 7.6000, elevation: 1600.0)
        let valleBlanco = GeoPoint(name: "Valle Blanco", latitude: 45.9000, longitude: 7.4000, elevation: 1400.0)
        let cumbreAzul = GeoPoint(name: "Cumbre Azul", latitude: 46.0500, longitude: 7.5500, elevation: 1550.0)
        let lagoHelado = GeoPoint(name: "Lago Helado", latitude: 46.2000, longitude: 7.7000, elevation: 1700.0)
        let bosqueNevado = GeoPoint(name: "Bosque Nevado", latitude: 46.3000, longitude: 7.8000, elevation: 1800.0)
        let cerroPlateado = GeoPoint(name: "Cerro Plateado", latitude: 46.1500, longitude: 7.6500, elevation: 1650.0)
        let cascadaBlanca = GeoPoint(name: "Cascada Blanca", latitude: 46.2500, longitude: 7.7500, elevation: 1750.0)
        let refugioAlpino = GeoPoint(name: "Refugio Alpino", latitude: 46.0500, longitude: 7.4500, elevation: 1450.0)
        let refugioAislado = GeoPoint(name: "Refugio Aislado", latitude: 46.0000, longitude: 7.4000, elevation: 1400.0)
        
        points.append(contentsOf: [alpinaGrande, alpinaPequena, picoNevado, valleBlanco, cumbreAzul, lagoHelado, bosqueNevado, cerroPlateado, cascadaBlanca, refugioAlpino, refugioAislado])
    }
    
    /// Busca un punto geográfico por su nombre.
    private func findPoint(byName name: String) -> GeoPoint? {
        return points.first { $0.name == name }
    }
    
    /// Carga las rutas predefinidas.
    private func loadDefaultsRoutes() {
        if let alpinaGrande = findPoint(byName: "Alpina Grande"),
           let picoNevado = findPoint(byName: "Pico Nevado"),
           let lagoHelado = findPoint(byName: "Lago Helado") {
            let route1 = Route(name: "Ruta del Pico Nevado y Lago Helado", points: [alpinaGrande, picoNevado, lagoHelado])
            routes.append(route1)
        }
        
        if let alpinaGrande = findPoint(byName: "Alpina Grande"),
           let valleBlanco = findPoint(byName: "Valle Blanco"),
           let refugioAlpino = findPoint(byName: "Refugio Alpino") {
            let route2 = Route(name: "Ruta de Valle Blanco y Refugio Alpino", points: [alpinaGrande, valleBlanco, refugioAlpino])
            routes.append(route2)
        }
        
        if let alpinaGrande = findPoint(byName: "Alpina Grande"),
           let cumbreAzul = findPoint(byName: "Cumbre Azul"),
           let cerroPlateado = findPoint(byName: "Cerro Plateado") {
            let route3 = Route(name: "Ruta de Alpina Grande y Cerro Plateado", points: [alpinaGrande, cumbreAzul, cerroPlateado])
            routes.append(route3)
        }
        
        if let lagoHelado = findPoint(byName: "Lago Helado"),
           let bosqueNevado = findPoint(byName: "Bosque Nevado"),
           let cascadaBlanca = findPoint(byName: "Cascada Blanca") {
            let route4 = Route(name: "Ruta del Bosque Nevado y Cascada Blanca", points: [lagoHelado, bosqueNevado, cascadaBlanca])
            routes.append(route4)
        }
        
        if let alpinaGrande = findPoint(byName: "Alpina Grande"),
           let picoNevado = findPoint(byName: "Pico Nevado"),
           let lagoHelado = findPoint(byName: "Lago Helado"),
           let bosqueNevado = findPoint(byName: "Bosque Nevado"),
           let cascadaBlanca = findPoint(byName: "Cascada Blanca") {
            let route5 = Route(name: "Ruta completa de Alpina Grande a Cascada Blanca", points: [alpinaGrande, picoNevado, lagoHelado, bosqueNevado, cascadaBlanca])
            routes.append(route5)
        }
        
        if let refugioAislado = findPoint(byName: "Refugio Aislado") {
            let route6 = Route(name: "Ruta del Refugio Aislado", points: [refugioAislado])
            routes.append(route6)
        }
        
        if let alpinaGrande = findPoint(byName: "Alpina Grande"),
           let alpinaPequena = findPoint(byName: "Alpina Pequeña") {
            let route7 = Route(name: "Ruta Alpina", points: [alpinaGrande, alpinaPequena])
            routes.append(route7)
        }
    }
    
    func getAllRoutes() -> [Route] {
        return routes
    }
    
    /// Calcula la distancia entre dos puntos geográficos.
    func distanceBetween(point1: GeoPoint, point2: GeoPoint) -> Double {
        let radioTierra = 6371000.0
        
        let latitude1Rad = point1.latitude * .pi / 180
        let longitude1Rad = point1.longitude * .pi / 180
        let latitude2Rad = point2.latitude * .pi / 180
        let longitude2Rad = point2.longitude * .pi / 180
        
        let deltaLatitudeRad = latitude2Rad - latitude1Rad
        let deltaLongitudeRad = longitude2Rad - longitude1Rad
        let deltaAltitude = point2.elevation - point1.elevation
        
        let a = pow(radioTierra * deltaLatitudeRad, 2)
        let b = pow(radioTierra * cos(latitude1Rad) * deltaLongitudeRad, 2)
        let c = pow(deltaAltitude, 2)
        
        return sqrt(a + b + c)
    }
    
    /// Calcula la distancia total de una ruta.
    func distancePointsRoute(of route: Route) -> Double {
        guard route.points.count > 1 else { return 0.0 }
        
        return zip(route.points, route.points.dropFirst()).map { (point1, point2) in
            distanceBetween(point1: point1, point2: point2)
        }.reduce(0, +)
    }
}
