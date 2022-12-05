Class {
	#name : #ClyAddChainDebugPointCommand,
	#superclass : #ClyDebuggingPointsCommand,
	#category : #DebugPointCalypso
}

{ #category : #testing }
ClyAddChainDebugPointCommand class >> canBeExecutedInContext: aBrowserContext [

	^ (super canBeExecutedInContext: aBrowserContext)
]

{ #category : #activation }
ClyAddChainDebugPointCommand class >> contextMenuOrder [
	^4
]

{ #category : #accessing }
ClyAddChainDebugPointCommand >> defaultMenuIconName [
	^#smallDebug
]

{ #category : #accessing }
ClyAddChainDebugPointCommand >> defaultMenuItemName [
	^' Add Chain Link to: ',  sourceNode displaySourceCode
]

{ #category : #execution }
ClyAddChainDebugPointCommand >> execute [
	(DebugPointManager installNew: DebugPoint  On: sourceNode withBehaviors: {ChainBehavior}) name: #ChainLink
]
