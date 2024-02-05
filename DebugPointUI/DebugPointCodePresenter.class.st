"
I am a code presenter that highlights the code of an AST node to which a DebugPoint is attached.
"
Class {
	#name : 'DebugPointCodePresenter',
	#superclass : 'SpCodePresenter',
	#category : 'DebugPointUI',
	#package : 'DebugPointUI'
}

{ #category : 'update' }
DebugPointCodePresenter >> updateCode: aDebugPoint [ 
	"updates the code window with the code of the selected debug point"
	aDebugPoint ifNil:[self text: ''.^self].
	self text: aDebugPoint node methodNode sourceCode;
		beForMethod: aDebugPoint node methodNode compiledMethod;
		addTextSegmentDecoration: 
			(SpTextPresenterDecorator forHighlight
         		interval: (aDebugPoint node start to: ((aDebugPoint node stop) +1));
            yourself) .
]
