Class {
	#name : #StInspectorSetScopeSelectedCommand,
	#superclass : #StInspectorCommand,
	#category : #ReflectivityExperiment
}

{ #category : #default }
StInspectorSetScopeSelectedCommand class >> defaultDescription [

	^ 'Change the scope of a breakpoint to this object'
]

{ #category : #initialization }
StInspectorSetScopeSelectedCommand class >> defaultIconName [

	^ #smallDebug
]

{ #category : #default }
StInspectorSetScopeSelectedCommand class >> defaultName [
	<toolbarInspectCommand: 1>

	^ 'Set This Scope'
]

{ #category : #documentation }
StInspectorSetScopeSelectedCommand class >> documentContextRequiredSelectors [

	^ super documentContextRequiredSelectors, #(selectedObject)
]

{ #category : #execution }
StInspectorSetScopeSelectedCommand >> execute [ 
	| debugPoint |
	debugPoint := DebugPointSelectDialog new items: DebugPoint allDebugPoints; 
		label: 'The scope of the selected debug point will be set to the inspected object';
		title: 'Select debug point';
	openModal. 
	
	debugPoint ifNotNil: [:o | o setObjectScope: self interestingObject]
	
]
