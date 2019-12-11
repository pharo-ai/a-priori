Class {
	#name : #APrioriFrequentItemsetsSelector,
	#superclass : #Object,
	#instVars : [
		'itemsetCounter',
		'minCount'
	],
	#category : #APriori
}

{ #category : #initialization }
APrioriFrequentItemsetsSelector >> initializeTransactions: aTransactionsDatabase minCount: aMinCountThreshold [
	itemsetCounter := APrioriItemsetCounter forTransactions: aTransactionsDatabase.
	minCount := aMinCountThreshold.
]

{ #category : #'as yet unclassified' }
APrioriFrequentItemsetsSelector >> selectFrequentItemsets: aCollectionOfCandidates [
	| count |
	
	^ aCollectionOfCandidates select: [ :itemset |
		count := itemsetCounter countOfItemset: itemset.
		count >= minCount ].
]
