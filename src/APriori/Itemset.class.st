"
I am a model of an itemset - a set of items that may appear in transactions.

I store the set of items, I know my count and support:

* count - number of transactions that contain all of my items
* support - probability that a randomly chosen transaction will contain all of my items

I am used by the APriori algorithm to find frequent itemsets and generate association rules. I am also part of an AssociationRule, whose key and value are my instances.

You should only use the following two messages to ask for my count and support. All other messages are used by the Apriori algorithm.

- count  
- support 

Here is an example of how you can create my instances:

itemset := #(bread butter) asItemset.

I am printed as a set of my items:

'{bread, butter}'
 
You can use my => message to create instances of AssociationRule:

rule := #(bread butter) asItemset => #(avocado) asItemset.

I am implemented on top of an Array and not Set because the order of my items matters and it is very important that they can be accessed quickly.
"
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
	"Itemset inherits from Array, so we override the equality operation to test not only the equality of the items, but also the count and support"
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
	"An opeartor for creating an association rule.
	
	Example:
	#(a b c) asItemset => #(d e) asItemset.
	
	This will produce an association rule {a, b, c} => {d, e}"
	
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
Itemset >> allLargestSubsets [
	"Generate all subsets of size k-1
	Example:
	{1, 2, 3} => {1, 2}, {1, 3}, {2, 3}"
	^ self collect: [ :item |
		self copyWithout: item ].
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
	"Test if this itemset (self) can be joined with anotherItemset. For that the two itemsets of size k must share the first k-1 elements and the last element of anotherItemset must be greater than the last element of self"
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
	^ self includesAll: anotherItemset
]

{ #category : #testing }
Itemset >> joinWith: anotherItemset [
	"Join yourself with another itemset. This operation should only be performed after we test that two itemsets can be joined (see canBeJoinedWith:). This means that two itemsets of size k have the same first k-1 elements and the last element of anotherItemset is greater than the last element of self. We join them by creating an itemset of size k+1 where first k-1 elements are the same as in self (or anotherItemset), element k is the last element of self, and element k+1 is the last element of anotherItemset (this way, the elements of a new itemset are sorted in ascending order)"
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
