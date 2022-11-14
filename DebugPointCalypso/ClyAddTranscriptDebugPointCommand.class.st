Class {
	#name : #ClyAddTranscriptDebugPointCommand,
	#superclass : #ClyDebuggingPointsCommand,
	#category : #DebugPointCalypso
}

{ #category : #testing }
ClyAddTranscriptDebugPointCommand class >> canBeExecutedInContext: aBrowserContext [

	^ (super canBeExecutedInContext: aBrowserContext)
]

{ #category : #activation }
ClyAddTranscriptDebugPointCommand class >> contextMenuOrder [
	^4
]

{ #category : #accessing }
ClyAddTranscriptDebugPointCommand >> defaultMenuIconName [
	^#smallDebug
]

{ #category : #accessing }
ClyAddTranscriptDebugPointCommand >> defaultMenuItemName [
	^' Add Transcript to: ',  sourceNode displaySourceCode
]

{ #category : #execution }
ClyAddTranscriptDebugPointCommand >> execute [
	DebugPointInstaller install: TranscriptDebugPoint  On: sourceNode.
]
