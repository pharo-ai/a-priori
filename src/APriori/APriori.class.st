Class {
	#name : #APriori,
	#superclass : #Object,
	#category : #APriori
}

{ #category : #'as yet unclassified' }
APriori >> supportOf: aBasket in: aCollectionOfBaskets [
	"The probability that all items from aBasket appear together in a randomly selected basket from aCollectionOfBaskets. In other words, this is the number of baskets that contain all items from aBasket divided by the total number of baskets"
	| basketsThatContainAllItems |
	basketsThatContainAllItems := aCollectionOfBaskets select: [ :each |
		each items includesAll: aBasket items ].
	
	^ basketsThatContainAllItems size / aCollectionOfBaskets size.
]
