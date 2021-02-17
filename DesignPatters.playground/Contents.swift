import Foundation

let weatherStation = WeatherStation<Display>()
let display = Display(weatherStation: weatherStation)

display.observe()

DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
    display.dispose()
}
