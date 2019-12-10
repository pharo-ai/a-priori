Class {
	#name : #APrioriConfidenceMetric,
	#superclass : #APrioriMetric,
	#category : #APriori
}

{ #category : #evaluating }
APrioriConfidenceMetric >> valueForAssociationRule: anAssociationRule [
	| parentCount keyCount |
	
	parentCount := algorithm countOfItemset: anAssociationRule parentItemset.
	keyCount := algorithm countOfItemset: anAssociationRule keyItemset.
	
	^ parentCount / keyCount
]

{ #category : #evaluating }
APrioriConfidenceMetric >> valueForItemset: anItemset [
	self shouldNotImplement
]
