Class {
	#name : #APrioriCountMetric,
	#superclass : #APrioriMetric,
	#category : #APriori
}

{ #category : #evaluating }
APrioriCountMetric >> valueForAssociationRule: anAssociationRule [
	^ self valueForItemset: anAssociationRule parentItemset
]

{ #category : #evaluating }
APrioriCountMetric >> valueForItemset: anItemset [
	^ algorithm countOfItemset: anItemset
]
