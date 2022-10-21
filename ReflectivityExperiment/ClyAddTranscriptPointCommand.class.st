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
	^#class
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
	
	TranscriptPoint installOn: sourceNode
	"Counter installOn: sourceNode"
	"ScriptExecutor installOn: sourceNode"
	"ConditionalBreakpoint installOn: sourceNode"
	"OnceBreakpoint installOn: sourceNode"
]

{ #category : #execution }
ClyAddTranscriptPointCommand >> information [
	self defaultMenuItemName, ' to  ',  sourceNode displaySourceCode
]
