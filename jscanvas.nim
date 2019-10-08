## This module, which targets JavaScript, is a wrapper for the `Canvas API
## <https://developer.mozilla.org/en-US/docs/Web/API/Canvas_API>`_.
##
## This module aims at being a wrapper for the Canvas API. Currently
## only a subset of objects, method overloads and default parameters are
## interfaced.
import dom

type
   # https://developer.mozilla.org/en-US/docs/Web/API/HTMLCanvasElement
   CanvasElement* {.importc: "HTMLCanvasElement".} = ref object of Element
      height*: int
      width*: int

   # https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D
   CanvasContext* {.importc: "CanvasRenderingContext2D".} = ref object
      # Line styles
      lineWidth*: int
      lineCap*: cstring
      lineJoin*: cstring
      miterLimit*: int
      lineDashOffset*: float
      # Text styles
      font*: cstring
      textAlign*: cstring
      textBaseline*: cstring
      # Compositing
      globalAlpha*: float
      globalCompositeOperation*: cstring
      # Image smoothing
      imageSmoothingEnabled*: bool
      imageSmoothingQuality*: bool
      # The canvas state
      canvas*: CanvasElement

   ImageSmoothingQuality* {.pure.} = enum
      Low = "low",
      Medium = "medium",
      High = "high"

   LineCap* {.pure.} = enum
      Butt = "butt",
      Round = "round",
      Square = "square"

   LineJoin* {.pure.} = enum
      Bevel = "bevel",
      Round = "round",
      Miter = "miter"

   TextAlignment* {.pure.} = enum
      Left = "left",
      Right = "right",
      Center = "center",
      Start = "start",
      End = "end"

   TextBaseline* {.pure.} = enum
      Top = "top",
      Hanging = "hanging",
      Middle = "middle",
      Alphabetic = "alphabetic",
      Ideographic = "ideographic",
      Bottom = "bottom"

   CompositeOperation* {.pure.} = enum
      SourceOver = "source-over",
      SourceIn = "source-in",
      SourceOut = "source-out",
      SourceAtop = "source-atop",
      DestinationOver = "destination-over",
      DestinationIn = "destination-in",
      DestinationOut = "destination-out",
      DestinationAtop = "destination-atop",
      Lighter = "lighter",
      Copy = "copy",
      Xor = "xor",
      Multiply = "multiply",
      Screen = "screen",
      Overlay = "overlay",
      Darken = "darker",
      Lighten = "lighten",
      ColorDodge = "color-dodge",
      ColorBurn = "color-burn",
      HardLight = "hard-light",
      SoftLight = "soft-light",
      Difference = "difference",
      Exclusion = "exculsion",
      Hue = "hue",
      Saturation = "saturation",
      Color = "color",
      Luminosity = "luminosity"

   # https://developer.mozilla.org/en-US/docs/Web/API/CanvasPattern
   CanvasPattern* {.importc.} = ref object

   # https://developer.mozilla.org/en-US/docs/Web/API/CanvasGradient
   CanvasGradient* {.importc.} = ref object

   Repetition* {.pure.} = enum
      Repeat = "repeat",
      RepeatX = "repeat-x",
      RepeatY = "repeat-y",
      NoRepeat = "no-repeat"

   # https://developer.mozilla.org/en-US/docs/Web/API/Path2D
   Path* {.importc: "Path2D".} = ref object

   CanvasFillRule* {.pure.} = enum
      NonZero = "nonzero",
      EvenOdd = "evenodd"

   # https://developer.mozilla.org/en-US/docs/Web/API/ImageData
   ImageData* {.importc.} = ref object
      data*: seq[byte]
      width*: int
      height*: int

# Fill and stroke styles
proc `fillStyle=`*(self: CanvasContext, color: cstring) {.importcpp: "#.fillStyle = #", nodecl.}
proc `fillStyle=`*(self: CanvasContext, gradient: CanvasGradient) {.importcpp: "#.fillStyle = #", nodecl.}
proc `fillStyle=`*(self: CanvasContext, pattern: CanvasPattern) {.importcpp: "#.fillStyle = #", nodecl.}
proc `strokeStyle=`*(self: CanvasContext, color: cstring) {.importcpp: "#.strokeStyle = #", nodecl.}
proc `strokeStyle=`*(self: CanvasContext, gradient: CanvasGradient) {.importcpp: "#.strokeStyle = #", nodecl.}
proc `strokeStyle=`*(self: CanvasContext, pattern: CanvasPattern) {.importcpp: "#.strokeStyle = #", nodecl.}

# Path constructor
proc newPath*(): Path {.importcpp: "new Path2D(@)", constructor.}
proc newPath*(path: Path): Path {.importcpp: "new Path2D(@)", constructor.}
proc newPath*(d: cstring): Path {.importcpp: "new Path2D(@)", constructor.}

# CanvasElement "methods"
proc getContext2d*(c: CanvasElement): CanvasContext {.
   importcpp: "#.getContext('2d')", nodecl.}

{.push importcpp.}

# CanvasContext "methods"
# Drawing rectangles
proc clearRect*(self: CanvasContext, x, y, width, height: int | float)
proc fillRect*(self: CanvasContext, x, y, width, height: int | float)
proc strokeRect*(self: CanvasContext, x, y, width, height: int | float)

