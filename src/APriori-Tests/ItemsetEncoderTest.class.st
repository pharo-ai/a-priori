Class {
	#name : #ItemsetEncoderTest,
	#superclass : #TestCase,
	#instVars : [
		'transactions',
		'encoder'
	],
	#category : #'APriori-Tests'
}

{ #category : #running }
ItemsetEncoderTest >> setUp [ 
	super setUp.
	transactions := APrioriMockTransactions new transactions.
	encoder := ItemsetEncoder basedOn: transactions.
]

{ #category : #tests }
ItemsetEncoderTest >> testDecodeItemset [
	| itemset expected actual |
	itemset := #(2 5) asItemset.
	expected := #(bread butter) asItemset.
	actual := encoder decodeItemset: itemset.
	self assert: actual equals: expected.
]

{ #category : #tests }
ItemsetEncoderTest >> testDecodeRule [
	| rule expected actual |
	rule := #(2) asItemset => #(5) asItemset.
	expected := #(bread) asItemset => #(butter) asItemset.
	actual := encoder decodeRule: rule.
	self assert: actual equals: expected.
]

{ #category : #tests }
ItemsetEncoderTest >> testEncodeItemset [
	| itemset expected actual |
	itemset := #(bread butter) asItemset.
	expected := #(2 5) asItemset.
	actual := encoder encodeItemset: itemset.
	self assert: actual equals: expected.
]
