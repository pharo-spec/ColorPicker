"
Provides a color picker with a toolbar to confirm or cancel the selected color.

"
Class {
	#name : 'SpColorPickerWindowPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'colorPickerPresenter',
		'toolbar'
	],
	#category : 'ColorPicker',
	#package : 'ColorPicker'
}

{ #category : 'instance creation' }
SpColorPickerWindowPresenter class >> defaultPreferredExtent [ 

	^ (350 @ 550)
]

{ #category : 'instance creation' }
SpColorPickerWindowPresenter class >> open [
	<script>

	^ self new open
]

{ #category : 'layout' }
SpColorPickerWindowPresenter >> defaultLayout [ 

	^ SpBoxLayout newTopToBottom 
		add: colorPickerPresenter;
		add: toolbar expand: false;
		yourself
]

{ #category : 'initialization' }
SpColorPickerWindowPresenter >> initializePresenters [

	colorPickerPresenter := self newColorPicker.
	toolbar := self newToolbar.
	self toolbarButtons do: [ :button | toolbar addItem: button ]
]

{ #category : 'initialization' }
SpColorPickerWindowPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter 
		whenClosedDo: [ self owner color: colorPickerPresenter color ]
]

{ #category : 'initialization' }
SpColorPickerWindowPresenter >> title [

	^ 'Color Picker'
]

{ #category : 'initialization' }
SpColorPickerWindowPresenter >> toolbarButtons [
	| buttons |

	buttons := OrderedCollection new.
	buttons 
			add: (self newToolbarButton
					 label: 'Cancel';
					 icon: (self iconNamed: #smallCancel);
					 help: 'Cancel the color selection';
					 action: [ self delete ];
					 yourself);
			add: (self newToolbarButton
			 label: 'Select';
			 icon: (self iconNamed: #smallOk);
			 help: 'Select and close';
			 action: [ self delete ];
			 yourself).

	^ buttons
]

{ #category : 'initialization' }
SpColorPickerWindowPresenter >> windowIcon [

	^ self iconNamed: #smallPaint
]
