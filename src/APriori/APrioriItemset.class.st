Class {
	#name : #APrioriItemset,
	#superclass : #CTOrderedSet,
	#type : #variable,
	#instVars : [
		'metricsValues'
	],
	#category : #APriori
}

{ #category : #'as yet unclassified' }
APrioriItemset >> =!= anObject [
	"Equality operation that checks not only the equality of items, but also the equality of metricsValues"
	(self = anObject)
		ifFalse: [ ^ false ].
		
	^ self metricsValues = anObject metricsValues.
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
APrioriItemset >> count [ 
	^ metricsValues at: APrioriCountMetric
]

{ #category : #accessing }
APrioriItemset >> count: aNumber [
	metricsValues at: APrioriCountMetric put: aNumber
]

{ #category : #initialization }
APrioriItemset >> initialize [
	super initialize.
	metricsValues := Dictionary new.
]

{ #category : #accessing }
APrioriItemset >> metricsValues [ 
	^ metricsValues
]

{ #category : #printing }
APrioriItemset >> printOn: aStream [

	aStream
		nextPut: ${;
		nextPutAll: (', ' join: self);
		nextPut: $}.
	(self metricsValues includesKey: APrioriCountMetric)
		ifTrue: [  
			aStream
				space;
				nextPut: $[;
				nextPutAll: self count asString;
				nextPut: $] ]
]

{ #category : #accessing }
APrioriItemset >> support [ 
	^ metricsValues at: APrioriSupportMetric
]
