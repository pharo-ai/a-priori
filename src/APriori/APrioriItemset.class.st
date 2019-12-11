Class {
	#name : #APrioriItemset,
	#superclass : #CTOrderedSet,
	#type : #variable,
	#instVars : [
		'metrics'
	],
	#category : #APriori
}

{ #category : #'as yet unclassified' }
APrioriItemset >> =!= anObject [
	"Equality operation that checks not only the equality of items, but also the equality of algorithm"
	(self = anObject)
		ifFalse: [ ^ false ].
		
	^ self metrics = anObject metrics.
]

{ #category : #'as yet unclassified' }
APrioriItemset >> => anotherItemset [
	"An opeartor for creating an association rule.
	
	Example:
	#(a b c) asItemset => #(d e) asItemset.
	
	This will produce an association rule {a, b, c} => {d, e}"
	
	^ (self -> anotherItemset) asAssociationRule
]

{ #category : #'as yet unclassified' }
APrioriItemset >> allAssociationRules [ 
	"Generate all possible association rules from this itemset.
	Example:
	{1, 2, 3} --> 
		{1} => {2, 3}
		{2} => {1, 3}
		{3} => {1, 2}
		{1, 2} => {3}
		{1, 3} => {2}
		{2, 3} => {1}"
	
	| rules |
	rules := self allSubsets collect: [ :eachSubset |
		eachSubset => (self difference: eachSubset) ].
	
	rules collect: [ :rule | rule parentItemset: self ].
	^ rules
]

{ #category : #accessing }
APrioriItemset >> count [ 
	^ metrics at: APrioriCountMetric
]

{ #category : #accessing }
APrioriItemset >> count: aNumber [
	metrics at: APrioriCountMetric put: aNumber
]

{ #category : #initialization }
APrioriItemset >> initialize [
	super initialize.
	metrics := Dictionary new.
]

{ #category : #accessing }
APrioriItemset >> metrics [ 
	^ metrics
]

{ #category : #accessing }
APrioriItemset >> support [ 
	^ metrics at: APrioriSupportMetric
]
