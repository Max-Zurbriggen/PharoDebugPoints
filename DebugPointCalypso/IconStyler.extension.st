Extension { #name : #IconStyler }

{ #category : #'*DebugPointCalypso' }
IconStyler class >> withStaticStylers [
	"Configure the receiver to invoke several static stylers. Now it is probably better to use the instance API:
	
	IconStyler new
		stylerClasses: { YourLovelyStyler };
		styleText: aTextModel withAST: anAST
	"
	
	^ self new 
		stylerClasses: (Set new addAll: DebugPointIconStyler subclasses;addAll: DPIconStyler subclasses; addAll: {BreakpointIconStyler. CounterIconStyler. DisabledBreakpointIconStyler. FlagIconStyler. HaltIconStyler. MetaLinkIconStyler. SemanticWarningIconStyler. WatchIconStyler. DocCommentIconStyler}; yourself); 
		yourself
]
