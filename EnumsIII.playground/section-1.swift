enum Shape
{
	case Rectangle(width: Float, height: Float)
	case Square (dimension: Float)
	case Triangle(base: Float, height: Float)
	case Circle(radius: Float)
}

var rectangle = Shape.Rectangle(width: 5.0, height: 10.0)
var circle = Shape.Circle(radius: 4.0)

switch rectangle
{
	case .Rectangle(let width, let height) where width <= height:
		println("Narrow rectangle: \(width) x \(height)")
	case .Rectangle (let width, let height):
		println("Wide triangle: \(width) x \(height)")
	default:
		println("Other shape")
}

