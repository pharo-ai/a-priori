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
ItemsetEncoderTest >> testDecodeItemsetCountSupport [
	| itemset decoded |
	
	itemset := #(2 5) asItemset
		count: 10;
		support: 0.1;
		yourself.
	
	decoded := encoder decodeItemset: itemset.
	
	self assert: decoded count equals: 10.
	self assert: decoded support equals: 0.1.
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
ItemsetEncoderTest >> testDecodeRuleCountSupportConfidenceLift [
	| rule decoded |
	
	rule := (#(2) asItemset => #(5) asItemset)
		count: 10;
		support: 0.1;
		confidence: 0.5;
		lift: 2;
		yourself.
	
	decoded := encoder decodeRule: rule.
	
	self assert: decoded count equals: 10.
	self assert: decoded support equals: 0.1.
	self assert: decoded confidence equals: 0.5.
	self assert: decoded lift equals: 2.
]

{ #category : #tests }
ItemsetEncoderTest >> testDecodeRuleKeyCountSupport [
	| itemset1 itemset2 rule decoded |
	
	itemset1 := #(2) asItemset
		count: 10;
		support: 0.1;
		yourself.
		
	itemset2 := #(5) asItemset.
	rule := itemset1 => itemset2.
	
	decoded := encoder decodeRule: rule.
	
	self assert: decoded key count equals: 10.
	self assert: decoded key support equals: 0.1.
]

{ #category : #tests }
ItemsetEncoderTest >> testDecodeRuleValueCountSupport [
	| itemset1 itemset2 rule decoded |
	
	itemset1 := #(2) asItemset.
		
	itemset2 := #(5) asItemset
		count: 10;
		support: 0.1;
		yourself.
		
	rule := itemset1 => itemset2.
	
	decoded := encoder decodeRule: rule.
	
	self assert: decoded value count equals: 10.
	self assert: decoded value support equals: 0.1.
]

{ #category : #tests }
ItemsetEncoderTest >> testEncodeItemset [
	| itemset expected actual |
	itemset := #(bread butter) asItemset.
	expected := #(2 5) asItemset.
	actual := encoder encodeItemset: itemset.
	self assert: actual equals: expected.
]

{ #category : #tests }
ItemsetEncoderTest >> testEncodeItemsetCountSupport [
	| itemset encoded |
	
	itemset := #(bread butter) asItemset
		count: 10;
		support: 0.1;
		yourself.
	
	encoded := encoder encodeItemset: itemset.
	
	self assert: encoded count equals: 10.
	self assert: encoded support equals: 0.1.
]
