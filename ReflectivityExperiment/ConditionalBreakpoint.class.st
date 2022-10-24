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
	<debuggerCompleteToSender>
	|a|
	
	a := self evaluate: self condition withContext: aContext.
	
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

{ #category : #accessing }
ConditionalBreakpoint >> newConditionPopup [

	| textInput |
	textInput := SpRequestTextDialog new
		label: 'Enter condition for this point (self and variables are supported):';
		text: '';
		title: 'Enter condition';
		openModal.
	textInput ifNil: [ ^condition ].
	textInput ifEmpty: [ ^false ].
	^textInput 
]
