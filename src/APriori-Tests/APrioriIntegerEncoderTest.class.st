"
I am a copy of class ItemsetEncoderTest. This comment is copied from there, and might not be entirely accurate

This class contains tests
"
Class {
	#name : #APrioriIntegerEncoderTest,
	#superclass : #TestCase,
	#instVars : [
		'encoder'
	],
	#category : #'APriori-Tests'
}

{ #category : #running }
APrioriIntegerEncoderTest >> setUp [ 
	| transactions |
	super setUp.
	transactions := APrioriMockTransactions new transactions.
	encoder := APrioriIntegerEncoder basedOn: transactions.
]

{ #category : #tests }
APrioriIntegerEncoderTest >> testDecodeItem [
	| item expected actual |
	item := 6.
	
	expected := #bread.
	actual := encoder decodeItem: item.
	
	self assert: actual equals: expected.
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
APrioriIntegerEncoderTest >> testDecodeItemsetAlgorithm [
	| apriori itemset expected actual |
	
	apriori := APriori new.
	itemset := #(3 6) asItemset.
	itemset algorithm: apriori.
	
	expected := #(butter bread) asItemset.
	expected algorithm: apriori.
	
	actual := encoder decodeItemset: itemset.
	self assert: (actual =!= expected).
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
APrioriIntegerEncoderTest >> testDecodeRuleAlgorithm [
	| apriori itemset1 itemset2 rule expected actual |
	
	itemset1 := #(3) asItemset.
	itemset2 := #(6) asItemset.
	rule := itemset1 => itemset2.
	
	apriori := APriori new.
	itemset1 algorithm: apriori.
	itemset2 algorithm: apriori.
	rule algorithm: apriori.
	
	itemset1 := #(butter) asItemset.
	itemset2 := #(bread) asItemset.
	expected := itemset1 => itemset2.
	
	itemset1 algorithm: apriori.
	itemset2 algorithm: apriori.
	expected algorithm: apriori.
	
	actual := encoder decodeRule: rule.
	self assert: (actual =!= expected).
]

{ #category : #tests }
APrioriIntegerEncoderTest >> testDecodeRules [
	| rules expected actual |
	
	rules := {
		#(3) asItemset => #(6) asItemset .
		#(1) asItemset => #(5) asItemset }.
		
	expected := {
		#(butter) asItemset => #(bread) asItemset .
		#(eggs) asItemset => #(bacon) asItemset }.
		
	actual := encoder decodeRules: rules.
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriIntegerEncoderTest >> testEncodeItem [
	| item expected actual |
	item := #bread.
	
	expected := 6.
	actual := encoder encodeItem: item.
	
	self assert: actual equals: expected.
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
APrioriIntegerEncoderTest >> testEncodeItemsetAlgorithm [
	| apriori itemset expected actual |
	
	apriori := APriori new.
	itemset := #(butter bread) asItemset.
	itemset algorithm: apriori.
	
	expected := #(3 6) asItemset.
	expected algorithm: apriori.
	
	actual := encoder encodeItemset: itemset.
	self assert: (actual =!= expected).
]

{ #category : #tests }
APrioriIntegerEncoderTest >> testEncodeItemsets [
	| itemsets expected actual |
	itemsets := {
		#(butter bread) asItemset .
		#(milk cereal) asItemset }.
	expected := {
		#(3 6) asItemset .
		#(2 4) asItemset }.
	actual := encoder encodeItemsets: itemsets.
	self assert: actual equals: expected.
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
APrioriIntegerEncoderTest >> testEncodeRuleAlgorithm [
	| apriori itemset1 itemset2 rule expected actual |
	
	itemset1 := #(butter) asItemset.
	itemset2 := #(bread) asItemset.
	rule := itemset1 => itemset2.
	
	apriori := APriori new.
	itemset1 algorithm: apriori.
	itemset2 algorithm: apriori.
	rule algorithm: apriori.
	
	itemset1 := #(3) asItemset.
	itemset2 := #(6) asItemset.
	expected := itemset1 => itemset2.
	
	itemset1 algorithm: apriori.
	itemset2 algorithm: apriori.
	expected algorithm: apriori.
	
	actual := encoder encodeRule: rule.
	self assert: (actual =!= expected).
]

{ #category : #tests }
APrioriIntegerEncoderTest >> testEncodeRules [
	| rules expected actual |
	
	rules := {
		#(butter) asItemset => #(bread) asItemset .
		#(eggs) asItemset => #(bacon) asItemset }.
		
	expected := {
		#(3) asItemset => #(6) asItemset .
		#(1) asItemset => #(5) asItemset }.
		
	actual := encoder encodeRules: rules.
	self assert: actual equals: expected.
]
