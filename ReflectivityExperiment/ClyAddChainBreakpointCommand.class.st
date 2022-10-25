Class {
	#name : #ClyAddChainBreakpointCommand,
	#superclass : #ClyAdvancedDebuggingCommand,
	#category : #ReflectivityExperiment
}

{ #category : #testing }
ClyAddChainBreakpointCommand class >> canBeExecutedInContext: aBrowserContext [

	^ (super canBeExecutedInContext: aBrowserContext) and: [ 
		  aBrowserContext isSelectedItemHasExecutionCounter not ]
]

{ #category : #activation }
ClyAddChainBreakpointCommand class >> contextMenuOrder [
	^2
]

{ #category : #accessing }
ClyAddChainBreakpointCommand >> defaultMenuIconName [
	^#smallDebug
]

{ #category : #accessing }
ClyAddChainBreakpointCommand >> defaultMenuItemName [
	^' Add     ChainBreakpoint    to  ', sourceNode displaySourceCode 
]

{ #category : #accessing }
ClyAddChainBreakpointCommand >> description [
	^ self defaultMenuItemName, ' to  ',  sourceNode displaySourceCode
]

{ #category : #execution }
ClyAddChainBreakpointCommand >> execute [
	

	ChainBreakpoint installOn: sourceNode

]

{ #category : #execution }
ClyAddChainBreakpointCommand >> information [
	self defaultMenuItemName, ' to  ',  sourceNode displaySourceCode
]
