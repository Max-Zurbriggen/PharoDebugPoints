Class {
	#name : #ConditionalBreakpoint,
	#superclass : #DebugPoint,
	#instVars : [
		'condition'
	],
	#category : #ReflectivityExperiment
}

{ #category : #accessing }
ConditionalBreakpoint >> breakWithContext: aContext [
	"<debuggerCompleteToSender>"
	"not yet working"
	|a|
	
	a := self evaluate: self condition withContext: aContext.
	self halt.
	
	a ifFalse: [ ^self ].
	Break break.
]

{ #category : #accessing }
ConditionalBreakpoint >> condition [
	^condition
]

{ #category : #accessing }
ConditionalBreakpoint >> condition: aString [
	condition := aString
]

{ #category : #accessing }
ConditionalBreakpoint >> createLink [

	^MetaLink new 
				metaObject: self;
				selector: #breakWithContext:;
				arguments: #(#context);
				options: #(+ optionAnnounce).
				 
]

{ #category : #accessing }
ConditionalBreakpoint >> evaluate: expression withContext: aContext [
	^ Smalltalk compiler
		source: expression;
		context: aContext;
		receiver: aContext receiver;
		evaluate
]
