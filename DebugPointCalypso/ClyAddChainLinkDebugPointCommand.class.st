Class {
	#name : #ClyAddChainLinkDebugPointCommand,
	#superclass : #ClyDebuggingPointsCommand,
	#category : #DebugPointCalypso
}

{ #category : #testing }
ClyAddChainLinkDebugPointCommand class >> canBeExecutedInContext: aBrowserContext [

	^ (super canBeExecutedInContext: aBrowserContext)
]

{ #category : #activation }
ClyAddChainLinkDebugPointCommand class >> contextMenuOrder [
	^4
]

{ #category : #accessing }
ClyAddChainLinkDebugPointCommand >> defaultMenuIconName [
	^#smallDebug
]

{ #category : #accessing }
ClyAddChainLinkDebugPointCommand >> defaultMenuItemName [
	^' Add Chain Link to: ',  sourceNode displaySourceCode
]

{ #category : #execution }
ClyAddChainLinkDebugPointCommand >> execute [
	DebugPointManager installNew: ChainLinkDebugPoint  On: sourceNode.
]
