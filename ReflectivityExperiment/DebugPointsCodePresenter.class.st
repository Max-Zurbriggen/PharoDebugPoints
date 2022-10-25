Class {
	#name : #DebugPointsCodePresenter,
	#superclass : #SpCodePresenter,
	#category : #ReflectivityExperiment
}

{ #category : #initialization }
DebugPointsCodePresenter >> updateCode: aDebugPoint [
	"updates the code window with the code of the selected debug point"
	
	self text: aDebugPoint node methodNode sourceCode;
		beForMethod: aDebugPoint node methodNode compiledMethod;
		addTextSegmentDecoration: 
			(SpTextPresenterDecorator forHighlight
         		interval: (aDebugPoint node start to: ((aDebugPoint node stop) +1));
            yourself) .
		
]
