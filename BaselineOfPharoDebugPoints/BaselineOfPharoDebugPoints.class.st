Class {
	#name : #BaselineOfPharoDebugPoints,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharoDebugPoints
}

{ #category : #baselines }
BaselineOfPharoDebugPoints >> baseline: spec [
	<baseline>

	spec for: #common do: [
		spec package: 'DebugPointCalypso'.
		spec package: 'DebugPointUI'.
		spec package: 'DebugPointFramework'.
		spec package: 'DebugPointFramework-Tests'.
	]
]
