enum Shape
{
	case Rectangle
	case Square
	case Triangle
	case Circle
}

var aShape = Shape.Rectangle

switch (aShape)
{
	case .Rectangle:
		println("This is a rectangle.")
	case .Square:
		println("This is a square.")
	default:
		break
}

