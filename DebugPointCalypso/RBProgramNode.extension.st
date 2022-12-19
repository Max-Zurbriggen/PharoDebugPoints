Extension { #name : #RBProgramNode }

{ #category : #'*DebugPointCalypso' }
RBProgramNode >> hasDebugPointOfType: aDebugPointSubClass [
	
	^self links anySatisfy: [ :link | link metaObject isKindOf: aDebugPointSubClass ]
]
