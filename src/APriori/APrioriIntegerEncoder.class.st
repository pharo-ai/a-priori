Class {
	#name : #APrioriIntegerEncoder,
	#superclass : #APrioriEncoder,
	#instVars : [
		'vocabulary'
	],
	#category : #APriori
}

{ #category : #initialization }
APrioriIntegerEncoder >> decodeItem: aNumber [
	^ vocabulary at: aNumber
]

{ #category : #initialization }
APrioriIntegerEncoder >> encodeItem: anObject [
	^ vocabulary indexOf: anObject
]

{ #category : #initialization }
APrioriIntegerEncoder >> initializeTransactions: transactions [
	"When encoder is initialized with transactions, it saves unique items into vocabulary. Then it can encode each item by replacing it with its integer index in the vocabulary and decode it by finding the item in the vocabulary by its index"
	| items |
	items := transactions flatCollect: #yourself.
	
	"We could write items asSet, but we want to keep the order in which items appear"
	vocabulary := OrderedCollection new.
	
	items do: [ :each |
		(vocabulary includes: each) ifFalse: [ 
			vocabulary add: each ] ].
]
