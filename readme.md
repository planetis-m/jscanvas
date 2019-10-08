
# JsCanvas — A Nim wrapper for the [Canvas API](https://developer.mozilla.org/en-US/docs/Web/API/Canvas_API)

## Example

```nim
import jscanvas, colors, dom, math

var canvas = document.getElementById("canvas").CanvasElement
canvas.width = 480
canvas.height = 320

var ctx = canvas.getContext2d()

# Draw a ball
var x = canvas.width div 2
var y = canvas.height - 30
var ballRadius = 10

ctx.beginPath()
ctx.arc(x, y, ballRadius, 0, Pi*2)
ctx.fillStyle = $colBlack # could also be: $rgb(0, 0, 0) or just "rgb(0,0,0)"
ctx.fill()
ctx.closePath()
```
