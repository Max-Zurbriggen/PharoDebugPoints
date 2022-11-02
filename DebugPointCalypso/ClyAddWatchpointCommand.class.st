Class {
	#name : #ClyAddWatchpointCommand,
	#superclass : #ClyDebuggingPointsCommand,
	#category : #DebugPointCalypso
}

{ #category : #testing }
ClyAddWatchpointCommand class >> canBeExecutedInContext: aBrowserContext [

	^ (super canBeExecutedInContext: aBrowserContext) and: [ 
		  aBrowserContext isSelectedItemHasWatch not ]
]

{ #category : #activation }
ClyAddWatchpointCommand class >> contextMenuOrder [
	^2
]

{ #category : #accessing }
ClyAddWatchpointCommand >> defaultMenuIconName [
	^#smallDebug
]

{ #category : #accessing }
ClyAddWatchpointCommand >> defaultMenuItemName [
	^' Add Watchpoint to: ',  sourceNode displaySourceCode
]

{ #category : #execution }
ClyAddWatchpointCommand >> execute [
	
	Watch in: sourceNode
]
