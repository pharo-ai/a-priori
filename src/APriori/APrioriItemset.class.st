Class {
	#name : #APrioriItemset,
	#superclass : #CTOrderedSet,
	#type : #variable,
	#instVars : [
		'algorithm'
	],
	#category : #APriori
}

{ #category : #'as yet unclassified' }
APrioriItemset >> =!= anObject [
	"Equality operation that checks not only the equality of items, but also the equality of algorithm"
	(self = anObject)
		ifFalse: [ ^ false ].
		
	^ self algorithm = anObject algorithm.
]

{ #category : #'as yet unclassified' }
APrioriItemset >> => anotherItemset [
	"An opeartor for creating an association rule.
	
	Example:
	#(a b c) asItemset => #(d e) asItemset.
	
	This will produce an association rule {a, b, c} => {d, e}"
	
	^ (self -> anotherItemset) asAssociationRule
]

{ #category : #accessing }
APrioriItemset >> algorithm [
	^ algorithm
]

{ #category : #accessing }
APrioriItemset >> algorithm: anObject [
	algorithm := anObject
]
