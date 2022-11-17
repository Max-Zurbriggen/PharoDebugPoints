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
	DebugPointManager installNew: ScriptDebugPoint  On: sourceNode.
]
