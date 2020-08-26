Class {
	#name : #APriori,
	#superclass : #Object,
	#instVars : [
		'frequentItemsets',
		'numberOfTransactions',
		'frequentItemsetSelector',
		'candidateGenerator',
		'associationRules',
		'itemsetMetrics',
		'associationRuleMetrics',
		'itembase'
	],
	#category : #APriori
}

{ #category : #'as yet unclassified' }
APriori class >> forTransactions: aTransactionsDatabase [
	^ self new initializeTransactions: aTransactionsDatabase 
]

{ #category : #'as yet unclassified' }
APriori >> allAssociationRulesFromItemset: anItemset [
	"Generate all possible association rules from the given itemset.
	Example:
	{1, 2, 3} --> 
		{1} => {2, 3}
		{2} => {1, 3}
		{3} => {1, 2}
		{1, 2} => {3}
		{1, 3} => {2}
		{2, 3} => {1}"
	
	| keys values |
	
	keys := anItemset allSubsets.
	values := keys collect: [ :key | anItemset difference: key ].
	
	"We need to get counts of those itemsets"
	keys := keys collect: [ :itemset |
		frequentItemsets detect: [ :itemsetWithCount |
			itemset = itemsetWithCount ] ].
	
	values := values collect: [ :itemset |
		frequentItemsets detect: [ :itemsetWithCount |
			itemset = itemsetWithCount ] ].
	
	^ keys with: values collect: [ :key :value |
		(key => value)
			parentItemset: anItemset;
			yourself ]
]

{ #category : #accessing }
APriori >> associationRuleMetrics [
	^ associationRuleMetrics 
]

{ #category : #accessing }
APriori >> associationRules [
	^ associationRules
]

{ #category : #'as yet unclassified' }
APriori >> buildAssociationRules [
	"Generate all possible association rules from frequent itemsets"
	associationRules := frequentItemsets flatCollect: [ :itemset |
		self allAssociationRulesFromItemset: itemset ].
]

{ #category : #'as yet unclassified' }
APriori >> calculateAssociationRuleMetrics: aCollectionOfMetricsClasses [

	associationRuleMetrics := self instantiateMetrics: aCollectionOfMetricsClasses.

	associationRules do: [ :rule |
		associationRuleMetrics do: [ :metric |
			rule metricsValues at: metric class put: (metric valueForAssociationRule: rule) ] ]
]

{ #category : #'as yet unclassified' }
APriori >> calculateItemsetMetrics: aCollectionOfMetricsClasses [

	itemsetMetrics := self instantiateMetrics: aCollectionOfMetricsClasses.

	frequentItemsets do: [ :itemset |
		itemsetMetrics do: [ :metric |
			itemset metricsValues at: metric class put: (metric valueForItemset: itemset) ] ]
]

{ #category : #'as yet unclassified' }
APriori >> findFrequentItemsets [ 
	"Find all frequent itemsets - all itemsets that pass the support threshold, meaning that they appear in transactions at least a given number of times. We start by finding frequent itemsets of size 1, then we use them to fing frequent itemsets of size 2, then 3, 4, and so on until we get an empty set."
	| frequentKItemsets candidates |
	
	candidates := itembase collect: [ :item | { item } asItemset ].
	frequentKItemsets := frequentItemsetSelector selectFrequentItemsets: candidates.
	
	[ frequentKItemsets isEmpty ] whileFalse: [
		frequentItemsets addAll: frequentKItemsets.
		candidates := candidateGenerator generateCandidatesFrom: frequentKItemsets.
		frequentKItemsets := frequentItemsetSelector selectFrequentItemsets: candidates ].
]

{ #category : #accessing }
APriori >> frequentItemsets [
	^ frequentItemsets
]

{ #category : #initialization }
APriori >> initializeTransactions: transactions [
	candidateGenerator := APrioriCandidateGenerator new.
	frequentItemsetSelector := APrioriFrequentItemsetsSelector forTransactions: transactions.
	
	itembase := transactions itembase. 
	numberOfTransactions := transactions size.
	
	frequentItemsets := OrderedCollection new.
	associationRules := OrderedCollection new.
	itemsetMetrics := OrderedCollection new.
	associationRuleMetrics := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
APriori >> instantiateMetrics: aCollectionOfMetricsClasses [
	| metrics |
	metrics := aCollectionOfMetricsClasses collect: [ :aClass | aClass new ].
	metrics do: [ :metric | metric numberOfTransactions: numberOfTransactions ].
	^ metrics
]

{ #category : #accessing }
APriori >> itemsetMetrics [
	^ itemsetMetrics
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
	^ self minCount / numberOfTransactions
]

{ #category : #accessing }
APriori >> minSupport: aMinimumSupportThreshold [
	self minCount: aMinimumSupportThreshold * numberOfTransactions
]

{ #category : #accessing }
APriori >> numberOfTransactions [
	^ numberOfTransactions
]
