Class {
	#name : #SycOpenDebuggingPointsMenuCommand,
	#superclass : #SycOpenContextMenuCommand,
	#category : #DebugPointCalypso
}

{ #category : #activation }
SycOpenDebuggingPointsMenuCommand class >> sourceCodeMenuActivation [
	<classAnnotation>
	
	^CmdContextMenuActivation byRootGroupItemOrder: 0.2 for: ClySourceCodeContext
]

{ #category : #execution }
SycOpenDebuggingPointsMenuCommand >> activationStrategy [
	^SycDebuggingPointsMenuActivation
]

{ #category : #'context menu' }
SycOpenDebuggingPointsMenuCommand >> cmCommandClass [

	^ SycSourceCodeCmCommand
]

{ #category : #accessing }
SycOpenDebuggingPointsMenuCommand >> defaultMenuIconName [
	^ #smallDebug
]

{ #category : #accessing }
SycOpenDebuggingPointsMenuCommand >> defaultMenuItemName [

	^ 'Debug Points'
]
