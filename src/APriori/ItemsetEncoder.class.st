Class {
	#name : #ItemsetEncoder,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'vocabulary'
	],
	#category : #APriori
}

{ #category : #'as yet unclassified' }
ItemsetEncoder class >> basedOn: transactions [ 
	^ super new initializeTransactions: transactions.
]

{ #category : #'as yet unclassified' }
ItemsetEncoder class >> new [
	self shouldNotImplement
]

{ #category : #converting }
ItemsetEncoder >> decodeItemset: itemset [
	"Decode an integer itemset by replacing integers with the corresponding items from the vocabulary (found by index). Return the decoded itemset. This operation preserves the count and support of an itemset"
	| decodedItemset |
	
	decodedItemset := itemset collect: [ :i |
		vocabulary at: i ].
	
	decodedItemset count: itemset count.
	decodedItemset support: itemset support.
	
	^ decodedItemset
]

{ #category : #converting }
ItemsetEncoder >> decodeRule: rule [
	"Decode an association rule by decoding its left and right hand side itemsets. Return the decoded rule. This operation preserves the count, support, confidence, and lift of an association rule"
	| decodedRule |
	
	decodedRule := ((self decodeItemset: rule key) => (self decodeItemset: rule value)).
		
	decodedRule
		count: rule count;
		support: rule support;
		confidence: rule confidence;
		lift: rule lift.
		
	^ decodedRule
]

{ #category : #converting }
ItemsetEncoder >> encodeItemset: itemset [
	"Encode itemset by replacing all its items with their indices in the vocabulary. Returt the encoded itemset with integers. This operation preserves the count and support of an itemset"
	| encodedItemset |
	
	encodedItemset := itemset collect: [ :item |
		vocabulary indexOf: item ].
	
	encodedItemset count: itemset count.
	encodedItemset support: itemset support.
	
	^ encodedItemset
]

{ #category : #converting }
ItemsetEncoder >> encodeRule: rule [
	"Encode an association rule by encoding its left and right hand side itemsets. Return the encoded rule. This operation preserves the count, support, confidence, and lift of an association rule"
	| encodedRule |
	
	encodedRule := ((self encodeItemset: rule key) => (self encodeItemset: rule value)).
		
	encodedRule
		count: rule count;
		support: rule support;
		confidence: rule confidence;
		lift: rule lift.
		
	^ encodedRule
]

{ #category : #initialization }
ItemsetEncoder >> initializeTransactions: transactions [
	"When encoder is initialized with transactions, it saves unique items into vocabulary. Then it can encode each item by replacing it with its integer index in the vocabulary and decode it by finding the item in the vocabulary by its index"
	vocabulary := (transactions flatCollect: #yourself) asSet asArray.
	^ self
]
