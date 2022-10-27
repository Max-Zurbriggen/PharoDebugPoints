Class {
	#name : #TestRequiredArgumentsBehavior,
	#superclass : #DebugPointBehavior,
	#category : #DebugPointTestingEnvironment
}

{ #category : #execution }
TestRequiredArgumentsBehavior >> execute [
	^self
]

{ #category : #execution }
TestRequiredArgumentsBehavior >> requiredArguments [ 
	^#(context node smth)
]
