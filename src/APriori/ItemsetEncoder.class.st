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
	^ itemset collect: [ :i |
		vocabulary at: i ].
]

{ #category : #converting }
ItemsetEncoder >> decodeRule: rule [
	^ (self decodeItemset: rule key) => (self decodeItemset: rule value)
]

{ #category : #converting }
ItemsetEncoder >> encodeItemset: itemset [
	^ itemset collect: [ :item |
		vocabulary indexOf: item ].
]

{ #category : #initialization }
ItemsetEncoder >> initializeTransactions: transactions [
	vocabulary := (transactions flatCollect: #yourself) asSet asArray.
	^ self
]
