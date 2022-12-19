Class {
	#name : #ClyDebuggingPointsCommand,
	#superclass : #ClyDebuggingCommand,
	#category : #DebugPointCalypso
}

{ #category : #activation }
ClyDebuggingPointsCommand class >> contextMenuOrder [
	<classAnnotationDependency>
	^ 1.8
]

{ #category : #testing }
ClyDebuggingPointsCommand class >> isAbstract [
	^self == ClyDebuggingPointsCommand 
]

{ #category : #activation }
ClyDebuggingPointsCommand class >> methodContextMenuActivation [

	<classAnnotation>
	^ SycDebuggingPointsMenuActivation
		  byItemOf: ClyDebuggingPointsMenuGroup
		  order: self contextMenuOrder
		  for: ClyMethod asCalypsoItemContext
]

{ #category : #activation }
ClyDebuggingPointsCommand class >> methodEditorLeftBarMenuActivation [

	<classAnnotation>
	^ CmdTextLeftBarMenuActivation
		  byItemOf: ClyDebuggingPointsMenuGroup
		  order: self contextMenuOrder
		  for: ClyMethodSourceCodeContext
]

{ #category : #activation }
ClyDebuggingPointsCommand class >> sourceCodeMenuActivation [

	<classAnnotation>
	^ SycDebuggingPointsMenuActivation 
		  byItemOf: ClyDebuggingPointsMenuGroup
		  order: self contextMenuOrder
		  for: ClyMethodSourceCodeContext
]

{ #category : #execution }
ClyDebuggingPointsCommand >> putIconInProperties: dp [
	dp properties at: #Icon put: self defaultMenuIconName.
	DebugPointManager notifyDebugPointChanged: dp.
]
