Class {
	#name : #Object,
	#superclass : #nil,
	#traits : '',
	#classTraits : '',
	#category : 'as yet unclassified'
}

Object >> hash [
	"Answer a SmallInteger whose value is related to the receiver's identity.
	May be overridden, and should be overridden in any classes that define = "

	^ self identityHash
]

Object >> identityHash [
	"Answer a SmallInteger whose value is related to the receiver's identity.
	May be overridden, and should be overridden in any classes that define = "

	^ self basicIdentityHash bitShift: 18
]

Object >> basicIdentityHash [
	"Answer a SmallInteger whose value is related to the receiver's identity.
	This method must not be overridden, except by SmallInteger.
	Primitive. Fails if the receiver is a SmallInteger. Essential.
	See Object documentation whatIsAPrimitive.

	Do not override. Use #identityHash unless you really know what you're doing.'"

	<primitive: 75>
	self primitiveFailed
]

{ #category : #'as yet unclassified' }
Object >> yourself [
	^ self
]

{ #category : #'as yet unclassified' }
Object >> basicSize [
	"Primitive. Answer the number of indexable variables in the receiver. 
	This value is the same as the largest legal subscript. Essential. Do not 
	override in any subclass. See Object documentation whatIsAPrimitive."

	<primitive: 62>
	"The number of indexable fields of fixed-length objects is 0"
	^0	
]

{ #category : #'as yet unclassified' }
Object >> ifNotNil: ifNotNilBlock [
	"Evaluate the block, unless I'm == nil (q.v.). If the receiver is not nil, pass it as argument to the block."

	"(2 ifNotNil: [ :o | o + 3]) >>> 5"
	"(nil ifNotNil: [:o | o +3 ]) >>> nil"

	^ ifNotNilBlock cull: self
]

{ #category : #'as yet unclassified' }
Object >> initialize [
	"Subclasses should redefine this method to perform initializations on instance creation" 
]

{ #category : #'as yet unclassified' }
Object >> species [
	"Answer the preferred class for reconstructing the receiver.  For example, 
	collections create new collections whenever enumeration messages such as 
	collect: or select: are invoked.  The new kind of collection is determined by 
	the species of the original collection.  Species and class are not always the 
	same.  For example, the species of Interval is Array."
	<primitive: 111>
	^self class
]

Object >> instVarNamed: aString [
	| index |
	index := self class allInstVarNames indexOf: aString.
	index == 0 ifTrue: [^ self error].
	^ self instVarAt: index
]

Object >> instVarNamed: aString put: aValue[
	| index |
	index := self class allInstVarNames indexOf: aString.
	index == 0 ifTrue: [^ self error].
	^ self instVarAt: index put: aValue
]

Object >> class [
	"Primitive. Answer the object which is the receiver's class. Essential. See 
	Object documentation whatIsAPrimitive."

	<primitive: 111>
	self primitiveFailed
]

Object >> asString [
	| stream |
	stream := WriteStream on: (String new: 100).
	self printOn: stream.
	^ stream contents
]