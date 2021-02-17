import Foundation

public protocol IObserver {
    associatedtype Item
    func update(data: Item)
}

public protocol IObservable {
    associatedtype Obs
    func add(observer: Obs)
    func remove(observer: Obs)
    func notify()
}

public class WeatherStation<T: IObserver>: IObservable {
    
    private var observers: [T]?
    
    public init() {
        observers = []
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.notify()
        }
    }
    
    public func add(observer: T) {
        observers?.append(observer)
    }
    
    public func remove(observer: T) {
        
    }
    
    public func notify() {
        observers?.forEach { observer in
            observer.update(data: retrieveTemperature() as! T.Item)
        }
    }
    
    func retrieveTemperature() -> String {
        String(format: "%.2f°C", Float.random(in: -10...45))
    }
}

public class Display: IObserver {
    public typealias Item = String
    
    var weatherStation: WeatherStation<Self>
    
    public init(weatherStation: WeatherStation) {
        self.weatherStation = weatherStation
        self.weatherStation.add(observer: self)
    }
    
    public func update(data: Item) {
        
    }
    
    func update() {
        print(weatherStation.retrieveTemperature())
    }
}

