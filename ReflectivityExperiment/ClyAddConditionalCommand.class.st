Class {
	#name : #ClyAddConditionalCommand,
	#superclass : #ClyAdvancedDebuggingCommand,
	#category : #ReflectivityExperiment
}

{ #category : #testing }
ClyAddConditionalCommand class >> canBeExecutedInContext: aBrowserContext [

	^ (super canBeExecutedInContext: aBrowserContext) and: [ 
		  aBrowserContext isSelectedItemHasExecutionCounter not ]
]

{ #category : #activation }
ClyAddConditionalCommand class >> contextMenuOrder [
	^2
]

{ #category : #accessing }
ClyAddConditionalCommand >> defaultMenuIconName [
	^#smallDebug
]

{ #category : #accessing }
ClyAddConditionalCommand >> defaultMenuItemName [
	^' Add     Conditional    to  ', sourceNode displaySourceCode 
]

{ #category : #accessing }
ClyAddConditionalCommand >> description [
	^ self defaultMenuItemName, ' to  ',  sourceNode displaySourceCode
]

{ #category : #execution }
ClyAddConditionalCommand >> execute [
	
	| textInput |
	textInput := SpRequestTextDialog new
		label: 'Enter condition for this point (self and variables are supported):';
		text: '';
		title: 'Enter condition';
		openModal.
	textInput ifNil: [ ^self ].
	textInput ifEmpty: [ textInput := false ].
	(ConditionalBreakpoint installOn: sourceNode) condition: textInput

]

{ #category : #execution }
ClyAddConditionalCommand >> information [
	self defaultMenuItemName, ' to  ',  sourceNode displaySourceCode
]
