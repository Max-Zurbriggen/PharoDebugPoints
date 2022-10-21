Extension { #name : #RBProgramNode }

{ #category : #'*ReflectivityExperiment' }
RBProgramNode >> hasDebugPointOfClass: aClass [
	
	self hasMetalink ifFalse: [ ^false ].
	^self links anySatisfy: [ :link | link metaObject class = aClass ]
]