# Drawing text
proc fillText*(self: CanvasContext, text: cstring, x, y: int | float)
proc strokeText*(self: CanvasContext, text: cstring, x, y: int | float)

# Line styles
proc setLineDash*(self: CanvasContext, segments: seq[int])

# Gradients and patterns
proc createLinearGradient*(self: CanvasContext, x0, y0, x1, y1: int | float): CanvasGradient
proc createRadialGradient*(self: CanvasContext, x0, y0, r0, x1, y1, r1: int | float): CanvasGradient
proc createPattern*(image: ImageElement, repetition: cstring): CanvasPattern
proc createPattern*(image: CanvasElement, repetition: cstring): CanvasPattern

# Paths
proc beginPath*(self: CanvasContext)
proc closePath*(self: CanvasContext)
proc moveTo*(self: CanvasContext, x, y: int | float)
proc lineTo*(self: CanvasContext, x, y: int | float)
proc bezierCurveTo*(self: CanvasContext, cp1x, cp1y, cp2x, cp2y, x, y: int | float)
proc quadraticCurveTo*(self: CanvasContext, cpx, cpy, x, y: int | float)
proc arc*(self: CanvasContext, x, y, radius: int | float, startAngle, endAngle: float, anticlockwise = false)
proc arcTo*(self: CanvasContext, x1, y1, x2, y2, radius: int | float)
proc ellipse*(self: CanvasContext, x, y, radiusX, radiusY: int | float, rotation, startAngle, endAngle: float, anticlockwise = false)
proc rect*(self: CanvasContext, x, y, width, height: int | float)

# Drawing paths
proc fill*(self: CanvasContext, fillRule: cstring = $NonZero)
proc fill*(self: CanvasContext, path: Path, fillRule: cstring = $NonZero)
proc stroke*(self: CanvasContext)
proc stroke*(self: CanvasContext, path: Path)
proc drawFocusIfNeeded*(self: CanvasContext, element: Element)
proc drawFocusIfNeeded*(self: CanvasContext, path: Path, element: Element)
proc scrollPathIntoView*(self: CanvasContext)
proc scrollPathIntoView*(self: CanvasContext, path: Path)
proc clip*(self: CanvasContext, fillRule: cstring = $NonZero)
proc clip*(self: CanvasContext, path: Path, fillRule: cstring = $NonZero)
proc isPointInPath*(self: CanvasContext, x, y: int | float, fillRule: cstring = $NonZero): bool
proc isPointInPath*(self: CanvasContext, path: Path, x, y: int | float, fillRule: cstring = $NonZero): bool
proc isPointInStroke*(self: CanvasContext, x, y: int | float): bool
proc isPointInStroke*(self: CanvasContext, path: Path, x, y: int | float): bool

# Transformations
proc rotate*(self: CanvasContext, angle: float)
proc scale*(self: CanvasContext, x, y: int | float)
proc translate*(self: CanvasContext, x, y: int | float)
proc transform*(self: CanvasContext, a, b, c, d, e, f: float)
proc setTransform*(self: CanvasContext, a, b, c, d, e, f: float)

# Drawing images
proc drawImage*(self: CanvasContext, image: CanvasElement, dx, dy: int | float)
proc drawImage*(self: CanvasContext, image: CanvasElement, dx, dy, dWidth, dHeight: int | float)
proc drawImage*(self: CanvasContext, image: CanvasElement, sx, sy, sWidth, sHeight, dx, dy, dWidth, dHeight: int | float)
proc drawImage*(self: CanvasContext, image: ImageElement, dx, dy: int | float)
proc drawImage*(self: CanvasContext, image: ImageElement, dx, dy, dWidth, dHeight: int | float)
proc drawImage*(self: CanvasContext, image: ImageElement, sx, sy, sWidth, sHeight, dx, dy, dWidth, dHeight: int | float)

# Pixel manipulation
proc createImageData*(self: CanvasContext, sw, sh: int | float): ImageData
proc createImageData*(self: CanvasContext, imagedata: ImageData): ImageData
proc getImageData*(self: CanvasContext, s, sy, sw, sh: int | float): ImageData
proc putImageData*(self: CanvasContext, imagedata: ImageData, dx, dy: int | float)
proc putImageData*(self: CanvasContext, imagedata: ImageData, dx, dy, dirtyX, dirtyY, dirtyWidth, dirtyHeight: int | float)

# The canvas state
proc save*(self: CanvasContext)
proc restore*(self: CanvasContext)

# CanvasGradient "methods"
proc addColorStop*(self: CanvasGradient, offset: float, color: cstring)

# Path "methods"
proc addPath*(self, path: Path)
proc closePath*(self: Path)
proc moveTo*(self: Path, x, y: int | float)
proc lineTo*(self: Path, x, y: int | float)
proc quadraticCurveTo*(self: Path, cpx, cpy, x, y: int | float)
proc bezierCurveTo*(self: Path, cp1x, cp1y, cp2x, cp2y, x, y: int | float)
proc arcTo*(self: Path, x1, y1, x2, y2, radius: int | float)
proc rect*(self: Path, x, y, w, h: int | float)
proc arc*(self: Path, x, y, radius: int | float, startAngle, endAngle: float, anticlockwise = false)
proc ellipse*(self: Path, x, y, radiusX, radiusY: int | float, rotation, startAngle, endAngle: float, anticlockwise = false)

{.pop.}
