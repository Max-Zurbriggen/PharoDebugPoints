Class {
	#name : #DebugPointInstaller,
	#superclass : #Object,
	#category : #DebugPointInstaller
}

{ #category : #'as yet unclassified' }
DebugPointInstaller class >> install: aDebugPointClass On: aNode [
	| dp ml |
	dp := aDebugPointClass new.

	"adding selected behaviors"	
	self requestBehaviors ifNil: [ dp remove. ^self ] ifNotNil: [ :bhs | bhs do: [ :bh | dp addBehavior: bh new ] ] .
	
	ml := dp metaLink.

	dp link: ml.
	aNode link: ml.
	dp openEditor.
]

{ #category : #'as yet unclassified' }
DebugPointInstaller class >> install: aDebugPointClass On: aNode withBehaviors: aListOfBehaviorClasses [
	| dp ml |
	dp := aDebugPointClass new.

	"adding behaviors"	
	aListOfBehaviorClasses do: [ :bhc | dp addBehavior: bhc new].
	
	ml := dp metaLink.

	dp link: ml.
	aNode link: ml.
	dp openEditor.
]

{ #category : #'as yet unclassified' }
DebugPointInstaller class >> requestBehaviors [
	^DebugPointBehaviorSelector new openModal.
]
