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
APrioriFrequentItemsetsSelector >> selectFrequentItemsetsWithCounts: aCollectionOfCandidates [
	| itemsetsWithCounts count |
	
	itemsetsWithCounts := Dictionary new.
	
	aCollectionOfCandidates do: [ :itemset |
		count := itemsetCounter countOfItemset: itemset.
		
		count >= minCount ifTrue: [ 
			itemsetsWithCounts at: itemset put: count ] ].
	
	^ itemsetsWithCounts
]
