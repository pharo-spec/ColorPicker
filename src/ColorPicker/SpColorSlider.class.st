"
An horizontal strip mapping the hue to one dimension.
"
Class {
	#name : 'SpColorSlider',
	#superclass : 'SpRoassalPresenter',
	#instVars : [
		'hue',
		'rainbowSlider',
		'circleHue'
	],
	#category : 'ColorPicker',
	#package : 'ColorPicker'
}

{ #category : 'initialization' }
SpColorSlider >> gradientPaintHues [
	"Creates the gradiant paint used as background in the slider. So the user can see color hues."

	| hues maxHueValue |
	maxHueValue := 360.
	hues := OrderedCollection new.
	0 to: 1 by: 0.1 do: [ :step |
	hues add: step -> (Color h: step * maxHueValue s: 1 v: 1) ].

	^ (LinearGradientPaint fromArray: hues)
		  start: -1 * self sliderWidth / 2 @ 0;
		  stop: self sliderWidth / 2 @ 0;
		  yourself
]

{ #category : 'initialization' }
SpColorSlider >> hueChanged: evt [
	"When hue change, update circle pointer position. And notify change."

	| c |
	"Wierd computation due to origin center in Roassal."
	(evt position x
		 between: -1 * rainbowSlider width / 2
		 and: rainbowSlider width / 2) ifFalse: [ "If not in bounds, do nothing"
		^ self ].

	c := self hueFromPosition: evt position.

	circleHue color: c.
	circleHue translateTo: evt position x @ 0.

	self owner updateHue: hue.

	circleHue signalUpdate
]

{ #category : 'hooks' }
SpColorSlider >> hueFromPosition: aPoint [
	"Computes color hue from a position within the slider."

	| offset |
	offset := self sliderWidth / 2 + aPoint x.
	hue := (offset * 360 / self sliderWidth) floor.
	^ Color h: hue s: 1 v: 1
]

{ #category : 'initialization' }
SpColorSlider >> initializeCanvas [

	| can slider paint |
	can := self canvas
		       extent: self sliderWidth @ self sliderHeight;
		       color: Color transparent;
		       yourself.
	slider := RSComposite new.

	paint := self gradientPaintHues.
	rainbowSlider := RSBox new
		                 cornerRadius: 10;
		                 border: (RSBorder new
				                  width: 1;
				                  color: Color black translucent;
				                  yourself);
		                 extent: self sliderWidth @ self sliderHeight;
		                 paint: paint.
	circleHue := RSCircle new
		             radius: 8;
		             border: (RSBorder new
				              width: 2;
				              color: Color gray).
	slider
		when: RSMouseDragging send: #hueChanged: to: self;
		when: RSMouseLeftClick send: #hueChanged: to: self.
	slider add: rainbowSlider.
	can
		add: slider;
		add: circleHue.
	slider adjustToChildren
]

{ #category : 'initialization' }
SpColorSlider >> initializePresenters [

	self initializeCanvas.
	
]

{ #category : 'hooks' }
SpColorSlider >> positionFromHue: aHue [
	"Computes the position of the circle pointer within the slider from a color hue."

	^ (hue * self sliderWidth / 360) floor - (self sliderWidth / 2) @ 0
]

{ #category : 'initialization' }
SpColorSlider >> setColor: aColor [

	self updateCirclePointerWith: aColor hue
]

{ #category : 'initialization' }
SpColorSlider >> sliderHeight [

	^ 10
]

{ #category : 'initialization' }
SpColorSlider >> sliderWidth [

	^ 240
]

{ #category : 'initialization' }
SpColorSlider >> updateCirclePointerWith: h [
	"Updates color and position of circle pointer with a given color."
	hue := h.
	circleHue translateTo: (self positionFromHue: h).
	circleHue color: (Color h: h s: 1 v: 1).
	circleHue signalUpdate
]
