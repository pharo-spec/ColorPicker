"
Presents the color as rgb value and hexadecimal. Also represents to color on a small rectangle for a better perception of the choosed color.
"
Class {
	#name : 'SpColorCodePresenter',
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

{ #category : 'initialization' }
SpColorCodePresenter >> chessPaintFor: aPoint [

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
SpColorCodePresenter >> connectPresenters [

	"rCodeInput whenTextChangedDo: [  self updateColorCode ] "
]

{ #category : 'layout' }
SpColorCodePresenter >> defaultLayout [

	^ SpBoxLayout newLeftToRight
			beHomogeneous;
			 add: (SpBoxLayout newTopToBottom
					  spacing: 1;
					  add: (SpBoxLayout newLeftToRight
							   add: (SpBoxLayout
									newTopToBottom
										add: (SpLabelPresenter new label: 'R');
										add: rCodeInput;
										yourself);
							   add: (SpBoxLayout
									newTopToBottom
										add: (SpLabelPresenter new label: 'G');
										add: gCodeInput;
										yourself);
							   add: (SpBoxLayout
									newTopToBottom
										add: (SpLabelPresenter new label: 'B');
										add: bCodeInput;
										yourself);
							   spacing: 1;
							   yourself);
					  add: (SpBoxLayout newLeftToRight
							   add: (SpBoxLayout
									newTopToBottom
										add: (SpLabelPresenter new label: 'Hex');
										add: hexaCode;
										yourself);
							   yourself);
					  yourself);
			 add: colorBox;
			 spacing: 1;
			 yourself
]

{ #category : 'initialization' }
SpColorCodePresenter >> initializePresenters [

	rCodeInput := self newNumberInput
		beInteger;
		help: 'Red';
		minimum: 0;
		maximum: 255;		
		yourself.
	gCodeInput := self newNumberInput
		beInteger;	
		help: 'Green';
		minimum: 0;
		maximum: 255;	
		yourself.
	bCodeInput := self newNumberInput
		beInteger;
		help: 'Blue';
		minimum: 0;
		maximum: 255;	
		yourself.
	hexaCode := self newTextInput
		help: 'Hexadecimal';
		yourself.	
	self initializeRoassalPresenters.
]

{ #category : 'initialization' }
SpColorCodePresenter >> initializeRoassalPresenters [

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
]

{ #category : 'initialization' }
SpColorCodePresenter >> setColor: aColor [

	hexaCode text: aColor asHexString.
	bCodeInput text: (aColor blue * 255) asInteger asString.
	gCodeInput text: (aColor green * 255) asInteger asString.
	rCodeInput text: (aColor red * 255) asInteger asString.
	colorBox canvas
		color: aColor;
		signalUpdate
]
