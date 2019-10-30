Class {
	#name : #Itemset,
	#superclass : #Set,
	#category : #APriori
}

{ #category : #'as yet unclassified' }
Itemset >> => anotherItemset [
	^ (self -> anotherItemset) asAssociationRule
]

{ #category : #'as yet unclassified' }
Itemset >> allAssociationRules [
	"Generate all possible association rules from this itemset.
	Example:
	{1, 2, 3} --> 
		{1} => {2, 3}
		{2} => {1, 3}
		{3} => {1, 2}
		{1, 2} => {3}
		{1, 3} => {2}
		{2, 3} => {1}"
	^ self allSubsets collect: [ :eachSubset |
		eachSubset => (self difference: eachSubset) ].
]

{ #category : #'as yet unclassified' }
Itemset >> allSubsets [
	"Generate all possible nonempty itemsets that are the subset of this itemset.
	Example:
	{1, 2, 3} => {1}, {2}, {3}, {1, 2}, {1, 3}, {2, 3}"
	^ (self asArray combinations collect: #asItemset) copyWithout: self
]

{ #category : #'as yet unclassified' }
Itemset >> isSupersetOf: anotherItemset [
	"Check if all items of another itemset are included in this itemset"
	anotherItemset
		detect: [ :each | (self includes: each) not ]
		ifFound: [ ^ false ].
		
	^ true
]

{ #category : #printing }
Itemset >> printOn: aStream [
	aStream
		nextPut: ${;
		nextPutAll: (', ' join: self);
		nextPut: $}.
]

{ #category : #'as yet unclassified' }
Itemset >> supportIn: transactions [
	"The probability that a random transaction (itemset) taken from a given collection of transactions contains all items of this itemset (self)"
	| transactionsThatIncludeThisItemset |
	
	transactionsThatIncludeThisItemset := transactions select: [ :eachItemset |
		eachItemset isSupersetOf: self ].
	
	^ transactionsThatIncludeThisItemset size / transactions size
]
