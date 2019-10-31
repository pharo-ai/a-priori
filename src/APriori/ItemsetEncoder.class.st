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
	| decodedItemset |
	
	decodedItemset := itemset collect: [ :i |
		vocabulary at: i ].
	
	decodedItemset count: itemset count.
	decodedItemset support: itemset support.
	
	^ decodedItemset
]

{ #category : #converting }
ItemsetEncoder >> decodeRule: rule [
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
	| encodedItemset |
	
	encodedItemset := itemset collect: [ :item |
		vocabulary indexOf: item ].
	
	encodedItemset count: itemset count.
	encodedItemset support: itemset support.
	
	^ encodedItemset
]

{ #category : #converting }
ItemsetEncoder >> encodeRule: rule [
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
	vocabulary := (transactions flatCollect: #yourself) asSet asArray.
	^ self
]
