"
Presents the color as rgb value and hexadecimal. Also represents to color on a small rectangle for a better perception of the choosed color.
"
Class {
	#name : 'CPColorCodePresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'rCodeInput',
		'gCodeInput',
		'bCodeInput',
		'hexaCode',
		'colorBox',
		'alphaColorBox'
	],
	#category : 'ColorPicker',
	#package : 'ColorPicker'
}

{ #category : 'specs' }
CPColorCodePresenter class >> defaultLayout [

	^ SpBoxLayout new
]

{ #category : 'initialization' }
CPColorCodePresenter >> chessPaintFor: aPoint [

	| canvas lines c h w |
	canvas := RSCanvas new extent: aPoint.
	lines := RSGroup new.
	h := aPoint y.
	w := aPoint x.
	1 to: (h / 7) asFloat ceiling do: [ :i |
		| line |
		line := RSGroup new.
		1 to: (w / 7) asFloat ceiling do: [ :j |
			line add: (RSBox new
					 extent: 7 asPoint;
					 color: ((j + i) even
							  ifTrue: [ Color gray ]
							  ifFalse: [ Color white ])) ].
		RSHorizontalLineLayout new
			gapSize: 0;
			on: line.
		lines add: line ].
	RSVerticalLineLayout new
		gapSize: 0;
		on: lines.
	c := lines flattened asShape.
	c position: 0 asPoint.
	canvas add: c.
	^ canvas asForm
]

{ #category : 'initialization' }
CPColorCodePresenter >> connectPresenters [

	"rCodeInput whenTextChangedDo: [  self updateColorCode ] "
]

{ #category : 'initialization' }
CPColorCodePresenter >> initializeLayout [

	self layout: (SpBoxLayout newLeftToRight
			 add: (SpBoxLayout newTopToBottom
					  spacing: 1;
					  add: (SpBoxLayout newLeftToRight
							   add: rCodeInput;
							   add: gCodeInput;
							   add: bCodeInput;
							   spacing: 1;
							   yourself)
					  expand: false;
					  add: (SpBoxLayout newLeftToRight
							   add: hexaCode;
							   yourself)
					  expand: false;
					  yourself);
			 add: colorBox;
			 spacing: 1;
			 yourself)
]

{ #category : 'initialization' }
CPColorCodePresenter >> initializePresenters [

	rCodeInput := self newTextInput.
	gCodeInput := self newTextInput.
	bCodeInput := self newTextInput.
	hexaCode := self newTextInput.
	colorBox := self instantiate: SpRoassalPresenter.
	colorBox canvas originTopLeft.
	alphaColorBox := RSBox new.

	colorBox canvas add: alphaColorBox.

	colorBox canvas
		when: RSExtentChangedEvent
		do: [ :evt |
			alphaColorBox
				translateTopLeftTo: 0 asPoint;
				extent: evt canvas extent x / 2 @ evt canvas extent y;
				paint: (self chessPaintFor: alphaColorBox extent) ]
		for: self.
	
	colorBox canvas add:
		((RSBitmap newFrom: (Smalltalk ui icons iconNamed: #haloScale))
			 size: 25;
			 yourself).
	colorBox canvas
		when: RSMouseClick
		do: [ :evt |
			Clipboard clipboardText: 'Color fromHexString: ' , '''' , hexaCode placeholder , ''''.
			self inform: 'Copied color' ]
		for: self.
	self initializeLayout
]

{ #category : 'initialization' }
CPColorCodePresenter >> setColor: aColor [

	hexaCode placeholder: aColor asHexString.
	bCodeInput placeholder: (aColor blue * 255) asInteger asString.
	gCodeInput placeholder: (aColor green * 255) asInteger asString.
	rCodeInput placeholder: (aColor red * 255) asInteger asString.
	colorBox canvas
		color: aColor;
		signalUpdate
]

{ #category : 'initialization' }
CPColorCodePresenter >> updateColorCode [

	| r g b range |
	range := 255.
	r := rCodeInput text asInteger.
	g := gCodeInput text asInteger.
	b := bCodeInput text asInteger.
	(r isNil or: [ g isNil or: [ b isNil ]]) ifTrue: [ ^self ].
	((r between: 0 and: range) and: [ 
		 (g between: 0 and: range) and: [ b between: 0 and: range ] ]) 
		ifTrue: [ 
			self owner updatedColorCode: (Color
					 r: r
					 g: g
					 b: b
					 range: range) ]
]
