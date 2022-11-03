Class {
	#name : #DebugPointInstaller,
	#superclass : #Object,
	#category : #DebugPointInstaller
}

{ #category : #'as yet unclassified' }
DebugPointInstaller class >> installOn: aNode [
	| dp ml |
	dp := DebugPoint new.
	"dp addBehavior: ."


	ml := (MetaLink new
		  metaObject: dp;
		  options: #(+ optionCompileOnLinkInstallation)).
		
	"metalinks might not support arguments that are delivered by DebugPointImplementations"
	dp requiredArguments 
		ifEmpty: [ 
			ml selector: #hit ] 
		ifNotEmpty: [  
		ml selector: #hitWithArguments:;
			arguments: dp requiredArguments asArray].
	
	aNode link: ml 
]

{ #category : #'as yet unclassified' }
DebugPointInstaller class >> installOn: aNode method: aMethod arguments: aDictionary [
	
	MetaLink new
		  metaObject: DebugPoint new;
		  selector: #hitWithArguments:;
		  options: #(+ optionCompileOnLinkInstallation);
		  arguments: #(#context #node)
]
