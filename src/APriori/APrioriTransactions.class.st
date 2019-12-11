Class {
	#name : #APrioriTransactions,
	#superclass : #Object,
	#category : #APriori
}

{ #category : #enumerating }
APrioriTransactions >> do: aBlock [ 
	self subclassResponsibility 
]

{ #category : #accessing }
APrioriTransactions >> size [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
APrioriTransactions >> uniqueItems [
	self subclassResponsibility 
]
