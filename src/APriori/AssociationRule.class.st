Class {
	#name : #AssociationRule,
	#superclass : #Association,
	#instVars : [
		'count',
		'support',
		'confidence',
		'lift'
	],
	#category : #APriori
}

{ #category : #converting }
AssociationRule >> = anObject [
	"AssociationRule inherits from Association, so we override the equality operator to test not only the equality of association's key and value, but also the equality of count, support, confidence, and lift"
	(super = anObject)
		ifFalse: [ ^ false ].
		
	^ { self count . self support . self confidence . self lift } = { anObject count . anObject support . anObject confidence . anObject lift }
]

{ #category : #converting }
AssociationRule >> asItemset [
	"Association rule can be turned into an itemset by uniting its key and value itemsets:
	(#(a b c) asItemset => #(d e) asItemset) asItemset >>> #(a b c d e) asItemset"
	
	^ self key union: self value
]

{ #category : #accessing }
AssociationRule >> confidence [
	^ confidence
]

{ #category : #accessing }
AssociationRule >> confidence: anObject [
	confidence := anObject
]

{ #category : #accessing }
AssociationRule >> count [
	^ count
]

{ #category : #accessing }
AssociationRule >> count: anObject [
	count := anObject
]

{ #category : #accessing }
AssociationRule >> lift [
	^ lift
]

{ #category : #accessing }
AssociationRule >> lift: anObject [
	lift := anObject
]

{ #category : #printing }
AssociationRule >> printOn: aStream [
	self key printOn: aStream.
	aStream nextPutAll: ' => '.
	self value printOn: aStream.
]

{ #category : #accessing }
AssociationRule >> support [
	^ support
]

{ #category : #accessing }
AssociationRule >> support: anObject [
	support := anObject
]
