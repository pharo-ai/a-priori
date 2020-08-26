Class {
	#name : #APrioriFrequentItemsetsSelector,
	#superclass : #Object,
	#instVars : [
		'itemsetCounter',
		'minCount'
	],
	#category : #APriori
}

{ #category : #'as yet unclassified' }
APrioriFrequentItemsetsSelector class >> forTransactions: aTransactionsDatabase [ 
	^ self new initializeTransactions: aTransactionsDatabase 
]

{ #category : #initialization }
APrioriFrequentItemsetsSelector >> initializeTransactions: aTransactionsDatabase [
	itemsetCounter := APrioriItemsetCounter forTransactions: aTransactionsDatabase.
	minCount := 1.
]

{ #category : #accessing }
APrioriFrequentItemsetsSelector >> minCount [
	^ minCount
]

{ #category : #accessing }
APrioriFrequentItemsetsSelector >> minCount: aNumber [
	minCount := aNumber
]

{ #category : #'as yet unclassified' }
APrioriFrequentItemsetsSelector >> selectFrequentItemsets: aCollectionOfCandidates [

	^ aCollectionOfCandidates select: [ :itemset |
		itemset count: (itemsetCounter countOfItemset: itemset).
		itemset count >= minCount ]
]
