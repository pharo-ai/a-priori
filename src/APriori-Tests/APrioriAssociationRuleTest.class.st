Class {
	#name : #APrioriAssociationRuleTest,
	#superclass : #TestCase,
	#category : #'APriori-Tests'
}

{ #category : #tests }
APrioriAssociationRuleTest >> testAsAssociationRule [
	| keyItemset valueItemset rule |
	
	keyItemset := #(a b) asItemset.
	valueItemset := #(c e d) asItemset.
	
	rule := (keyItemset -> valueItemset) asAssociationRule.
	
	self assert: rule class equals: APrioriAssociationRule.
	self assert: rule key equals: keyItemset.
	self assert: rule value equals: valueItemset.
]

{ #category : #tests }
APrioriAssociationRuleTest >> testCreateFromItemsets [
	| keyItemset valueItemset rule |
	
	keyItemset := #(a b) asItemset.
	valueItemset := #(c e d) asItemset.
	
	rule := keyItemset => valueItemset.
	
	self assert: rule class equals: APrioriAssociationRule.
	self assert: rule key equals: keyItemset.
	self assert: rule value equals: valueItemset.
]

{ #category : #tests }
APrioriAssociationRuleTest >> testEqualityDifferentElementsSameMetrics [
	| keyItemset1 valueItemset1 keyItemset2 valueItemset2 rule1 rule2 |
	
	keyItemset1 := #(a c b) asItemset.
	keyItemset1 metricsValues at: APrioriCountMetric put: 10.
	keyItemset1 metricsValues at: APrioriSupportMetric put: 0.5.
	
	valueItemset1 := #(f d) asItemset.
	valueItemset1 metricsValues at: APrioriCountMetric put: 20.
	valueItemset1 metricsValues at: APrioriSupportMetric put: 0.7.
	
	keyItemset2 := #(a c b) asItemset.
	keyItemset2 metricsValues at: APrioriCountMetric put: 10.
	keyItemset2 metricsValues at: APrioriSupportMetric put: 0.5.
	
	valueItemset2 := #(w x y z) asItemset.
	valueItemset2 metricsValues at: APrioriCountMetric put: 20.
	valueItemset2 metricsValues at: APrioriSupportMetric put: 0.7.
	
	rule1 := keyItemset1 => valueItemset1.
	rule1 metricsValues at: APrioriCountMetric put: 30.
	rule1 metricsValues at: APrioriSupportMetric put: 0.4.
	rule1 metricsValues at: APrioriConfidenceMetric put: 0.7.
	rule1 metricsValues at: APrioriLiftMetric put: 0.9.
	
	rule2 := keyItemset2 => valueItemset2.
	rule2 metricsValues at: APrioriCountMetric put: 30.
	rule2 metricsValues at: APrioriSupportMetric put: 0.4.
	rule2 metricsValues at: APrioriConfidenceMetric put: 0.7.
	rule2 metricsValues at: APrioriLiftMetric put: 0.9.
	
	self deny: rule1 equals: rule2.
]

{ #category : #tests }
APrioriAssociationRuleTest >> testEqualitySameElementsDifferentKeyMetrics [
	| keyItemset1 valueItemset1 keyItemset2 valueItemset2 rule1 rule2 |
	
	keyItemset1 := #(a c b) asItemset.
	keyItemset1 metricsValues at: APrioriCountMetric put: 10.
	keyItemset1 metricsValues at: APrioriSupportMetric put: 0.5.
	
	valueItemset1 := #(f d) asItemset.
	valueItemset1 metricsValues at: APrioriCountMetric put: 20.
	valueItemset1 metricsValues at: APrioriSupportMetric put: 0.7.
	
	keyItemset2 := #(a c b) asItemset.
	keyItemset2 metricsValues at: APrioriCountMetric put: 42.
	keyItemset2 metricsValues at: APrioriSupportMetric put: 0.3.
	
	valueItemset2 := #(f d) asItemset.
	valueItemset2 metricsValues at: APrioriCountMetric put: 20.
	valueItemset2 metricsValues at: APrioriSupportMetric put: 0.7.
	
	rule1 := keyItemset1 => valueItemset1.
	rule1 metricsValues at: APrioriCountMetric put: 30.
	rule1 metricsValues at: APrioriSupportMetric put: 0.4.
	rule1 metricsValues at: APrioriConfidenceMetric put: 0.7.
	rule1 metricsValues at: APrioriLiftMetric put: 0.9.
	
	rule2 := keyItemset2 => valueItemset2.
	rule2 metricsValues at: APrioriCountMetric put: 30.
	rule2 metricsValues at: APrioriSupportMetric put: 0.4.
	rule2 metricsValues at: APrioriConfidenceMetric put: 0.7.
	rule2 metricsValues at: APrioriLiftMetric put: 0.9.
	
	self assert: rule1 equals: rule2.
]

{ #category : #tests }
APrioriAssociationRuleTest >> testEqualitySameElementsDifferentMetrics [
	| keyItemset1 valueItemset1 keyItemset2 valueItemset2 rule1 rule2 |
	
	keyItemset1 := #(a c b) asItemset.
	keyItemset1 metricsValues at: APrioriCountMetric put: 10.
	keyItemset1 metricsValues at: APrioriSupportMetric put: 0.5.
	
	valueItemset1 := #(f d) asItemset.
	valueItemset1 metricsValues at: APrioriCountMetric put: 20.
	valueItemset1 metricsValues at: APrioriSupportMetric put: 0.7.
	
	keyItemset2 := #(a c b) asItemset.
	keyItemset2 metricsValues at: APrioriCountMetric put: 10.
	keyItemset2 metricsValues at: APrioriSupportMetric put: 0.5.
	
	valueItemset2 := #(f d) asItemset.
	valueItemset2 metricsValues at: APrioriCountMetric put: 20.
	valueItemset2 metricsValues at: APrioriSupportMetric put: 0.7.
	
	rule1 := keyItemset1 => valueItemset1.
	rule1 metricsValues at: APrioriCountMetric put: 30.
	rule1 metricsValues at: APrioriSupportMetric put: 0.4.
	rule1 metricsValues at: APrioriConfidenceMetric put: 0.7.
	rule1 metricsValues at: APrioriLiftMetric put: 0.9.
	
	rule2 := keyItemset2 => valueItemset2.
	rule2 metricsValues at: APrioriCountMetric put: 42.
	rule2 metricsValues at: APrioriSupportMetric put: 0.
	rule2 metricsValues at: APrioriConfidenceMetric put: 0.
	rule2 metricsValues at: APrioriLiftMetric put: 0.
	
	self assert: rule1 equals: rule2.
]

{ #category : #tests }
APrioriAssociationRuleTest >> testEqualitySameElementsDifferentOrderSameMetrics [
	| keyItemset1 valueItemset1 keyItemset2 valueItemset2 rule1 rule2 |
	
	keyItemset1 := #(a c b) asItemset.
	keyItemset1 metricsValues at: APrioriCountMetric put: 10.
	keyItemset1 metricsValues at: APrioriSupportMetric put: 0.5.
	
	valueItemset1 := #(f d) asItemset.
	valueItemset1 metricsValues at: APrioriCountMetric put: 20.
	valueItemset1 metricsValues at: APrioriSupportMetric put: 0.7.
	
	keyItemset2 := #(a c b) asItemset.
	keyItemset2 metricsValues at: APrioriCountMetric put: 10.
	keyItemset2 metricsValues at: APrioriSupportMetric put: 0.5.
	
	valueItemset2 := #(d f) asItemset.
	valueItemset2 metricsValues at: APrioriCountMetric put: 20.
	valueItemset2 metricsValues at: APrioriSupportMetric put: 0.7.
	
	rule1 := keyItemset1 => valueItemset1.
	rule1 metricsValues at: APrioriCountMetric put: 30.
	rule1 metricsValues at: APrioriSupportMetric put: 0.4.
	rule1 metricsValues at: APrioriConfidenceMetric put: 0.7.
	rule1 metricsValues at: APrioriLiftMetric put: 0.9.
	
	rule2 := keyItemset2 => valueItemset2.
	rule2 metricsValues at: APrioriCountMetric put: 30.
	rule2 metricsValues at: APrioriSupportMetric put: 0.4.
	rule2 metricsValues at: APrioriConfidenceMetric put: 0.7.
	rule2 metricsValues at: APrioriLiftMetric put: 0.9.
	
	self deny: rule1 equals: rule2.
]

{ #category : #tests }
APrioriAssociationRuleTest >> testEqualitySameElementsDifferentValueMetrics [
	| keyItemset1 valueItemset1 keyItemset2 valueItemset2 rule1 rule2 |
	
	keyItemset1 := #(a c b) asItemset.
	keyItemset1 metricsValues at: APrioriCountMetric put: 10.
	keyItemset1 metricsValues at: APrioriSupportMetric put: 0.5.
	
	valueItemset1 := #(f d) asItemset.
	valueItemset1 metricsValues at: APrioriCountMetric put: 20.
	valueItemset1 metricsValues at: APrioriSupportMetric put: 0.7.
	
	keyItemset2 := #(a c b) asItemset.
	keyItemset2 metricsValues at: APrioriCountMetric put: 10.
	keyItemset2 metricsValues at: APrioriSupportMetric put: 0.5.
	
	valueItemset2 := #(f d) asItemset.
	valueItemset2 metricsValues at: APrioriCountMetric put: 42.
	valueItemset2 metricsValues at: APrioriSupportMetric put: 0.3.
	
	rule1 := keyItemset1 => valueItemset1.
	rule1 metricsValues at: APrioriCountMetric put: 30.
	rule1 metricsValues at: APrioriSupportMetric put: 0.4.
	rule1 metricsValues at: APrioriConfidenceMetric put: 0.7.
	rule1 metricsValues at: APrioriLiftMetric put: 0.9.
	
	rule2 := keyItemset2 => valueItemset2.
	rule2 metricsValues at: APrioriCountMetric put: 30.
	rule2 metricsValues at: APrioriSupportMetric put: 0.4.
	rule2 metricsValues at: APrioriConfidenceMetric put: 0.7.
	rule2 metricsValues at: APrioriLiftMetric put: 0.9.
	
	self assert: rule1 equals: rule2.
]

{ #category : #tests }
APrioriAssociationRuleTest >> testEqualitySameElementsSameMetrics [
	| keyItemset1 valueItemset1 keyItemset2 valueItemset2 rule1 rule2 |
	
	keyItemset1 := #(a c b) asItemset.
	keyItemset1 metricsValues at: APrioriCountMetric put: 10.
	keyItemset1 metricsValues at: APrioriSupportMetric put: 0.5.
	
	valueItemset1 := #(f d) asItemset.
	valueItemset1 metricsValues at: APrioriCountMetric put: 20.
	valueItemset1 metricsValues at: APrioriSupportMetric put: 0.7.
	
	keyItemset2 := #(a c b) asItemset.
	keyItemset2 metricsValues at: APrioriCountMetric put: 10.
	keyItemset2 metricsValues at: APrioriSupportMetric put: 0.5.
	
	valueItemset2 := #(f d) asItemset.
	valueItemset2 metricsValues at: APrioriCountMetric put: 20.
	valueItemset2 metricsValues at: APrioriSupportMetric put: 0.7.
	
	rule1 := keyItemset1 => valueItemset1.
	rule1 metricsValues at: APrioriCountMetric put: 30.
	rule1 metricsValues at: APrioriSupportMetric put: 0.4.
	rule1 metricsValues at: APrioriConfidenceMetric put: 0.7.
	rule1 metricsValues at: APrioriLiftMetric put: 0.9.
	
	rule2 := keyItemset2 => valueItemset2.
	rule2 metricsValues at: APrioriCountMetric put: 30.
	rule2 metricsValues at: APrioriSupportMetric put: 0.4.
	rule2 metricsValues at: APrioriConfidenceMetric put: 0.7.
	rule2 metricsValues at: APrioriLiftMetric put: 0.9.
	
	self assert: rule1 equals: rule2.
]

{ #category : #tests }
APrioriAssociationRuleTest >> testKeyItemset [
	| keyItemset valueItemset rule |
	
	keyItemset := #(a b) asItemset.
	valueItemset := #(c e d) asItemset.
	
	rule := keyItemset => valueItemset.
	self assert: rule keyItemset equals: keyItemset.
]

{ #category : #tests }
APrioriAssociationRuleTest >> testParentItemset [
	| keyItemset valueItemset parentItemset rule |
	
	keyItemset := #(a b) asItemset.
	valueItemset := #(c e d) asItemset.
	parentItemset := #(a b c e d) asItemset.
	
	rule := keyItemset => valueItemset.
	rule parentItemset: parentItemset.
	
	self assert: rule parentItemset equals: parentItemset.
]

{ #category : #tests }
APrioriAssociationRuleTest >> testPrintOn [ 
	| keyItemset valueItemset rule stream expected actual |
	
	keyItemset := #(eggs milk butter) asItemset.
	valueItemset := #(avocado bananas) asItemset.
	rule := keyItemset => valueItemset.
	
	stream := String new writeStream.
	rule printOn: stream.
	
	expected := '{eggs, milk, butter} => {avocado, bananas}'.
	actual := stream contents.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriAssociationRuleTest >> testStrongEqualityDifferentElementsSameMetrics [
	| keyItemset1 valueItemset1 keyItemset2 valueItemset2 rule1 rule2 |
	
	keyItemset1 := #(a c b) asItemset.
	keyItemset1 metricsValues at: APrioriCountMetric put: 10.
	keyItemset1 metricsValues at: APrioriSupportMetric put: 0.5.
	
	valueItemset1 := #(f d) asItemset.
	valueItemset1 metricsValues at: APrioriCountMetric put: 20.
	valueItemset1 metricsValues at: APrioriSupportMetric put: 0.7.
	
	keyItemset2 := #(a c b) asItemset.
	keyItemset2 metricsValues at: APrioriCountMetric put: 10.
	keyItemset2 metricsValues at: APrioriSupportMetric put: 0.5.
	
	valueItemset2 := #(w x y z) asItemset.
	valueItemset2 metricsValues at: APrioriCountMetric put: 20.
	valueItemset2 metricsValues at: APrioriSupportMetric put: 0.7.
	
	rule1 := keyItemset1 => valueItemset1.
	rule1 metricsValues at: APrioriCountMetric put: 30.
	rule1 metricsValues at: APrioriSupportMetric put: 0.4.
	rule1 metricsValues at: APrioriConfidenceMetric put: 0.7.
	rule1 metricsValues at: APrioriLiftMetric put: 0.9.
	
	rule2 := keyItemset2 => valueItemset2.
	rule2 metricsValues at: APrioriCountMetric put: 30.
	rule2 metricsValues at: APrioriSupportMetric put: 0.4.
	rule2 metricsValues at: APrioriConfidenceMetric put: 0.7.
	rule2 metricsValues at: APrioriLiftMetric put: 0.9.
	
	self deny: (rule1 =!= rule2).
]

{ #category : #tests }
APrioriAssociationRuleTest >> testStrongEqualitySameElementsDifferentKeyMetrics [
	| keyItemset1 valueItemset1 keyItemset2 valueItemset2 rule1 rule2 |
	
	keyItemset1 := #(a c b) asItemset.
	keyItemset1 metricsValues at: APrioriCountMetric put: 10.
	keyItemset1 metricsValues at: APrioriSupportMetric put: 0.5.
	
	valueItemset1 := #(f d) asItemset.
	valueItemset1 metricsValues at: APrioriCountMetric put: 20.
	valueItemset1 metricsValues at: APrioriSupportMetric put: 0.7.
	
	keyItemset2 := #(a c b) asItemset.
	keyItemset2 metricsValues at: APrioriCountMetric put: 42.
	keyItemset2 metricsValues at: APrioriSupportMetric put: 0.3.
	
	valueItemset2 := #(f d) asItemset.
	valueItemset2 metricsValues at: APrioriCountMetric put: 20.
	valueItemset2 metricsValues at: APrioriSupportMetric put: 0.7.
	
	rule1 := keyItemset1 => valueItemset1.
	rule1 metricsValues at: APrioriCountMetric put: 30.
	rule1 metricsValues at: APrioriSupportMetric put: 0.4.
	rule1 metricsValues at: APrioriConfidenceMetric put: 0.7.
	rule1 metricsValues at: APrioriLiftMetric put: 0.9.
	
	rule2 := keyItemset2 => valueItemset2.
	rule2 metricsValues at: APrioriCountMetric put: 30.
	rule2 metricsValues at: APrioriSupportMetric put: 0.4.
	rule2 metricsValues at: APrioriConfidenceMetric put: 0.7.
	rule2 metricsValues at: APrioriLiftMetric put: 0.9.
	
	self deny: (rule1 =!= rule2).
]

{ #category : #tests }
APrioriAssociationRuleTest >> testStrongEqualitySameElementsDifferentMetrics [
	| keyItemset1 valueItemset1 keyItemset2 valueItemset2 rule1 rule2 |
	
	keyItemset1 := #(a c b) asItemset.
	keyItemset1 metricsValues at: APrioriCountMetric put: 10.
	keyItemset1 metricsValues at: APrioriSupportMetric put: 0.5.
	
	valueItemset1 := #(f d) asItemset.
	valueItemset1 metricsValues at: APrioriCountMetric put: 20.
	valueItemset1 metricsValues at: APrioriSupportMetric put: 0.7.
	
	keyItemset2 := #(a c b) asItemset.
	keyItemset2 metricsValues at: APrioriCountMetric put: 10.
	keyItemset2 metricsValues at: APrioriSupportMetric put: 0.5.
	
	valueItemset2 := #(f d) asItemset.
	valueItemset2 metricsValues at: APrioriCountMetric put: 20.
	valueItemset2 metricsValues at: APrioriSupportMetric put: 0.7.
	
	rule1 := keyItemset1 => valueItemset1.
	rule1 metricsValues at: APrioriCountMetric put: 30.
	rule1 metricsValues at: APrioriSupportMetric put: 0.4.
	rule1 metricsValues at: APrioriConfidenceMetric put: 0.7.
	rule1 metricsValues at: APrioriLiftMetric put: 0.9.
	
	rule2 := keyItemset2 => valueItemset2.
	rule2 metricsValues at: APrioriCountMetric put: 42.
	rule2 metricsValues at: APrioriSupportMetric put: 0.
	rule2 metricsValues at: APrioriConfidenceMetric put: 0.
	rule2 metricsValues at: APrioriLiftMetric put: 0.
	
	self assert: (rule1 =!= rule2).
]

{ #category : #tests }
APrioriAssociationRuleTest >> testStrongEqualitySameElementsDifferentOrderSameMetrics [
	| keyItemset1 valueItemset1 keyItemset2 valueItemset2 rule1 rule2 |
	
	keyItemset1 := #(a c b) asItemset.
	keyItemset1 metricsValues at: APrioriCountMetric put: 10.
	keyItemset1 metricsValues at: APrioriSupportMetric put: 0.5.
	
	valueItemset1 := #(f d) asItemset.
	valueItemset1 metricsValues at: APrioriCountMetric put: 20.
	valueItemset1 metricsValues at: APrioriSupportMetric put: 0.7.
	
	keyItemset2 := #(a c b) asItemset.
	keyItemset2 metricsValues at: APrioriCountMetric put: 10.
	keyItemset2 metricsValues at: APrioriSupportMetric put: 0.5.
	
	valueItemset2 := #(d f) asItemset.
	valueItemset2 metricsValues at: APrioriCountMetric put: 20.
	valueItemset2 metricsValues at: APrioriSupportMetric put: 0.7.
	
	rule1 := keyItemset1 => valueItemset1.
	rule1 metricsValues at: APrioriCountMetric put: 30.
	rule1 metricsValues at: APrioriSupportMetric put: 0.4.
	rule1 metricsValues at: APrioriConfidenceMetric put: 0.7.
	rule1 metricsValues at: APrioriLiftMetric put: 0.9.
	
	rule2 := keyItemset2 => valueItemset2.
	rule2 metricsValues at: APrioriCountMetric put: 30.
	rule2 metricsValues at: APrioriSupportMetric put: 0.4.
	rule2 metricsValues at: APrioriConfidenceMetric put: 0.7.
	rule2 metricsValues at: APrioriLiftMetric put: 0.9.
	
	self deny: (rule1 =!= rule2).
]

{ #category : #tests }
APrioriAssociationRuleTest >> testStrongEqualitySameElementsDifferentValueMetrics [
	| keyItemset1 valueItemset1 keyItemset2 valueItemset2 rule1 rule2 |
	
	keyItemset1 := #(a c b) asItemset.
	keyItemset1 metricsValues at: APrioriCountMetric put: 10.
	keyItemset1 metricsValues at: APrioriSupportMetric put: 0.5.
	
	valueItemset1 := #(f d) asItemset.
	valueItemset1 metricsValues at: APrioriCountMetric put: 20.
	valueItemset1 metricsValues at: APrioriSupportMetric put: 0.7.
	
	keyItemset2 := #(a c b) asItemset.
	keyItemset2 metricsValues at: APrioriCountMetric put: 10.
	keyItemset2 metricsValues at: APrioriSupportMetric put: 0.5.
	
	valueItemset2 := #(f d) asItemset.
	valueItemset2 metricsValues at: APrioriCountMetric put: 42.
	valueItemset2 metricsValues at: APrioriSupportMetric put: 0.3.
	
	rule1 := keyItemset1 => valueItemset1.
	rule1 metricsValues at: APrioriCountMetric put: 30.
	rule1 metricsValues at: APrioriSupportMetric put: 0.4.
	rule1 metricsValues at: APrioriConfidenceMetric put: 0.7.
	rule1 metricsValues at: APrioriLiftMetric put: 0.9.
	
	rule2 := keyItemset2 => valueItemset2.
	rule2 metricsValues at: APrioriCountMetric put: 30.
	rule2 metricsValues at: APrioriSupportMetric put: 0.4.
	rule2 metricsValues at: APrioriConfidenceMetric put: 0.7.
	rule2 metricsValues at: APrioriLiftMetric put: 0.9.
	
	self deny: (rule1 =!= rule2).
]

{ #category : #tests }
APrioriAssociationRuleTest >> testStrongEqualitySameElementsSameMetrics [
	| keyItemset1 valueItemset1 keyItemset2 valueItemset2 rule1 rule2 |
	
	keyItemset1 := #(a c b) asItemset.
	keyItemset1 metricsValues at: APrioriCountMetric put: 10.
	keyItemset1 metricsValues at: APrioriSupportMetric put: 0.5.
	
	valueItemset1 := #(f d) asItemset.
	valueItemset1 metricsValues at: APrioriCountMetric put: 20.
	valueItemset1 metricsValues at: APrioriSupportMetric put: 0.7.
	
	keyItemset2 := #(a c b) asItemset.
	keyItemset2 metricsValues at: APrioriCountMetric put: 10.
	keyItemset2 metricsValues at: APrioriSupportMetric put: 0.5.
	
	valueItemset2 := #(f d) asItemset.
	valueItemset2 metricsValues at: APrioriCountMetric put: 20.
	valueItemset2 metricsValues at: APrioriSupportMetric put: 0.7.
	
	rule1 := keyItemset1 => valueItemset1.
	rule1 metricsValues at: APrioriCountMetric put: 30.
	rule1 metricsValues at: APrioriSupportMetric put: 0.4.
	rule1 metricsValues at: APrioriConfidenceMetric put: 0.7.
	rule1 metricsValues at: APrioriLiftMetric put: 0.9.
	
	rule2 := keyItemset2 => valueItemset2.
	rule2 metricsValues at: APrioriCountMetric put: 30.
	rule2 metricsValues at: APrioriSupportMetric put: 0.4.
	rule2 metricsValues at: APrioriConfidenceMetric put: 0.7.
	rule2 metricsValues at: APrioriLiftMetric put: 0.9.
	
	self assert: (rule1 =!= rule2).
]

{ #category : #tests }
APrioriAssociationRuleTest >> testValueItemset [
	| keyItemset valueItemset rule |
	
	keyItemset := #(a b) asItemset.
	valueItemset := #(c e d) asItemset.
	
	rule := keyItemset => valueItemset.
	self assert: rule valueItemset equals: valueItemset.
]
