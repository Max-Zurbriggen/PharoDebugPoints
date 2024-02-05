"
I am a count behavior that can be added to DebugPoints. I count how often the debug point has been reached. I only increase the count if conditions are evaluated to true (all previous behaviors have to return ""true"" when their execution methods are called.
"
Class {
	#name : 'CountBehavior',
	#superclass : 'DebugPointBehavior',
	#instVars : [
		'count'
	],
	#category : 'DebugPointFramework-Behaviors',
	#package : 'DebugPointFramework',
	#tag : 'Behaviors'
}

{ #category : 'ui building' }
CountBehavior class >> uiElement [

	^ CountUI 
]

{ #category : 'accessing' }
CountBehavior >> count [
	^count ifNil: [ count := 0 ].
]

{ #category : 'accessing' }
CountBehavior >> count: anInteger [
	count:= anInteger 
]

{ #category : 'execution' }
CountBehavior >> execute [
	self increaseCount.
	DebugPointManager notifyDebugPointChanged: self debugPoint.
	^true
	

	
	
]

{ #category : 'private' }
CountBehavior >> increaseCount [
	self count: self count + 1.
	
]
