Class {
	#name : #APrioriTransactionsArray,
	#superclass : #APrioriTransactions,
	#instVars : [
		'array'
	],
	#category : #'AI-APriori'
}

{ #category : #'instance creation' }
APrioriTransactionsArray class >> from: anArray [
	^ self new initializeArray: anArray
]

{ #category : #enumerating }
APrioriTransactionsArray >> do: aBlock [ 
	array do: aBlock
]

{ #category : #initialization }
APrioriTransactionsArray >> initializeArray: anArray [
	array := anArray
]

{ #category : #'as yet unclassified' }
APrioriTransactionsArray >> size [ 
	^ array size
]

{ #category : #'as yet unclassified' }
APrioriTransactionsArray >> uniqueItems [
	^ (array flatCollect: #yourself) asSet
]
