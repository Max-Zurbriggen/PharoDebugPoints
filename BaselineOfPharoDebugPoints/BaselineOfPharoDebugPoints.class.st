Class {
	#name : 'BaselineOfPharoDebugPoints',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfPharoDebugPoints',
	#package : 'BaselineOfPharoDebugPoints'
}

{ #category : 'baselines' }
BaselineOfPharoDebugPoints >> baseline: spec [
	<baseline>

	spec for: #common do: [
		
		self seaside: spec.

		spec 
			package: 'DebugPointFramework';
			package: 'DebugPointUI' with: [ spec requires: #('DebugPointFramework') ];
			package: 'DebugPointCalypso' with: [ spec requires: #('DebugPointUI' 'DebugPointFramework') ];
			package: 'DebugPointFramework-Tests' with: [ spec requires: #('DebugPointFramework')];
			package: 'DebugPointSeaside' with: [ spec requires: #('DebugPointFramework' 'DebugPointUI') ].
		
		"Groups"
		spec
			group: 'Core' with: #('DebugPointFramework');
			group: 'Tests' with: #('Core' 'DebugPointFramework-Tests');
			group: 'UI' with: #('Core'  'DebugPointUI');
			group: 'Seaside' with: #('UI' 'DebugPointSeaside');
			group: 'BrowserIntegration' with: #('DebugPointCalypso');
			group: 'default' with: #('Tests' 'UI' 'BrowserIntegration')
	]
]

{ #category : 'baselines' }
BaselineOfPharoDebugPoints >> seaside: spec [

	spec
		baseline: 'Seaside3'
		with: [ spec repository: 'github://SeasideSt/Seaside:master/repository' ]
]
