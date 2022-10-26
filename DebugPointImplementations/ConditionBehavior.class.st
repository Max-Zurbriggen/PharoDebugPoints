Class {
	#name : #ConditionBehavior,
	#superclass : #DebugPointBehavior,
	#instVars : [
		'condition'
	],
	#category : #DebugPointImplementations
}

{ #category : #initialization }
ConditionBehavior >> condition [
	^condition
]

{ #category : #initialization }
ConditionBehavior >> condition: aCondition [
	condition := aCondition
]

{ #category : #initialization }
ConditionBehavior >> execute [
	| aContext |
	(self evaluate: self condition withContext: aContext) ifFalse: [ ^false ]
]

{ #category : #initialization }
ConditionBehavior >> initialize [ 
	"should be executed before once and count etc."
	self priority: 50
]
