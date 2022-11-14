Class {
	#name : #ClyAddOnceBreakPointCommand,
	#superclass : #ClyDebuggingPointsCommand,
	#category : #DebugPointCalypso
}

{ #category : #testing }
ClyAddOnceBreakPointCommand class >> canBeExecutedInContext: aBrowserContext [

	^ (super canBeExecutedInContext: aBrowserContext)
]

{ #category : #activation }
ClyAddOnceBreakPointCommand class >> contextMenuOrder [
	^2
]

{ #category : #accessing }
ClyAddOnceBreakPointCommand >> defaultMenuIconName [
	^#smallError
]

{ #category : #accessing }
ClyAddOnceBreakPointCommand >> defaultMenuItemName [
	^' Add Once Breakpoint to: ',  sourceNode displaySourceCode
]

{ #category : #execution }
ClyAddOnceBreakPointCommand >> execute [
	DebugPointInstaller install: BreakDebugPoint On: sourceNode withBehaviors: {OnceBehavior}
]
