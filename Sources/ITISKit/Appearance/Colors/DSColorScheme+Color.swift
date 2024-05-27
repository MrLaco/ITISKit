import UIKit

public enum DSColorScheme: Int {
    case C100
    case C200
    case C300
    case C400
    case C500
    case C600
    case C700
    case C800
    case C900
}

public extension UIColor {

    func shade(_ colorScheme: DSColorScheme) -> UIColor {
        
        let multiplier = CGFloat(colorScheme.rawValue)
        
        let hue = getNewHue(adding: (5 * multiplier))
        let saturation = adapt(value: hsba.saturation, adding: -(2 * multiplier))
        let brightness = adapt(value: hsba.brightness, adding: -(5 * multiplier))
        
        var color = change(.hueHLC, to: hue)
        color = color.change(.saturation, to: saturation)
        color = color.change(.brightness, to: brightness)
        
        return color
    }

    func tint(_ colorScheme: DSColorScheme) -> UIColor {
        
        let multiplier = CGFloat(colorScheme.rawValue)
        
        let hue = getNewHue(adding: -(5 * multiplier))
        let saturation = adapt(value: hsba.saturation, adding: -(5 * multiplier))
        let luminance = adapt(value: hlca.luminance, adding: (2 * multiplier))
        
        var color = change(.hueHLC, to: hue)
        color = color.change(.saturation, to: saturation)
        color = color.change(.luminance, to: luminance)
        
        return color
    }

    func lighten(_ colorScheme: DSColorScheme) -> UIColor {
        
        let multiplier = CGFloat(colorScheme.rawValue)
        let maxSaturation: CGFloat = 0.01
        
        let saturationRange = Rescale<CGFloat>(from: (0.0, maxSaturation), to: (0, 100))
        let saturationRescaleRange = Rescale<CGFloat>(from: (0, 100), to: (0.0, maxSaturation))
        let adaptedSaturation = saturationRange.rescale(maxSaturation) + -(10 * multiplier)
        
        let minBrightness: CGFloat = 0.8
        let brightnessRange = Rescale<CGFloat>(from: (minBrightness, 1.0), to: (0, 100))
        let brightnessRescaleRange = Rescale<CGFloat>(from: (0, 100), to: (minBrightness, 1.0))
        let adaptedBrightness = brightnessRange.rescale(minBrightness) + (10 * multiplier)
            
        var color = change(.saturation, to: saturationRescaleRange.rescale(adaptedSaturation))
        color = color.change(.brightness, to: brightnessRescaleRange.rescale(adaptedBrightness))
        
        return color
    }

    func luminance(_ colorScheme: DSColorScheme) -> UIColor {
        
        let multiplier = CGFloat(colorScheme.rawValue)
        let luminance = adapt(value: hlca.luminance, adding: (2 * multiplier))
        return self.change(.luminance, to: luminance)
    }

    var semanticRedColor: UIColor {
        var color = self.change(.hueHSB, to: makeHue(0))
        color = color.change(.saturation, to: 0.8)
        color = color.change(.brightness, to: 0.8)
        return color
    }

    var semanticYellowColor: UIColor {
        var color = self.change(.hueHSB, to: makeHue(50))
        color = color.change(.saturation, to: 0.8)
        color = color.change(.brightness, to: 0.8)
        return color
    }

    var semanticGreenColor: UIColor {
        var color = self.change(.hueHLC, to: makeHue(120))
        color = color.change(.saturation, to: 0.8)
        return color
    }

    var semanticBlueColor: UIColor {
        var color = self.change(.hueHLC, to: makeHue(240))
        color = color.change(.saturation, to: 0.8)
        return color
    }

    private func makeHue(_ hue: CGFloat) -> CGFloat {
        let hlcRange = Rescale<CGFloat>(from: (0, 360), to: (0.0, 1.0))
        return hlcRange.rescale(hue)
    }

    private func getNewHue(adding: CGFloat) -> CGFloat {
        let orignialRange = Rescale<CGFloat>(from: (0.0, 1.0), to: (0, 360))
        let hlcRange = Rescale<CGFloat>(from: (0, 360), to: (0.0, 1.0))
        let adaptedHue = orignialRange.rescale(self.hlca.hue) + adding
        return hlcRange.rescale(adaptedHue)
    }

    private func adapt(value: CGFloat, adding: CGFloat) -> CGFloat {
        let orignialRange = Rescale<CGFloat>(from: (0.0, 1.0), to: (0, 100))
        let hlcRange = Rescale<CGFloat>(from: (0, 100), to: (0.0, 1.0))
        
        var adapted = orignialRange.rescale(value) + adding
        
        if adapted > 100 {
            adapted = 100
        }
        
        return hlcRange.rescale(adapted)
    }
}
