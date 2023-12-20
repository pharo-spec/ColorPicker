Class {
	#name : 'SpColorPickerTest',
	#superclass : 'TestCase',
	#instVars : [
		'colorPickerPresenter'
	],
	#category : 'ColorPicker-Tests',
	#package : 'ColorPicker-Tests'
}

{ #category : 'running' }
SpColorPickerTest >> setUp [

	super setUp.
	colorPickerPresenter := SpColorPicker new.
]

{ #category : 'tests' }
SpColorPickerTest >> testChangeSelectedColor [

	| selectedColor |
	
	colorPickerPresenter 
		color: Color red;
		whenColorChangedDo: [ : newColor | selectedColor := newColor ].
	self 
		assert: selectedColor isNil
		description: 'Color changed is announced using #setColor: instead of #color:'.
	colorPickerPresenter 
		setColor: Color white.
	self 
		assert: selectedColor 
		equals: Color white

]

{ #category : 'tests' }
SpColorPickerTest >> testOpenColorPicker [

	colorPickerPresenter open.
	self assert: colorPickerPresenter window isOpen.
	colorPickerPresenter delete.
	self assert: colorPickerPresenter window isClosed.	
]
