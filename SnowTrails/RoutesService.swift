//
//  RoutesSErvice.swift
//  SnowTrails
//
//  Created by Javier Gomez on 6/2/25.
//

class RoutesService {
    private var points: [GeoPoint] = []
    private var routes: [Route] = []
    
    init() {
        LoadDefaultPoints()
        
    }
    
    private func loadDefaultPoints() {
        let alpinaGrande = GeoPoint(name: "Alpina Grande", latitude: 46.0000, longitude: 7.5000, elevation: 1500.0)
        let alpinaPequeña = GeoPoint(name: "Alpina Pequeña",latitude: 46,0022, longitude: 7.5200, elevation: 1200.0)
        let picoNevado = GeoPoint(name: "Pico Nevado",latitude: 41.6000, longitude: 7.6000, elevation: 1600.0)
        let valleBlanco = GeoPoint(name: "Valle Nevado",latitude: 45.9000, longitude: 7.4000, elevation: 1400.0)
        let cumbreAzul = GeoPoint(name: "Cumbre Azul",latitude: 46.0500, longitude: 7.5500, elevation: 1550.0)
        let lagoHelado = GeoPoint(name: "Lago Helado",latitude: 46.2000, longitude: 7.7000, elevation: 1700.0)
        let bosqueNevado = GeoPoint(name: "Bosque Nevado",latitude: 46.3000, longitude: 7.8000, elevation: 1800.0)
        let cerroPlateado = GeoPoint(name: "Cerro Plateado",latitude: 46.1500, longitude: 7.6500, elevation: 1650.0)
        let cascadaBlanca = GeoPoint(name: "Cascada Blanca",latitude: 46.2500, longitude: 7.7500, elevation: 1750.0)
        let refugioAlpino = GeoPoint(name: "Refugio Alpino",latitude: 46.0500, longitude: 7.4500, elevation: 1450.0)
        let refugioAislado = GeoPointname: "Refugio Aislado",(latitude: 46.000, longitude: 7.4000, elevation: 1400.0)
        points.append(alpinaGrande)
        points.append(alpinaPequeña)
        points.append(picoNEvado)
        points.append(valleBlanco)
        points.append(cumbreAzul)
        points.append(lagoHelado)
        points.append(bosqueNevado)
        points.append(cerroPlateado)
        points.append(cascadaBlanca)
        points.append(refugioAlpino)
        points.append(refugioAislado)
        
    }
    private func loadDefaultsRoutes() {
        
    }
}
