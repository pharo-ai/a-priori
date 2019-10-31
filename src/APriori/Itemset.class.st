Class {
	#name : #Itemset,
	#superclass : #Array,
	#type : #variable,
	#instVars : [
		'count',
		'support'
	],
	#category : #APriori
}

{ #category : #'instance creation' }
Itemset class >> withAll: aCollection [
	| itemset |
	itemset := super withAll: aCollection.
	itemset sort.
	^ itemset.
]

{ #category : #comparing }
Itemset >> = anObject [
	(super = anObject)
		ifFalse: [ ^ false ].
		
	(self count = anObject count)
		ifFalse: [ ^ false ].
	
	(self support = anObject support)
		ifFalse: [ ^ false ].
		
	^ true
]

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
	^ (self combinations copyWithout: (self asArray)) collect: #asItemset
]

{ #category : #converting }
Itemset >> asArray [ 
	^ Array withAll: self
]

{ #category : #testing }
Itemset >> canBeJoinedWith: anotherItemset [
	| itemset1WithoutLast itemset2WithoutLast |
	
	itemset1WithoutLast := self copyFrom: 1 to: self size - 1.
	itemset2WithoutLast := anotherItemset copyFrom: 1 to: anotherItemset size - 1.
	
	^ (itemset1WithoutLast = itemset2WithoutLast) and: (self last < anotherItemset last).
	
]

{ #category : #accessing }
Itemset >> count [
	^ count
]

{ #category : #accessing }
Itemset >> count: anObject [
	count := anObject
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
	
	^ (OrderedCollection
		withAll: itemsetWithoutLast)
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

{ #category : #accessing }
Itemset >> support [
	^ support
]

{ #category : #accessing }
Itemset >> support: anObject [
	support := anObject
]
