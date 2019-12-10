Class {
	#name : #APrioriLiftMetric,
	#superclass : #APrioriMetric,
	#category : #APriori
}

{ #category : #evaluating }
APrioriLiftMetric >> valueForAssociationRule: anAssociationRule [
	| parentCount keyCount valueCount |
	
	parentCount := algorithm countOfItemset: anAssociationRule parentItemset.
	keyCount := algorithm countOfItemset: anAssociationRule keyItemset.
	valueCount := algorithm countOfItemset: anAssociationRule valueItemset.
	
	^ parentCount * algorithm numberOfTransactions / (keyCount * valueCount)
]

{ #category : #evaluating }
APrioriLiftMetric >> valueForItemset: anItemset [
	self shouldNotImplement
]
