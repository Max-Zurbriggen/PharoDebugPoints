Class {
	#name : #StInspectorSetScopeCommand,
	#superclass : #StInspectorCommand,
	#category : #DebugPointCalypso
}

{ #category : #execution }
StInspectorSetScopeCommand >> execute [ 
	| debugPoint |
	debugPoint := DebugPointSelectDialog new items: DebugPoint all;
		label: 'The scope of the selected debug point will be set to the inspected object';
		title: 'Select Debug Point';
		openModal.
		
	debugPoint ifNotNil: [ :dp | dp setObjectScope: self interestingObject ]
]
