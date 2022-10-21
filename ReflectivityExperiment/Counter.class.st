Class {
	#name : #Counter,
	#superclass : #DebugPoint,
	#instVars : [
		'count'
	],
	#classVars : [
		'AllScriptExecutors'
	],
	#category : #ReflectivityExperiment
}

{ #category : #accessing }
Counter >> count [
	^count
]

{ #category : #accessing }
Counter >> hit [ 
	self increaseCount
]

{ #category : #accessing }
Counter >> increaseCount [ 
	count := count + 1
]

{ #category : #accessing }
Counter >> initialize [ 
	super initialize .
	count := 0
]

{ #category : #accessing }
Counter >> resetCount [
	count := 0
]
