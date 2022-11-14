Class {
	#name : #ClyAddConditionBreakCommand,
	#superclass : #ClyDebuggingPointsCommand,
	#category : #DebugPointCalypso
}

{ #category : #testing }
ClyAddConditionBreakCommand class >> canBeExecutedInContext: aBrowserContext [

	^ (super canBeExecutedInContext: aBrowserContext)
]

{ #category : #activation }
ClyAddConditionBreakCommand class >> contextMenuOrder [
	^3
]

{ #category : #accessing }
ClyAddConditionBreakCommand >> defaultMenuIconName [
	^#smallError
]

{ #category : #accessing }
ClyAddConditionBreakCommand >> defaultMenuItemName [
	^' Add Condition Breakpoint to: ',  sourceNode displaySourceCode
]

{ #category : #execution }
ClyAddConditionBreakCommand >> execute [
	DebugPointInstaller install: BreakDebugPoint On: sourceNode withBehaviors: {ConditionBehavior }
]
