Class {
	#name : 'SpAlphaSlider',
	#superclass : 'SpRoassalPresenter',
	#instVars : [
		'trans'
	],
	#category : 'ColorPicker',
	#package : 'ColorPicker'
}

{ #category : 'initialization' }
SpAlphaSlider >> chessPaintFor: aPoint [

	| canvas lines c h w |
	canvas := RSCanvas new extent: aPoint.
	lines := RSGroup new.
	h := aPoint y.
	w := aPoint x.
	1 to: h / 5 do: [ :i |
		| line |
		line := RSGroup new.
		1 to: w / 5 do: [ :j |
			line add: (RSBox new
					 extent: 5 asPoint;
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
SpAlphaSlider >> initializePresenters [

	| canvas chess |
	canvas := self canvas.
	canvas color: Color transparent.
	chess := RSBox new
		         extent: 240 @ 10;
		         cornerRadius: 5;
		         paint: (self chessPaintFor: 240 @ 10);
		         yourself.
	trans := RSBox new
		         extent: 240 @ 10;
		         border: (RSBorder new
				          width: 1;
				          color: Color gray;
				          yourself);
		         cornerRadius: 5;
		         paint: ((LinearGradientPaint fromArray: {
						           (0 -> Color transparent).
						           (1 -> Color red) })
				          start: -120 @ 0;
				          stop: 120 @ 0;
				          yourself);
		         yourself.
	canvas
		add: chess;
		add: trans
]

{ #category : 'initialization' }
SpAlphaSlider >> setColor: aColor [

	self updateTransPaintWith: aColor
]

{ #category : 'initialization' }
SpAlphaSlider >> updateTransPaintWith: aColor [

	trans paint: ((LinearGradientPaint fromArray: {
					  (0 -> Color transparent).
					  (1 -> aColor) })
			 start: -120 @ 0;
			 stop: 120 @ 0;
			 yourself).
	trans signalUpdate
]
