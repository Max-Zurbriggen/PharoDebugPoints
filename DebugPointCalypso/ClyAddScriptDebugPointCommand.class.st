Class {
	#name : #ClyAddScriptDebugPointCommand,
	#superclass : #ClyDebuggingPointsCommand,
	#category : #DebugPointCalypso
}

{ #category : #testing }
ClyAddScriptDebugPointCommand class >> canBeExecutedInContext: aBrowserContext [

	^ (super canBeExecutedInContext: aBrowserContext)
]

{ #category : #activation }
ClyAddScriptDebugPointCommand class >> contextMenuOrder [
	^4
]

{ #category : #accessing }
ClyAddScriptDebugPointCommand >> defaultMenuIconName [
	^#smallDebug
]

{ #category : #accessing }
ClyAddScriptDebugPointCommand >> defaultMenuItemName [
	^' Add Script to: ',  sourceNode displaySourceCode
]

{ #category : #execution }
ClyAddScriptDebugPointCommand >> execute [
	| dp |
	dp := DebugPointManager installNew: ScriptDebugPoint  On: sourceNode.
	
	dp script: self popUp
]

{ #category : #execution }
ClyAddScriptDebugPointCommand >> popUp [
	|textInput|
	textInput := SpRequestDialog new
		label: 'Enter script:';
		text: '';
		title: 'Script';
		openModal.
	textInput ifNil: [ ^'' ].
	^textInput 
]
