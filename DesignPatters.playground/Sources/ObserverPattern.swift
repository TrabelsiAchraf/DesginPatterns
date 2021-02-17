import Foundation

public protocol IObserver {
    func update<T>(with data: T)
}

public protocol IObservable {
    associatedtype Observer: IObserver
    func add(observer: Observer)
    func remove(observer: Observer)
    func notify()
}

public class WeatherStation<T: IObserver>: IObservable {
    
    private var observers: [T]?
    
    public init() {
        observers = []
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.notify()
        }
    }
    
    public func add(observer: T) {
        observers?.append(observer)
    }
    
    public func remove(observer: T) {
        observers?.removeAll()
    }
    
    public func notify() {
        observers?.forEach { observer in
            observer.update(with: generateTemperature())
        }
    }
    
    private func generateTemperature() -> String {
        String(format: "%.2f°C", Float.random(in: -10...45))
    }
}

public class Display: IObserver {
    
    weak var weatherStation: WeatherStation<Display>?
    
    public init(weatherStation: WeatherStation<Display>) {
        self.weatherStation = weatherStation
    }
    
    public func update<String>(with data: String) {
        debugPrint(data)
    }
    
    public func observe() {
        self.weatherStation?.add(observer: self)
    }
    
    public func dispose() {
        weatherStation?.remove(observer: self)
    }
}
