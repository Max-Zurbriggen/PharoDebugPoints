Class {
	#name : #DebugPointInstaller,
	#superclass : #Object,
	#category : #DebugPointInstaller
}

{ #category : #'as yet unclassified' }
DebugPointInstaller class >> installOn: aNode [
	| dp ml |
	dp := DebugPoint new.

	"adding selected behaviors"	
	self requestBehaviors ifNil: [ dp remove. ^self ] ifNotNil: [ :bhs | bhs do: [ :bh | dp addBehavior: bh new ] ] .
	
	
	ml := (MetaLink new
		metaObject: dp;
		options: #(+ optionCompileOnLinkInstallation);
		selector: #hitWithContext:node:;
		arguments: #(context node)).

	
	dp link: ml.
	aNode link: ml.
	dp openEditor.
]

{ #category : #'as yet unclassified' }
DebugPointInstaller class >> requestBehaviors [
	^DebugPointBehaviorSelector new openModal.
]
