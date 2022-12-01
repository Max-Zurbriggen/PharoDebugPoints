"
Adds an icon in the inspector where you can set the scope of a debug point to the inspected object.
"
Class {
	#name : #StInspectorSetScopeCommand,
	#superclass : #StInspectorCommand,
	#category : #DebugPointCalypso
}

{ #category : #'accessing - defaults' }
StInspectorSetScopeCommand class >> defaultDescription [ 
	^'Change the scope of a debug point to this object'
]

{ #category : #'accessing - defaults' }
StInspectorSetScopeCommand class >> defaultIconName [ 
	^#smallDebug
]

{ #category : #'accessing - defaults' }
StInspectorSetScopeCommand class >> defaultName [
	<toolbarInspectCommand: 1>
	
	^'Set Scope'
]

{ #category : #'accessing - defaults' }
StInspectorSetScopeCommand class >> documentContextRequiredSelectors [ 
	^super documentContextRequiredSelectors, #(selectedObject)
]

{ #category : #execution }
StInspectorSetScopeCommand >> execute [ 
	| debugPoint |
	debugPoint := DebugPointSelectDialog new scope: self interestingObject; items: DebugPoint all asOrderedCollection ;
		label: 'The scope of the selected debug point will be set to the inspected object';
		title: 'Select Debug Point';
		openModal.
		
	debugPoint ifNotNil: [ :dp | dp setObjectScope: self interestingObject ]
]
