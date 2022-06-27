Class {
	#name : #APrioriMockTransactions,
	#superclass : #Object,
	#category : #'AI-APriori-Tests'
}

{ #category : #'test data' }
APrioriMockTransactions >> transactions [
	^ #( 
		(eggs milk butter)
		(milk cereal)
		(eggs bacon)
		(bread butter)
		(bread bacon eggs)
		(bread avocado butter bananas))
]
