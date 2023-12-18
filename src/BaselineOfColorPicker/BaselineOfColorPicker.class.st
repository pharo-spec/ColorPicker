Class {
	#name : 'BaselineOfColorPicker',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfColorPicker',
	#package : 'BaselineOfColorPicker'
}

{ #category : 'baselines' }
BaselineOfColorPicker >> baseline: spec [
  <baseline>
	spec
		for: #(common)
		do: [ 
			self roassal: spec.
	
			spec 
				package: 'ColorPicker'         with: [ spec requires: #(Roassal) ];
				package: 'ColorPicker-Tests'	with: [ spec requires: #(ColorPicker) ].
			spec 
				group: 'Core' 						with: #('ColorPicker');
				group: 'Tests' 						with: #('ColorPicker' 'ColorPicker-Tests');
				group: 'default' 					with: #('Core' 'Tests') ]
]

{ #category : 'baselines' }
BaselineOfColorPicker >> roassal: spec [

	spec 
		baseline: 'Roassal' 
 		with: [ 
			spec 
				repository: (self class environment at: #BaselineOfPharo) roassalRepository;
    			loads: #( 'Core' 'Tests') ]
]
