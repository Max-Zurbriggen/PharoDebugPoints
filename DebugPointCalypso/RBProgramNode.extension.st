Extension { #name : #RBProgramNode }

{ #category : #'*DebugPointCalypso' }
RBProgramNode >> hasDebugPointOfType: aDebugPointSubClass [
	
	"self hasMetalinkAfter ifFalse: [ ^false ]."
	^self links anySatisfy: [ :link | link metaObject class == aDebugPointSubClass ]
]
