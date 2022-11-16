Class {
	#name : #ClyRemoveDebugPointCommand,
	#superclass : #ClyRemoveDebuggingCommand,
	#category : #DebugPointCalypso
}

{ #category : #testing }
ClyRemoveDebugPointCommand class >> canBeExecutedInContext: aBrowserContext [

	^aBrowserContext isSelectedItemHasWatch
]

{ #category : #activation }
ClyRemoveDebugPointCommand class >> contextMenuOrder [
	^3
]

{ #category : #activation }
ClyRemoveDebugPointCommand class >> methodContextMenuActivation [
	<classAnnotation>

	^ SycAdvancedDebuggingMenuActivation 
			byItemOf: ClyAdvancedDebuggingMenuGroup order: self contextMenuOrder for: ClyMethod asCalypsoItemContext
]

{ #category : #activation }
ClyRemoveDebugPointCommand class >> sourceCodeMenuActivation [
	<classAnnotation>
	
	^SycAdvancedDebuggingMenuActivation 
		byItemOf: ClyAdvancedDebuggingMenuGroup order: self contextMenuOrder for: ClyMethodSourceCodeContext
]

{ #category : #execution }
ClyRemoveDebugPointCommand >> debuggingToolClass [
	^BreakDebugPoint
]

{ #category : #'table decoration' }
ClyRemoveDebugPointCommand >> tableCellIcon [
	^Smalltalk ui iconNamed: #smallDebug
]
