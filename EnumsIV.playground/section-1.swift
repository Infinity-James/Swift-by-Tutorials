import Foundation
import UIKit

enum Shape
{
	case Rectangle(width: Float, height: Float)
	case Square (dimension: Float)
	case Triangle(base: Float, height: Float)
	case Circle(radius: Float)
	
	init(rect: CGRect)
	{
		let width = Float(CGRectGetWidth(rect))
		let height = Float(CGRectGetHeight(rect))
		
		if width == height
		{
			self = Square(dimension: width)
		}
		
		else
		{
			self = Rectangle(width: width, height: height)
		}
	}
	
	static func fromString(string: String) -> Shape?
	{
		switch string.lowercaseString
		{
			case "rectangle":
				return Rectangle(width: 5.0, height: 10.0)
			case "square":
				return Square(dimension: 5.0)
			case "triangle":
				return Triangle(base: 5.0, height: 10.0)
			case "circle":
			 return Circle(radius: 5.0)
			default:
				return nil
		}
	}
	
	func area() -> Float
	{
		switch self
		{
		case .Rectangle(let width, let height):
			return width * height
		case .Square(let dimension):
			return dimension * dimension
		case .Triangle(let base, let height):
			return (base * height) / 2.0
		case .Circle(let radius):
			return Float(M_PI) * powf(radius, 2)
		}
	}
}

var circle = Shape.Circle(radius: 7.4)
circle.area()

var aShape = Shape(rect: CGRect(x: 0.0, y: 0.0, width: 5.0, height: 10.0))
aShape.area()

if let anotherShape = Shape.fromString("triangle")
{
	anotherShape.area()
}