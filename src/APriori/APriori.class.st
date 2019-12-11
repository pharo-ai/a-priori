Class {
	#name : #APriori,
	#superclass : #Object,
	#instVars : [
		'frequentItemsets',
		'numberOfTransactions',
		'itembase',
		'frequentItemsetSelector',
		'candidateGenerator',
		'associationRules'
	],
	#category : #APriori
}

{ #category : #'as yet unclassified' }
APriori class >> forTransactions: aTransactionsDatabase [
	^ self new initializeTransactions: aTransactionsDatabase 
]

{ #category : #'as yet unclassified' }
APriori >> buildAssociationRules [
	"Generate all possible association rules from frequent itemsets"
	associationRules := frequentItemsets keys flatCollect: [ :itemset |
		itemset allAssociationRules ].
]

{ #category : #'lazy counting' }
APriori >> countOfItemset: anItemset [
	^ frequentItemsets at: anItemset
]

{ #category : #'as yet unclassified' }
APriori >> findFrequentItemsets [ 
	"Find all frequent itemsets - all itemsets that pass the support threshold, meaning that they appear in transactions at least a given number of times. We start by finding frequent itemsets of size 1, then we use them to fing frequent itemsets of size 2, then 3, 4, and so on until we get an empty set."
	| frequentKItemsets candidates |
	
	candidates := itembase collect: [ :item | { item } asItemset ].
	frequentKItemsets := frequentItemsetSelector selectFrequentItemsetsWithCounts: candidates.
	
	[ frequentKItemsets isEmpty ] whileFalse: [
		frequentItemsets addAll: frequentKItemsets.
		candidates := candidateGenerator generateCandidatesFrom: frequentKItemsets keys.
		frequentKItemsets := frequentItemsetSelector selectFrequentItemsetsWithCounts: candidates ].
]

{ #category : #accessing }
APriori >> frequentItemsets [
	^ frequentItemsets
]

{ #category : #accessing }
APriori >> frequentItemsets: anObject [
	frequentItemsets := anObject
]

{ #category : #initialization }
APriori >> initializeTransactions: aTransactionsDatabase [
	candidateGenerator := APrioriCandidateGenerator new.
	frequentItemsetSelector := APrioriFrequentItemsetsSelector forTransactions: aTransactionsDatabase.
	
	itembase := aTransactionsDatabase uniqueItems.
	numberOfTransactions := aTransactionsDatabase size.
	
	frequentItemsets := Dictionary new.
]

{ #category : #accessing }
APriori >> minCount [
	^ frequentItemsetSelector minCount
]

{ #category : #accessing }
APriori >> minCount: aMinimumCountThreshold [
	frequentItemsetSelector minCount: aMinimumCountThreshold
]

{ #category : #accessing }
APriori >> minSupport [
	^ self minCount * numberOfTransactions
]

{ #category : #accessing }
APriori >> minSupport: aMinimumSupportThreshold [
	self minCount: aMinimumSupportThreshold * numberOfTransactions
]

{ #category : #accessing }
APriori >> numberOfTransactions [
	^ numberOfTransactions
]

{ #category : #accessing }
APriori >> numberOfTransactions: anObject [
	numberOfTransactions := anObject
]
