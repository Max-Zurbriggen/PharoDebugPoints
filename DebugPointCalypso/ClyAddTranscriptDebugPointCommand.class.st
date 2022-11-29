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
	| dp |
	dp := DebugPointManager installNew: TranscriptDebugPoint  On: sourceNode.
	
	dp text: self popUp
]

{ #category : #execution }
ClyAddTranscriptDebugPointCommand >> popUp [
	|textInput|
	textInput := SpRequestDialog new
		label: 'Enter string:';
		text: '';
		title: 'Transcript String';
		openModal.
	textInput ifNil: [ ^'' ].
	^textInput 
]
