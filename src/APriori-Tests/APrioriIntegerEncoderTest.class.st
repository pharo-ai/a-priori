"
I am a copy of class ItemsetEncoderTest. This comment is copied from there, and might not be entirely accurate

This class contains tests
"
Class {
	#name : #APrioriIntegerEncoderTest,
	#superclass : #TestCase,
	#instVars : [
		'transactions',
		'encoder'
	],
	#category : #'APriori-Tests'
}

{ #category : #running }
APrioriIntegerEncoderTest >> setUp [ 
	super setUp.
	transactions := APrioriMockTransactions new transactions.
	encoder := APrioriIntegerEncoder basedOn: transactions.
]

{ #category : #tests }
APrioriIntegerEncoderTest >> testDecodeItemset [
	| itemset expected actual |
	itemset := #(3 6) asItemset.
	expected := #(butter bread) asItemset.
	actual := encoder decodeItemset: itemset.
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriIntegerEncoderTest >> testDecodeItemsetCountSupport [
	| itemset decoded |
	
	itemset := #(3 6) asItemset
		count: 10;
		support: 0.1;
		yourself.
	
	decoded := encoder decodeItemset: itemset.
	
	self assert: decoded count equals: 10.
	self assert: decoded support equals: 0.1.
]

{ #category : #tests }
APrioriIntegerEncoderTest >> testDecodeItemsets [
	| itemsets expected actual |
	itemsets := {
		#(3 6) asItemset .
		#(2 4) asItemset }.
	expected := {
		#(butter bread) asItemset .
		#(milk cereal) asItemset }.
	actual := encoder decodeItemsets: itemsets.
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriIntegerEncoderTest >> testDecodeRule [
	| rule expected actual |
	rule := #(3) asItemset => #(6) asItemset.
	expected := #(butter) asItemset => #(bread) asItemset.
	actual := encoder decodeRule: rule.
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriIntegerEncoderTest >> testDecodeRuleCountSupportConfidenceLift [
	| rule decoded |
	
	rule := (#(3) asItemset => #(6) asItemset)
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
APrioriIntegerEncoderTest >> testDecodeRuleKeyCountSupport [
	| itemset1 itemset2 rule decoded |
	
	itemset1 := #(3) asItemset
		count: 10;
		support: 0.1;
		yourself.
		
	itemset2 := #(6) asItemset.
	rule := itemset1 => itemset2.
	
	decoded := encoder decodeRule: rule.
	
	self assert: decoded key count equals: 10.
	self assert: decoded key support equals: 0.1.
]

{ #category : #tests }
APrioriIntegerEncoderTest >> testDecodeRuleValueCountSupport [
	| itemset1 itemset2 rule decoded |
	
	itemset1 := #(3) asItemset.
		
	itemset2 := #(6) asItemset
		count: 10;
		support: 0.1;
		yourself.
		
	rule := itemset1 => itemset2.
	
	decoded := encoder decodeRule: rule.
	
	self assert: decoded value count equals: 10.
	self assert: decoded value support equals: 0.1.
]

{ #category : #tests }
APrioriIntegerEncoderTest >> testEncodeItemset [
	| itemset expected actual |
	itemset := #(butter bread) asItemset.
	expected := #(3 6) asItemset.
	actual := encoder encodeItemset: itemset.
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriIntegerEncoderTest >> testEncodeItemsetCountSupport [
	| itemset encoded |
	
	itemset := #(butter bread) asItemset
		count: 10;
		support: 0.1;
		yourself.
	
	encoded := encoder encodeItemset: itemset.
	
	self assert: encoded count equals: 10.
	self assert: encoded support equals: 0.1.
]

{ #category : #tests }
APrioriIntegerEncoderTest >> testEncodeRule [
	| rule expected actual |
	rule := #(butter) asItemset => #(bread) asItemset.
	expected := #(3) asItemset => #(6) asItemset.
	actual := encoder encodeRule: rule.
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriIntegerEncoderTest >> testEncodeRuleCountSupportConfidenceLift [
	| rule encoded |
	
	rule := (#(butter) asItemset => #(bread) asItemset)
		count: 10;
		support: 0.1;
		confidence: 0.5;
		lift: 2;
		yourself.
	
	encoded := encoder encodeRule: rule.
	
	self assert: encoded count equals: 10.
	self assert: encoded support equals: 0.1.
	self assert: encoded confidence equals: 0.5.
	self assert: encoded lift equals: 2.
]

{ #category : #tests }
APrioriIntegerEncoderTest >> testEncodeRuleKeyCountSupport [
	| itemset1 itemset2 rule encoded |
	
	itemset1 := #(butter) asItemset
		count: 10;
		support: 0.1;
		yourself.
		
	itemset2 := #(bread) asItemset.
	rule := itemset1 => itemset2.
	
	encoded := encoder encodeRule: rule.
	
	self assert: encoded key count equals: 10.
	self assert: encoded key support equals: 0.1.
]

{ #category : #tests }
APrioriIntegerEncoderTest >> testEncodeRuleValueCountSupport [
	| itemset1 itemset2 rule encoded |
	
	itemset1 := #(butter) asItemset.
		
	itemset2 := #(bread) asItemset
		count: 10;
		support: 0.1;
		yourself.
		
	rule := itemset1 => itemset2.
	
	encoded := encoder encodeRule: rule.
	
	self assert: encoded value count equals: 10.
	self assert: encoded value support equals: 0.1.
]
