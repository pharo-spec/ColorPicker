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
	#name : 'CPColorPicker',
	#superclass : 'SpPresenter',
	#instVars : [
		'alphaSlider',
		'colorSlider',
		'colorMap',
		'colorCodePresenter',
		'color',
		'hue',
		'brightness',
		'saturation',
		'paletteChooser',
		'actionBlock',
		'presenters'
	],
	#category : 'ColorPicker',
	#package : 'ColorPicker'
}

{ #category : 'specs' }
CPColorPicker class >> open [

	<script>
	^ self new
		  open;
		  yourself
]

{ #category : 'accessing' }
CPColorPicker >> color [

	^ color
]

{ #category : 'accessing' }
CPColorPicker >> color: anObject [

	color := anObject
]

{ #category : 'layout' }
CPColorPicker >> defaultLayout [

	| sp sp2 |
	sp := self newRoassal.
	sp2 := self newPresenter.
	sp2 layout: SpBoxLayout newTopToBottom.
	sp canvas color: Color black translucent.
	
	^ SpBoxLayout newTopToBottom
		add: colorMap height: 150;
		add: colorSlider height: 25;
		add: alphaSlider height: 25;
		add: colorCodePresenter expand: false;
		add: sp2 height: 10;
		add: sp height: 1;
		add: paletteChooser;
		spacing: 1;
		yourself.
]

{ #category : 'accessing' }
CPColorPicker >> hue [

	^ hue
]

{ #category : 'accessing' }
CPColorPicker >> hue: anObject [

	hue := anObject
]

{ #category : 'initialization' }
CPColorPicker >> initialize [

	super initialize.
	hue := 0.
	brightness := 1.
	saturation := 1.
	actionBlock := [ :c |  ].
	self setColor: Color blue
]

{ #category : 'initialization' }
CPColorPicker >> initializePresenters [

	colorSlider := self instantiate: CPColorSlider.
	alphaSlider := self instantiate: CPAlphaSlider.
	colorCodePresenter := self instantiate: CPColorCodePresenter.
	colorMap := self instantiate: CPColorMap.
	paletteChooser := self instantiate: CPSmallColorPalette.
	presenters := {
		              colorSlider.
		              colorCodePresenter.
		              colorMap.
		              paletteChooser.
		              alphaSlider }.
]

{ #category : 'initialization' }
CPColorPicker >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Color picker';
		initialExtent: 300 @ 450;
		windowIcon: self windowIcon
]

{ #category : 'update' }
CPColorPicker >> setColor: aColor [

	color := aColor.
	hue := aColor hue.
	saturation := aColor saturation.
	brightness := aColor brightness.
	colorMap setColor: aColor.
	colorSlider setColor: aColor.
	colorCodePresenter setColor: aColor.
	alphaSlider setColor: aColor.
	actionBlock value: aColor
]

{ #category : 'update' }
CPColorPicker >> updateHue: aHue [

	| c |
	hue := aHue.
	colorMap setHue: hue.
	c := Color h: hue s: saturation v: brightness.
	color := c.
	colorCodePresenter setColor: c.
	alphaSlider setColor: c.
	actionBlock value: c
]

{ #category : 'update' }
CPColorPicker >> updateSaturation: s brightness: v [

	| c |
	
	saturation := s.
	brightness := v.
	c := Color h: hue s: saturation v: brightness.
	color := c.
	colorCodePresenter setColor: c.
	alphaSlider setColor: c.
	actionBlock value: c
]

{ #category : 'update' }
CPColorPicker >> whenColorChangedDo: aBlock [

	actionBlock := aBlock
]
