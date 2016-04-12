enum Shape: Int
{
	case Rectangle
	case Square
	case Triangle
	case Circle
}

var aShape = Shape.Triangle
var anotherShape: Shape = .Circle

aShape = .Square

aShape.rawValue

var rectangle = Shape(rawValue: 0)

var notAValidShape = Shape(rawValue: 40)

enum Ratios: Float
{
	case pi = 3.141
	case tau = 6.283
}