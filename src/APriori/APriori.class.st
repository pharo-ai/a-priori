Class {
	#name : #APriori,
	#superclass : #Object,
	#instVars : [
		'supportThreshold',
		'confidenceThreshold',
		'frequentItemsets'
	],
	#category : #APriori
}

{ #category : #'as yet unclassified' }
APriori class >> supportThreshold: aSupportThreshold confidenceThreshold: aConfidenceThreshold [
	^ self new
		supportThreshold: aSupportThreshold;
		confidenceThreshold: aConfidenceThreshold;
		yourself
]

{ #category : #'as yet unclassified' }
APriori >> associationRulesFrom: transactions [
	| itemsets |
	itemsets := self frequentItemsetsIn: transactions.
	
	^ itemsets flatCollect: [ :itemset |
		itemset allAssociationRules select: [ :rule |
			(rule confidenceIn: transactions) >= self confidenceThreshold ] ]
]

{ #category : #'as yet unclassified' }
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

{ #category : #accessing }
APriori >> confidenceThreshold: anObject [
	confidenceThreshold := anObject
]

{ #category : #'as yet unclassified' }
APriori >> frequentItemsetsIn: transactions [
	| k frequentItemsetsOfSizeK |
	
	k := 1.
	frequentItemsets := Dictionary new.
	
	frequentItemsetsOfSizeK := (self frequentItemsetsOfSizeOneIn: transactions).
	
	[ frequentItemsetsOfSizeK isEmpty ] whileFalse: [
		frequentItemsets at: k put: frequentItemsetsOfSizeK.
		k := k + 1.
		frequentItemsetsOfSizeK := self frequentItemsetsOfSize: k in: transactions ].

	^ frequentItemsets values copyWithoutFirst flatCollect: #yourself.
]

{ #category : #'as yet unclassified' }
APriori >> frequentItemsetsOfSize: k in: transactions [
	| candidates |
	candidates := self candidatesOfSize: k.
	^ candidates select: [ :itemset |
		(itemset supportIn: transactions) >= self supportThreshold ].
]

{ #category : #'as yet unclassified' }
APriori >> frequentItemsetsOfSizeOneIn: transactions [
	| uniqueItems itemsetsOfSizeOne |
	uniqueItems := (transactions flatCollect: #yourself) asSet.
	itemsetsOfSizeOne := uniqueItems collect: [ :item | { item } asItemset ].
	^ itemsetsOfSizeOne select: [ :itemset |
		(itemset supportIn: transactions) >= self supportThreshold ].
]

{ #category : #accessing }
APriori >> supportThreshold [
	^ supportThreshold
]

{ #category : #accessing }
APriori >> supportThreshold: anObject [
	supportThreshold := anObject
]
