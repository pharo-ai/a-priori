Class {
	#name : #APrioriEncoder,
	#superclass : #Object,
	#category : #APriori
}

{ #category : #'as yet unclassified' }
APrioriEncoder class >> basedOn: transactions [ 
	^ super new initializeTransactions: transactions.
]

{ #category : #'as yet unclassified' }
APrioriEncoder class >> new [
	self shouldNotImplement
]

{ #category : #initialization }
APrioriEncoder >> decodeItem: anObject [
	self subclassResponsibility
]

{ #category : #converting }
APrioriEncoder >> decodeItemset: itemset [
	^ itemset collect: [ :item |
		self decodeItem: item ].
]

{ #category : #converting }
APrioriEncoder >> decodeItemsets: aCollectionOfItemsets [
	^ aCollectionOfItemsets collect: [ :itemset |
		self decodeItemset: itemset ].
]

{ #category : #converting }
APrioriEncoder >> decodeRule: rule [
	"Decode an association rule by decoding its left and right hand side itemsets"
	^ (self decodeItemset: rule key) -> (self decodeItemset: rule value).
]

{ #category : #converting }
APrioriEncoder >> decodeRules: aCollectionOfRules [
	^ aCollectionOfRules collect: [ :rule |
		self decodeRule: rule ].
]

{ #category : #initialization }
APrioriEncoder >> encodeItem: anObject [
	self subclassResponsibility
]

{ #category : #converting }
APrioriEncoder >> encodeItemset: itemset [
	^ itemset collect: [ :item |
		self encodeItem: item ].
]

{ #category : #converting }
APrioriEncoder >> encodeItemsets: aCollectionOfItemsets [
	^ aCollectionOfItemsets collect: [ :itemset |
		self encodeItemset: itemset ].
]

{ #category : #converting }
APrioriEncoder >> encodeRule: rule [
	"Encode an association rule by encoding its left and right hand side itemsets"
	^ (self encodeItemset: rule key) -> (self encodeItemset: rule value).
]

{ #category : #converting }
APrioriEncoder >> encodeRules: aCollectionOfRules [
	^ aCollectionOfRules collect: [ :rule |
		self encodeRule: rule ].
]

{ #category : #initialization }
APrioriEncoder >> initializeTransactions: transactions [
	self subclassResponsibility.
]
