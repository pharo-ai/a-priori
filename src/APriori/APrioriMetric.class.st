Class {
	#name : #APrioriMetric,
	#superclass : #Object,
	#instVars : [
		'algorithm'
	],
	#category : #APriori
}

{ #category : #'instance creation' }
APrioriMetric class >> forAlgorithm: anAlgorithm [
	^ super new initializeAlgorithm: anAlgorithm.
]

{ #category : #'instance creation' }
APrioriMetric class >> new [ 
	self shouldNotImplement 
]

{ #category : #initialization }
APrioriMetric >> initializeAlgorithm: anAlgorithm [
	algorithm := anAlgorithm
]

{ #category : #evaluating }
APrioriMetric >> valueForAssociationRule: anAssociationRule [
	self subclassResponsibility
]

{ #category : #evaluating }
APrioriMetric >> valueForItemset: anItemset [
	self subclassResponsibility
]
