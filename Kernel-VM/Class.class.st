Class {
	#name : #Class,
	#superclass : #Object,
	#traits : '',
	#classTraits : '',
	#instVars : [
		'superclass',
		'methodDict',
		'format',
		'instVarNames',
		'name'
	],
	#category : 'as yet unclassified'
}

{ #category : #'as yet unclassified' }
Class >> basicNew [
	"Primitive. Answer an instance of the receiver (which is a class) with no 
	 indexable variables. Fail if the class is indexable. Essential. See Object 
	 documentation whatIsAPrimitive.
	
	 If the primitive fails because space is low then the scavenger will run
	 before the method is activated.  Check that space was low and retry
	 via handleFailingBasicNew if so."

	<primitive: 70 error: ec>
	ec == #'insufficient object memory' ifTrue:
		[^self handleFailingBasicNew].
	self isVariable ifTrue: [^self basicNew: 0].
	self primitiveFailed
]

{ #category : #'as yet unclassified' }
Class >> basicNew: sizeRequested [
	"Primitive. Answer an instance of this class with the number of indexable
	 variables specified by the argument, sizeRequested.  Fail if this class is not
	 indexable or if the argument is not a positive Integer, or if there is not
	 enough memory available. Essential. See Object documentation whatIsAPrimitive.
	
	 If the primitive fails because space is low then the scavenger will run before the
	 method is activated.  Check args and retry via handleFailingBasicNew: if they're OK."

	<primitive: 71 error: ec>
	ec == #'insufficient object memory' ifTrue:
		[^self handleFailingBasicNew: sizeRequested].
	self isVariable ifFalse:
		[self error: self printString, ' cannot have variable sized instances'].
	self primitiveFailed
]

{ #category : #'as yet unclassified' }
Class >> format [
	^ format
]

{ #category : #'as yet unclassified' }
Class >> formatOfImmediate [
	^ 7
]

{ #category : #'as yet unclassified' }
Class >> instSize [
	^ format bitAnd: 16rFFFF
]

{ #category : #'as yet unclassified' }
Class >> instSpec [
	^(format bitShift: -16) bitAnd: 16r1F
]

{ #category : #'as yet unclassified' }
Class >> new [
	"Answer a new initialized instance of the receiver (which is a class) with no indexable variables. Fail if the class is indexable."

	^ self basicNew initialize

]

{ #category : #'as yet unclassified' }
Class >> new: sizeRequested [ 
	"Answer an initialized instance of this class with the number of indexable
	variables specified by the argument, sizeRequested."

	^ (self basicNew: sizeRequested) initialize  
]

{ #category : #'as yet unclassified' }
Class >> quit [
	"Exit from the system."
	<primitive: 113>
]

{ #category : #'as yet unclassified' }
Class >> start [
	| f path |
	f := File new. 
	path := f localFolderPath, '.txt'.
	f openReadWrite: path.
	f position: f size.
	f nextPutAll: 'hola'.
	f close.
	self quit
]

{ #category : #'as yet unclassified' }
Class >> name: aString [
	name := aString
]

{ #category : #'as yet unclassified' }
Class >> name [
	^ name
]

{ #category : #'as yet unclassified' }
Class >> superclass [
	^ superclass
]

{ #category : #'as yet unclassified' }
Class >> superclass: aClass [
	superclass := aClass
]

{ #category : #'as yet unclassified' }
Class >> initialize [
	methodDict := MethodDictionary new: 4.
	format := 0.
	superclass := Object
]

{ #category : #'as yet unclassified' }
Class >> instVarNames: aCollection [
	| instSize |
	" use with caution, the instSpec of the class must be 0 or 1 "
	instSize := aCollection size.
	instVarNames := aCollection.
	format := 1 << 16 + instSize
]

{ #category : #'as yet unclassified' }
Class >> instVarNames [
	^ instVarNames 
]

{ #category : #'as yet unclassified' }
Class >> allInstVarNames [
	
	^ self superclass
		ifNil: [ self instVarNames ]
		ifNotNil: [ :sup | sup allInstVarNames , self instVarNames ]
]