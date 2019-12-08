Class {
	#name : #APrioriAssociationRule,
	#superclass : #Association,
	#type : #variable,
	#instVars : [
		'algorithm'
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
	^ algorithm
]

{ #category : #accessing }
APrioriAssociationRule >> algorithm: anObject [
	algorithm := anObject
]
