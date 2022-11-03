Class {
	#name : #ClyAddDebugPointEditorCommand,
	#superclass : #ClyDebuggingPointsCommand,
	#category : #DebugPointCalypso
}

{ #category : #testing }
ClyAddDebugPointEditorCommand class >> canBeExecutedInContext: aBrowserContext [

	^ (super canBeExecutedInContext: aBrowserContext) and: [ 
		  aBrowserContext isSelectedItemHasWatch not ]
]

{ #category : #activation }
ClyAddDebugPointEditorCommand class >> contextMenuOrder [
	^2
]

{ #category : #accessing }
ClyAddDebugPointEditorCommand >> defaultMenuIconName [
	^#smallDebug
]

{ #category : #accessing }
ClyAddDebugPointEditorCommand >> defaultMenuItemName [
	^' Add Debug Point to: ',  sourceNode displaySourceCode
]

{ #category : #execution }
ClyAddDebugPointEditorCommand >> execute [
	DebugPointInstaller installOn: sourceNode.
]
