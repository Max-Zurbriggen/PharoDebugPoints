Class {
	#name : #ClyAddCountDebugPointCommand,
	#superclass : #ClyDebuggingPointsCommand,
	#category : #DebugPointCalypso
}

{ #category : #testing }
ClyAddCountDebugPointCommand class >> canBeExecutedInContext: aBrowserContext [

	^ (super canBeExecutedInContext: aBrowserContext)
]

{ #category : #activation }
ClyAddCountDebugPointCommand class >> contextMenuOrder [
	^4
]

{ #category : #accessing }
ClyAddCountDebugPointCommand >> defaultMenuIconName [
	^#smallDebug
]

{ #category : #accessing }
ClyAddCountDebugPointCommand >> defaultMenuItemName [
	^' Add Count to: ',  sourceNode displaySourceCode
]

{ #category : #execution }
ClyAddCountDebugPointCommand >> execute [
	DebugPointManager installNew: CountDebugPoint  On: sourceNode.
]
