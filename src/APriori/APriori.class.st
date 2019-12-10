Class {
	#name : #APriori,
	#superclass : #Object,
	#instVars : [
		'frequentItemsets',
		'numberOfTransactions'
	],
	#category : #APriori
}

{ #category : #'lazy counting' }
APriori >> countOfItemset: anItemset [
	^ frequentItemsets at: anItemset
]

{ #category : #accessing }
APriori >> frequentItemsets [
	^ frequentItemsets
]

{ #category : #accessing }
APriori >> frequentItemsets: anObject [
	frequentItemsets := anObject
]

{ #category : #accessing }
APriori >> numberOfTransactions [
	^ numberOfTransactions
]

{ #category : #accessing }
APriori >> numberOfTransactions: anObject [
	numberOfTransactions := anObject
]
