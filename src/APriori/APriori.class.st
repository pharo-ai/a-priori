Class {
	#name : #APriori,
	#superclass : #Object,
	#instVars : [
		'supportThreshold',
		'confidenceThreshold',
		'frequentItemsets',
		'transactions',
		'associationRules',
		'countDictionary',
		'encoder'
	],
	#category : #APriori
}

{ #category : #'instance creation' }
APriori class >> new [ 
	self shouldNotImplement 
]

{ #category : #'as yet unclassified' }
APriori class >> transactions: transactions supportThreshold: aSupportThreshold confidenceThreshold: aConfidenceThreshold [
	| transactionsAsItemsets |
	transactionsAsItemsets := transactions collect: #asItemset.
	
	^ super new
		initializeTransactions: transactionsAsItemsets
		supportThreshold: aSupportThreshold
		confidenceThreshold: aConfidenceThreshold
]

{ #category : #'api - lazy recommendation' }
APriori >> associationRules [
	associationRules ifNil: [ self findAssociationRules ].
	^ self decodeRules: associationRules
]

{ #category : #'private - counting' }
APriori >> calculateCountOfItemset: itemset [
	"Find the number of transactions that contain all items of the given itemset"
	
	| count |
	count := 0.
	
	transactions do: [ :eachItemset |
		(eachItemset isSupersetOf: itemset)
			ifTrue: [ count := count + 1 ] ].
			
	^ count
	
]

{ #category : #'private - statistics' }
APriori >> calculateStatisticsOfItemset: itemset [
	"Find the number of transactions that contain all items of the given itemset as well as the probability that a randomly picked transactions contains all items of the given itemset. Save both these numbers in the itemset"
	
	itemset count: (self countOfItemset: itemset).
	itemset support: itemset count / transactions size.
]

{ #category : #'private - statistics' }
APriori >> calculateStatisticsOfRule: rule [
	"Find the number of transactions that contain all items of the itemset proposed by the given rule (union of itemsets on left and right hand sides of the rule) as well as support - the probability that a randomly picked transactions contains all items of that given itemset, confidence - conditional probability of the rule, and lift. Save all those values in the rule"
	
	| itemset |
	itemset := rule asItemset.
	self calculateStatisticsOfItemset: itemset.
	self calculateStatisticsOfItemset: rule key.
	self calculateStatisticsOfItemset: rule value.
	
	rule count: itemset count.
	rule support: itemset support.
	rule confidence: itemset count / rule key count.
	rule lift: itemset support / (rule key support * rule value support).
	
	
]

{ #category : #'private - recommendation' }
APriori >> candidatesOfSize: k [
	^ (frequentItemsets at: k - 1) flatCollect: [ :itemset1 |
		(frequentItemsets at: k - 1)
			select: [ :itemset2 | itemset1 canBeJoinedWith: itemset2 ]
			thenCollect: [ :itemset2 | itemset1 joinWith: itemset2 ] ].
]

{ #category : #accessing }
APriori >> confidenceThreshold [
	^ confidenceThreshold
]

{ #category : #'lazy counting' }
APriori >> countOfItemset: itemset [
	| items |
	"we convert itemset to array because we only need to compare two itemsets by their items, not their counts and supports"
	items := itemset asArray.
	
	(countDictionary includesKey: items) ifFalse: [
		countDictionary at: items put: (self calculateCountOfItemset: itemset) ].
	
	^ countDictionary at: items
]

{ #category : #'private - encoding decoding' }
APriori >> decodeItemsets: aCollectionOfItemsets [
	^ aCollectionOfItemsets collect: [ :itemset |
		encoder decodeItemset: itemset ].
]

{ #category : #'private - encoding decoding' }
APriori >> decodeRules: aCollectionOfRules [
	^ aCollectionOfRules collect: [ :rule |
		encoder decodeRule: rule ].
]

{ #category : #'private - encoding decoding' }
APriori >> encodeTransactions [
	transactions := transactions collect: [ :itemset |
		encoder encodeItemset: itemset ].
]

{ #category : #accessing }
APriori >> encoder [ 
	^ encoder
]

{ #category : #'private - recommendation' }
APriori >> findAssociationRules [
	| itemsets |
	itemsets := self frequentItemsets collect: [ :itemset |
		self encoder encodeItemset: itemset ].
	
	associationRules := itemsets flatCollect: [ :itemset |
		itemset allAssociationRules select: [ :rule |
			self calculateStatisticsOfRule: rule.
			rule confidence >= self confidenceThreshold ] ]
]

{ #category : #'private - recommendation' }
APriori >> findFrequentItemsets [
	| k frequentItemsetsOfSizeK |
	
	k := 1.
	frequentItemsets := Dictionary new.
	
	frequentItemsetsOfSizeK := self findFrequentItemsetsOfSizeOne.
	
	[ frequentItemsetsOfSizeK isEmpty ] whileFalse: [
		frequentItemsets at: k put: frequentItemsetsOfSizeK.
		k := k + 1.
		frequentItemsetsOfSizeK := self findFrequentItemsetsOfSize: k ].

	frequentItemsets := frequentItemsets values copyWithoutFirst flatCollect: #yourself.
]

{ #category : #private }
APriori >> findFrequentItemsetsOfSize: k [
	| candidates |
	candidates := self candidatesOfSize: k.
	
	candidates do: [ :itemset | self calculateStatisticsOfItemset: itemset ].
	
	^ candidates select: [ :itemset |
		itemset support >= self supportThreshold ].
]

{ #category : #private }
APriori >> findFrequentItemsetsOfSizeOne [
	| uniqueItems itemsets |
	
	uniqueItems := (transactions flatCollect: #yourself) asSet.
	itemsets := uniqueItems collect: [ :item | { item } asItemset ].
	
	itemsets do: [ :itemset | self calculateStatisticsOfItemset: itemset ].
	
	^ itemsets select: [ :itemset |
		itemset support >= self supportThreshold ].
]

{ #category : #'api - lazy recommendation' }
APriori >> frequentItemsets [
	frequentItemsets ifNil: [ self findFrequentItemsets ].
	^ self decodeItemsets: frequentItemsets
]

{ #category : #initialization }
APriori >> initialize [ 
	super initialize.
	countDictionary := Dictionary new.
]

{ #category : #initialization }
APriori >> initializeTransactions: aCollectionOfItemsets supportThreshold: aSupportThreshold confidenceThreshold: aConfidenceThreshold [
	transactions := aCollectionOfItemsets.
	supportThreshold := aSupportThreshold.
	confidenceThreshold := aConfidenceThreshold.
	
	encoder := ItemsetEncoder basedOn: transactions.
	self encodeTransactions.
	^ self
]

{ #category : #accessing }
APriori >> supportThreshold [
	^ supportThreshold
]

{ #category : #accessing }
APriori >> transactions [
	^ transactions
]
