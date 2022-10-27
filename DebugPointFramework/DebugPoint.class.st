Class {
	#name : #DebugPoint,
	#superclass : #Object,
	#instVars : [
		'enabled',
		'behaviors',
		'requiredArguments',
		'arguments'
	],
	#category : #DebugPointFramework
}

{ #category : #API }
DebugPoint >> addBehavior: aDebugPointBehavior [
	"adding a new behavior"
	self behaviors add: aDebugPointBehavior.
	"adding required arguments for this behavior"
	self requiredArguments add: aDebugPointBehavior requiredArguments.
	self requiredArguments: self requiredArguments flattened asSet.
	
	"alternative version for adding required arguments so we dont have to flatten manually:"
	"aDebugPointBehavior requiredArguments do: [ :arg | self requiredArguments add: arg ]."
]

{ #category : #accessing }
DebugPoint >> arguments [
	^arguments
]

{ #category : #accessing }
DebugPoint >> arguments: aDictionary [
	arguments := aDictionary
]

{ #category : #accessing }
DebugPoint >> behaviors [
	^behaviors
]

{ #category : #accessing }
DebugPoint >> behaviors: aSetOfBehaviors [
	behaviors := aSetOfBehaviors 
]

{ #category : #accessing }
DebugPoint >> enabled [
	^enabled
]

{ #category : #accessing }
DebugPoint >> enabled: aBoolean [
	enabled := aBoolean 
]

{ #category : #API }
DebugPoint >> getArgument: aSymbol [
	^self arguments at: aSymbol
]

{ #category : #'as yet unclassified' }
DebugPoint >> getBehavior: aBehaviorClass [
	^self behaviors detect: [ :bh | bh class = aBehaviorClass ]
]

{ #category : #API }
DebugPoint >> hit [
	self enabled ifFalse: [ ^self ].
	self behaviors do: [ :behavior | 
		"this might be bad style but makes for a more robust implementation of behaviors since execution only stops if it returns false and else continues"
		behavior execute = false ifTrue: [ ^self ]

		 ]
]

{ #category : #API }
DebugPoint >> hitWithArguments: aDictionary [
	self arguments: aDictionary.
	self hit.
]

{ #category : #initialization }
DebugPoint >> initialize [ 
	self enabled: true.
	self behaviors: (SortedCollection sortUsing: [ :elem1 :elem2 | elem1 priority >= elem2 priority]).
	self requiredArguments: Set new.
]

{ #category : #API }
DebugPoint >> installOn: aNode [

	"aDebugPoint installOn: smth. 
	since the smth is not in scope of my work this method will have to be implemented when it is defined. 
	This is what should happen on execution:
	smth gets a reference to the debugpoint: aDebugPoint
	smth gets the method to execute:
	smth gets set of arguments that need to be returned as dictionary: (e.g. #(context node) )"


	"method to be sent to execute on hit:"
	#hitWithArguments:.
	"the set of argument that is required to be sent as dictionary:"
	self requiredArguments
]

{ #category : #accessing }
DebugPoint >> requiredArguments [
	^requiredArguments
]

{ #category : #accessing }
DebugPoint >> requiredArguments: aList [
	requiredArguments := aList
]
