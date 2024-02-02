"
Present color palettes of Roassal, see Roassal color palettes for more information.
This presenter let user navigate color palettes and choose specific colors.
"
Class {
	#name : 'SpSmallColorPalette',
	#superclass : 'SpPresenter',
	#instVars : [
		'paletteDropList',
		'currentPalette',
		'hueSetDropList',
		'colorsGrid'
	],
	#category : 'ColorPicker',
	#package : 'ColorPicker'
}

{ #category : 'utilities' }
SpSmallColorPalette class >> allColorPalettes [
	^RSColorPalette allSubclasses
		sort: [ :a :b | a name < b name ]
]

{ #category : 'initialization' }
SpSmallColorPalette >> boxFromColor: aColor [

	^ RSBox new
		  extent: 20 @ 20;
		  color: aColor;
		  cornerRadius: 3;
		  border: (RSBorder new
				   width: 1;
				   capSquare;
				   joinMiter;
				   color: (Smalltalk ui theme textColor alpha: 0.3);
				   yourself);
		  when: RSMouseClick
		  do: [ :evt | self owner setColor: aColor ]
		  for: self;
		  when: RSMouseEnter do: [ :evt |
			  evt shape extent: 30 @ 30.
			  evt signalUpdate ]
		  for: self;
		  when: RSMouseLeave do: [ :evt |
			  evt shape extent: 20 @ 20.
			  evt signalUpdate ]
		  for: self;
		  yourself
]

{ #category : 'initialization' }
SpSmallColorPalette >> boxesFromColorArray: array [

	^ array collect: [ :color | self boxFromColor: color ] as: RSGroup
]

{ #category : 'initialization' }
SpSmallColorPalette >> initializeLayout [

	self layout: (SpBoxLayout newTopToBottom
			 spacing: 2;
			 add: (SpBoxLayout newLeftToRight
					  spacing: 3;
					  add: 'Color palettes' asPresenter;
					  add: 'Hue sets' asPresenter;
					  yourself)
			 expand: false;
			 add: (SpBoxLayout newLeftToRight
					  spacing: 3;
					  add: paletteDropList;
					  add: hueSetDropList;
					  yourself)
			 expand: false;
			 add: colorsGrid expand: true;
			 yourself)
]

{ #category : 'initialization' }
SpSmallColorPalette >> initializePresenters [

	colorsGrid := self instantiate: SpRoassalPresenter.
	colorsGrid canvas color: Color transparent.
	hueSetDropList := self newDropList
		                  display: [ :method | method selector ];
		                  whenSelectedItemChangedDo: [ :method | 
			                  self setColorsGrid: method ];
		                  yourself.
	paletteDropList := self newDropList
		                   help: 'Select a palette';
		                   items: self class allColorPalettes;
		                   display: [ :paletteClass | 
			                   paletteClass paletteName ];
		                   whenSelectedItemChangedDo: [ :palette | 
			                   self setPalette: palette ];
		                   selectIndex: 2;
		                   yourself.

	self initializeLayout
]

{ #category : 'initialization' }
SpSmallColorPalette >> setColorsGrid: method [

	| scale colorBoxes shapes can |
	method ifNil: [ ^ self ].
	can := colorsGrid canvas.
	scale := currentPalette new perform: method selector asSymbol.
	shapes := self boxesFromColorArray: scale range.
	RSGridLayout new
		gapSize: 10;
		lineItemsCount: 8;
		on: shapes.
	colorBoxes := RSComposite new shapes: shapes.
	colorBoxes padding: 10.
	can shapes ifNotEmpty: [ can removeShape: can shapes first ].
	colorBoxes translateTo: 0 @ 0.
	can
		add: colorBoxes;
		signalUpdate
]

{ #category : 'initialization' }
SpSmallColorPalette >> setPalette: selectedItem [

	currentPalette := selectedItem.
	hueSetDropList
		items: (currentPalette methods sort: [ :a :b | a name < b name ]);
		selectIndex: (currentPalette = RSQualitativeColorPalette
				 ifTrue: [ 21 ]
				 ifFalse: [ 1 ])
]
