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

{ #category : #testing }
Itemset >> canBeJoinedWith: anotherItemset [
	| itemset1 itemset2 itemset1WithoutLast itemset2WithoutLast |
	
	itemset1 := self asOrderedCollection.
	itemset2 := anotherItemset asOrderedCollection.
	
	itemset1WithoutLast := itemset1 copyFrom: 1 to: itemset1 size - 1.
	itemset2WithoutLast := itemset2 copyFrom: 1 to: itemset2 size - 1.
	
	^ (itemset1WithoutLast = itemset2WithoutLast) and: (itemset1 last < itemset2 last).
	
]

{ #category : #'as yet unclassified' }
Itemset >> isSupersetOf: anotherItemset [
	"Check if all items of another itemset are included in this itemset"
	anotherItemset
		detect: [ :each | (self includes: each) not ]
		ifFound: [ ^ false ].
		
	^ true
]

{ #category : #testing }
Itemset >> joinWith: anotherItemset [
	| itemset1 itemset2 itemsetWithoutLast |
	
	itemset1 := self asOrderedCollection.
	itemset2 := anotherItemset asOrderedCollection.
	
	itemsetWithoutLast := itemset1 copyFrom: 1 to: itemset1 size - 1.
	
	^ itemsetWithoutLast
		add: itemset1 last;
		add: itemset2 last;
		asItemset.
	
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
