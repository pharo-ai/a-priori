Class {
	#name : #APrioriAssociationRule,
	#superclass : #Association,
	#type : #variable,
	#instVars : [
		'parentItemset'
	],
	#category : #APriori
}

{ #category : #'as yet unclassified' }
APrioriAssociationRule >> =!= anObject [
	"Strong equality - checks not only the equality of the items inside key and value collections, but also the equality of algorithm of the rule, of key, and of value"
	(self species = anObject species)
		ifFalse: [ ^ false ].
		
	(self key =!= anObject key)
		ifFalse: [ ^ false ].
		
	(self value =!= anObject value)
		ifFalse: [ ^ false ].
		
	^ self algorithm = anObject algorithm.
]

{ #category : #accessing }
APrioriAssociationRule >> algorithm [
	^ parentItemset algorithm
]

{ #category : #'as yet unclassified' }
APrioriAssociationRule >> keyItemset [
	^ self key
]

{ #category : #'as yet unclassified' }
APrioriAssociationRule >> parentItemset [
	^ parentItemset
]

{ #category : #'as yet unclassified' }
APrioriAssociationRule >> parentItemset: anObject [
	parentItemset := anObject
]

{ #category : #'as yet unclassified' }
APrioriAssociationRule >> valueItemset [
	^ self value
]
