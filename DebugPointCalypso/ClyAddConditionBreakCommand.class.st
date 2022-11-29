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
	|dp |
	dp := DebugPointManager installNew: BreakDebugPoint On: sourceNode withBehaviors: {ConditionBehavior }.
	
	(dp getBehavior: ConditionBehavior) condition: self popUp
]

{ #category : #execution }
ClyAddConditionBreakCommand >> popUp [
	|textInput|
	textInput := SpRequestDialog new
		label: 'Enter condition:';
		text: '';
		title: 'Condition';
		openModal.
	textInput ifNil: [ ^'' ].
	^textInput 
]
