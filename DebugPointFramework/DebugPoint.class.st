Class {
	#name : #DebugPoint,
	#superclass : #Object,
	#instVars : [
		'enabled',
		'behaviors'
	],
	#category : #DebugPointFramework
}

{ #category : #'as yet unclassified' }
DebugPoint >> addBehavior: aDebugPointBehavior [
	self behaviors add: aDebugPointBehavior.
	"self sortBehaviors."
]

{ #category : #'as yet unclassified' }
DebugPoint >> behaviors [
	^behaviors
]

{ #category : #'as yet unclassified' }
DebugPoint >> behaviors: aSetOfBehaviors [
	behaviors := aSetOfBehaviors 
]

{ #category : #'as yet unclassified' }
DebugPoint >> enabled [
	^enabled
]

{ #category : #'as yet unclassified' }
DebugPoint >> enabled: aBoolean [
	enabled := aBoolean 
]

{ #category : #'as yet unclassified' }
DebugPoint >> getBehavior: aBehaviorClass [
	^self behaviors detect: [ :bh | bh class = aBehaviorClass ]
]

{ #category : #'as yet unclassified' }
DebugPoint >> hit [
	self enabled ifFalse: [ ^self ].
	self behaviors do: [ :behavior | 
		"this might be bad style but makes for a more robust implementation of behaviors since execution only stops if it returns false and else continues"
		behavior execute = false ifTrue: [ ^self ]

		 ]
]

{ #category : #'as yet unclassified' }
DebugPoint >> initialize [ 
	self enabled: true.
	self behaviors: (SortedCollection sortUsing: [ :elem1 :elem2 | elem1 priority >= elem2 priority]).
]

{ #category : #'as yet unclassified' }
DebugPoint >> sortBehaviors [
	self behaviors: (self behaviors sorted: [ :a :b | a priority >= b priority ]) asSet.
]
