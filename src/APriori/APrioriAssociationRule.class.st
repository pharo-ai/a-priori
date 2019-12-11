Class {
	#name : #APrioriAssociationRule,
	#superclass : #Association,
	#type : #variable,
	#instVars : [
		'parentItemset',
		'metrics'
	],
	#category : #APriori
}

{ #category : #'instance creation' }
APrioriAssociationRule class >> key: aKey value: aValue [ 
	"Association >> key: value: does not call initialize. So we fix it here"
	^ (super key: aKey value: aValue) initialize
]

{ #category : #'as yet unclassified' }
APrioriAssociationRule >> =!= anObject [
	"Strong equality - checks not only the equality of the items inside key and value collections, but also the equality of algorithm of the rule, of key, and of value"
	(self species = anObject species)
		ifFalse: [ ^ false ].
		
	(self key =!= anObject key)
		ifFalse: [ ^ false ].
		
	(self value =!= anObject value)
		ifFalse: [ ^ false ].
		
	^ self metrics = anObject metrics.
]

{ #category : #accessing }
APrioriAssociationRule >> confidence [
	^ metrics at: APrioriConfidenceMetric
]

{ #category : #accessing }
APrioriAssociationRule >> count [
	^ metrics at: APrioriCountMetric
]

{ #category : #initialization }
APrioriAssociationRule >> initialize [ 
	super initialize.
	metrics := Dictionary new.
]

{ #category : #'as yet unclassified' }
APrioriAssociationRule >> keyItemset [
	^ self key
]

{ #category : #accessing }
APrioriAssociationRule >> lift [
	^ metrics at: APrioriLiftMetric
]

{ #category : #accessing }
APrioriAssociationRule >> metrics [ 	
	^ metrics
]

{ #category : #'as yet unclassified' }
APrioriAssociationRule >> parentItemset [
	^ parentItemset
]

{ #category : #'as yet unclassified' }
APrioriAssociationRule >> parentItemset: anObject [
	parentItemset := anObject
]

{ #category : #accessing }
APrioriAssociationRule >> support [
	^ metrics at: APrioriSupportMetric
]

{ #category : #'as yet unclassified' }
APrioriAssociationRule >> valueItemset [
	^ self value
]
