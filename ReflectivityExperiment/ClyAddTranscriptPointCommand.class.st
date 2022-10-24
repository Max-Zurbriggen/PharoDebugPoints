Class {
	#name : #ClyAddTranscriptPointCommand,
	#superclass : #ClyAdvancedDebuggingCommand,
	#category : #ReflectivityExperiment
}

{ #category : #testing }
ClyAddTranscriptPointCommand class >> canBeExecutedInContext: aBrowserContext [

	^ (super canBeExecutedInContext: aBrowserContext) and: [ 
		  aBrowserContext isSelectedItemHasExecutionCounter not ]
]

{ #category : #activation }
ClyAddTranscriptPointCommand class >> contextMenuOrder [
	^2
]

{ #category : #accessing }
ClyAddTranscriptPointCommand >> defaultMenuIconName [
	^#smallDebug
]

{ #category : #accessing }
ClyAddTranscriptPointCommand >> defaultMenuItemName [
	^' Add     TranscriptPoint    to  ', sourceNode displaySourceCode 
]

{ #category : #accessing }
ClyAddTranscriptPointCommand >> description [
	^ self defaultMenuItemName, ' to  ',  sourceNode displaySourceCode
]

{ #category : #execution }
ClyAddTranscriptPointCommand >> execute [
	| textInput |
	textInput := SpRequestTextDialog new
		label: 'Enter text to print to transcript:';
		text: '';
		title: 'Enter text';
		openModal.
	textInput ifNil: [ ^'' ].
	(TranscriptPoint installOn: sourceNode) text: textInput.

]

{ #category : #execution }
ClyAddTranscriptPointCommand >> information [
	self defaultMenuItemName, ' to  ',  sourceNode displaySourceCode
]
