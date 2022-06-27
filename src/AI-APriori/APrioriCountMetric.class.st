Class {
	#name : #APrioriCountMetric,
	#superclass : #APrioriMetric,
	#category : #'AI-APriori'
}

{ #category : #evaluating }
APrioriCountMetric >> valueForAssociationRule: anAssociationRule [
	^ self valueForItemset: anAssociationRule parentItemset
]

{ #category : #evaluating }
APrioriCountMetric >> valueForItemset: anItemset [
	^ anItemset count
]
