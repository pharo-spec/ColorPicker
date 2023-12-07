"
A spec color picker. Using roassal to display slider and color map.
This color picker is using the HSL representation of colors to let user pick color.

This color picker has: 
- A color map: a two-dimensional rectangle mapping saturation and ligntness to the dimensions.
- A hue slider: an horizontal strip mapping the hue to one dimension.
- A color presenter: presents the color as rgb value and hexadecimal. Also represents to color on a small rectangle for a better perception of the choosed color. 
- Color palettes: present color palettes of Roassal, see Roassal color palettes for more information.

This class is responsible to synchronize all these components when when action was done on a specific component. For instance, if the hue was changed using the color slider, it updates the color for other presenters.
"
Class {
	#name : #CPColorPicker,
	#superclass : #SpPresenter,
	#instVars : [
		'colorSlider',
		'colorMap',
		'colorCodePresenter',
		'color',
		'hue',
		'brightness',
		'saturation',
		'paletteChooser',
		'actionBlock'
	],
	#category : #ColorPicker
}

{ #category : #specs }
CPColorPicker class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: #colorPicker expand: false;
		  add: #colorSlider expand: false;
		  add: (SpBoxLayout newLeftToRight
				   add: #rCode;
				   add: #gCode;
				   add: #bCode;
				   yourself) expand: false;
		  yourself
]

{ #category : #specs }
CPColorPicker class >> openExemple [

	<script>
	^ self new
		  open;
		  yourself
]

{ #category : #accessing }
CPColorPicker >> color [

	^ color
]

{ #category : #accessing }
CPColorPicker >> color: anObject [

	color := anObject
]

{ #category : #accessing }
CPColorPicker >> hue [

	^ hue
]

{ #category : #accessing }
CPColorPicker >> hue: anObject [

	hue := anObject
]

{ #category : #initialization }
CPColorPicker >> initialize [

	super initialize.
	hue := 0.
	brightness := 1.
	saturation := 1.
	actionBlock := [ :c |  ].
	self setColor: Color blue
]

{ #category : #initialization }
CPColorPicker >> initializeLayout [

	self layout: (SpBoxLayout newTopToBottom
			 add: colorMap height: 130;
			 add: colorSlider expand: false;
			 add: colorCodePresenter expand: false;
			 add: paletteChooser;
			 spacing: 2;
			 yourself)
]

{ #category : #initialization }
CPColorPicker >> initializePresenters [

	colorSlider := self instantiate: CPColorSlider.
	colorCodePresenter := self instantiate: CPColorCodePresenter.
	colorMap := self instantiate: CPColorMap.
	paletteChooser := self instantiate: CPSmallColorPalette.
	self initializeLayout
]

{ #category : #initialization }
CPColorPicker >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Color picker';
		initialExtent: 260@400;
		windowIcon: self windowIcon
]

{ #category : #update }
CPColorPicker >> setColor: aColor [

	color := aColor.
	hue := aColor hue.
	saturation := aColor saturation.
	brightness := aColor brightness.
	colorMap setColor: aColor.
	colorSlider setColor: aColor.
	colorCodePresenter setColor: aColor.
	actionBlock value: aColor
]

{ #category : #update }
CPColorPicker >> updateHue: aHue [

	| c |
	hue := aHue.
	colorMap setHue: hue.
	c := Color h: hue s: saturation v: brightness.
	color := c.
	colorCodePresenter setColor: c.
	actionBlock value: c
]

{ #category : #update }
CPColorPicker >> updateSaturation: s brightness: v [

	| c |
	saturation := s.
	brightness := v.
	c := Color h: hue s: saturation v: brightness.
	color := c.
	colorCodePresenter setColor: c.
	actionBlock value: c
]

{ #category : #update }
CPColorPicker >> whenColorChangedDo: aBlock [

	actionBlock := aBlock
]
