Class {
	#name : #APrioriTransactions,
	#superclass : #Object,
	#category : #'AI-APriori'
}

{ #category : #enumerating }
APrioriTransactions >> do: aBlock [ 
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
APrioriTransactions >> itembase [
	^ self uniqueItems 
]

{ #category : #accessing }
APrioriTransactions >> size [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
APrioriTransactions >> uniqueItems [
	self subclassResponsibility 
]
