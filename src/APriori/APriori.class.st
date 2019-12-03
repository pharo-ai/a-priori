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
	"Find association rules if they were not found before. If they were - just return the rules. The algorithm works with integers, so we decode each integer as an item before returning the rules. Association rules are instances of AssociationRule class. They can be reresented as an association of two itemsets:
	
	{a, b, c} => {d, e}
	
	Meanining that customers who purchased a, b, and c, are also likely to purchase d and e."
	
	associationRules ifNil: [ self findAssociationRules ].
	^ AssociationRulesCollection withAll: (encoder decodeRules: associationRules)
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
	"Calculate count and support of an itemset:
	
	* count - number of transactions that contain all items of the given itemset 
	* support - probability that a randomly picked transactions contains all items of the given itemset. 
	
	Save both values in the itemset (each itemset should know its count and support)"
	
	itemset count: (self countOfItemset: itemset).
	itemset support: itemset count / transactions size.
]

{ #category : #'private - statistics' }
APriori >> calculateStatisticsOfRule: rule [
	"Calculate count, support, confidence, and lift of an association rule:
	
	* count - number of transactions that contain all items of the itemset constructed by joining itemsets on the right and left hand sides of the rule.
	* support - the probability that a randomly picked transaction contains all items of that itemset.
	* confidence - conditional probability of the rule
	* lift - a correlation measure between the itemsets in the left and right hand sides. It assesses the degree to which the occurence of items in the left itemset 'lifts' (increases) the likelihood of items from the right itemset to appear.
	
	Save all those values in the rule (each rule should know its count, support, confidence, and lift)"
	
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
	"Find all candidate itemsets of size k by joining the set of frequent itemsets of size k-1 with iteself"
	| candidates |
	candidates := self joinFrequentItemsetsOfSize: k - 1.
	candidates := self pruneCandidates: candidates.
	^ candidates
]

{ #category : #accessing }
APriori >> confidenceThreshold [
	^ confidenceThreshold
]

{ #category : #'lazy counting' }
APriori >> countOfItemset: itemset [
	"Return the number of transactions that contain the given itemset. To speed up and not count the same itemset multiple times, we save the result in a dictionary and perform the calculations only for those itemsets that have not been counted before."

	| items |
	"we convert itemset to array because we only need to compare two itemsets by their items, not their counts and supports"
	items := itemset asArray.
	
	(countDictionary includesKey: items) ifFalse: [
		countDictionary at: items put: (self calculateCountOfItemset: itemset) ].
	
	^ countDictionary at: items
]

{ #category : #accessing }
APriori >> encoder [ 
	^ encoder
]

{ #category : #'private - recommendation' }
APriori >> findAssociationRules [
	"Find frequent itemsets (or reuse the ones that have already been found), renerate all possible association rules from them, and select those rules that pass the confidence threshold. Save the result inside associationRules variable. This methor will only be executed if associationRules is empty"
	| itemsets |
	itemsets := self frequentItemsets collect: [ :itemset |
		self encoder encodeItemset: itemset ].
	
	associationRules := itemsets flatCollect: [ :itemset |
		itemset allAssociationRules select: [ :rule |
			self calculateStatisticsOfRule: rule.
			rule confidence >= self confidenceThreshold ] ].
	
	associationRules sort: [ :a :b | a > b ].
]

{ #category : #'private - recommendation' }
APriori >> findFrequentItemsets [
	"Find all frequent itemsets - all itemsets that pass the support threshold, meaning that they appear in transactions at least a given number of times. We start by finding frequent itemsets of size 1, then we use them to fing frequent itemsets of size 2, then 3, 4, and so on until we get an empty set."
	| k frequentItemsetsOfSizeK |
	
	k := 1.
	frequentItemsets := Dictionary new.
	
	frequentItemsetsOfSizeK := self findFrequentItemsetsOfSizeOne.
	
	[ frequentItemsetsOfSizeK isEmpty ] whileFalse: [
		frequentItemsets at: k put: frequentItemsetsOfSizeK.
		k := k + 1.
		frequentItemsetsOfSizeK := self findFrequentItemsetsOfSize: k ].
	
	frequentItemsets := frequentItemsets values flatCollect: #yourself.
	frequentItemsets sort: [ :a :b | a > b ].
]

{ #category : #private }
APriori >> findFrequentItemsetsOfSize: k [
	"Find frequent itemsets of size k by generating the candidate itemsets (joining a set frequent itemsets of size k-1 with itself) and selecting those that pass the support threshold"
	| candidates |
	candidates := self candidatesOfSize: k.
	
	candidates do: [ :itemset | self calculateStatisticsOfItemset: itemset ].
	
	^ candidates select: [ :itemset |
		itemset support >= self supportThreshold ].
]

{ #category : #private }
APriori >> findFrequentItemsetsOfSizeOne [
	"Find frequent itemsets of size 1 by finding a set of unique items, turning each one of them into an itemset of size 1, and selecting as frequent ones those itemsets that pass the support threshold"
	| uniqueItems itemsets |
	
	uniqueItems := (transactions flatCollect: #yourself) asSet.
	itemsets := uniqueItems collect: [ :item | { item } asItemset ].
	
	itemsets do: [ :itemset | self calculateStatisticsOfItemset: itemset ].
	
	^ itemsets select: [ :itemset |
		itemset support >= self supportThreshold ].
]

{ #category : #'api - lazy recommendation' }
APriori >> frequentItemsets [
	"Find frequent itemsets (the ones that pass the support threshold) and save the result. If frequent itemsets have already been fond before, we simply return them without performing the same calculations again. This is especially useful when we find frequent itemsets AND association rules. Because to find association rules we need to find frequent itemsets (which is the most time-consuming operation), so we can use the ones that were found before."
	frequentItemsets ifNil: [ self findFrequentItemsets ].
	^ ItemsetsCollection withAll: (encoder decodeItemsets: frequentItemsets)
]

{ #category : #initialization }
APriori >> initialize [ 
	super initialize.
	countDictionary := Dictionary new.
]

{ #category : #initialization }
APriori >> initializeTransactions: aCollectionOfItemsets supportThreshold: aSupportThreshold confidenceThreshold: aConfidenceThreshold [
	"Initialize APriori with a collection of transactions as well as the support and confidence threshols. Create an empty encoder and use it to encode transactions. Encoder will store the encoding dictionary and will be able to decode any itemset or rule that will be generated"
	transactions := aCollectionOfItemsets.
	supportThreshold := aSupportThreshold.
	confidenceThreshold := aConfidenceThreshold.
	
	encoder := ItemsetEncoder basedOn: transactions.
	transactions := encoder encodeItemsets: transactions.
	^ self
]

{ #category : #'private - recommendation' }
APriori >> joinFrequentItemsetsOfSize: k [
	"Join step of candidate generation"
	^ (frequentItemsets at: k) flatCollect: [ :itemset1 |
		(frequentItemsets at: k)
			select: [ :itemset2 | itemset1 canBeJoinedWith: itemset2 ]
			thenCollect: [ :itemset2 | itemset1 joinWith: itemset2 ] ].
]

{ #category : #'private - recommendation' }
APriori >> pruneCandidates: candidates [ 
	"Prune step of candidate generation"

	^ candidates select: [ :itemset |
		itemset allLargestSubsets allSatisfy: [ :eachSubset |
			(frequentItemsets at: eachSubset size) anySatisfy: [ :aFrequentItemset |
				aFrequentItemset asArray = eachSubset asArray ] ] ].
]

{ #category : #accessing }
APriori >> supportThreshold [
	^ supportThreshold
]

{ #category : #accessing }
APriori >> transactions [
	^ transactions
]
