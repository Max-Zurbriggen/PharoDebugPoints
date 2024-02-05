"
I am the once behavior which can be added to debug points. When I am executed I will disable the debug point to which I am attached.
"
Class {
	#name : 'OnceBehavior',
	#superclass : 'DebugPointBehavior',
	#category : 'DebugPointFramework-Behaviors',
	#package : 'DebugPointFramework',
	#tag : 'Behaviors'
}

{ #category : 'accessing' }
OnceBehavior class >> uiElement [

	^OnceUI
]

{ #category : 'execution' }
OnceBehavior >> execute [
	self debugPoint enabled: false.
	^true.
]
