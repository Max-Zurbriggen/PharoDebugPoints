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
		  options: #(+ optionCompileOnLinkInstallation)).
		
	"add executed method and arguments to metalink"
	dp requiredArguments 
		ifEmpty: [ 
			ml selector: #hit ] 
		ifNotEmpty: [  
		ml selector: #hitWithArguments:;
		"metalinks might not support arguments that are delivered by DebugPointImplementations"
			arguments: dp requiredArguments asArray].
	
	dp link: ml.
	aNode link: ml 
]

{ #category : #'as yet unclassified' }
DebugPointInstaller class >> requestBehaviors [
	^DebugPointBehaviorSelector new openModal.
]
