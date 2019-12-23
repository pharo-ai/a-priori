Class {
	#name : #APrioriAssociationRule,
	#superclass : #Association,
	#type : #variable,
	#instVars : [
		'parentItemset',
		'metricsValues'
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
	"Strong equality - checks not only the equality of the items inside key and value collections, but also the equality of metrics of the rule, of key, and of value, as well as the strong equality of the parent itemset"
	(self species = anObject species)
		ifFalse: [ ^ false ].
		
	(self keyItemset =!= anObject keyItemset)
		ifFalse: [ ^ false ].
		
	(self valueItemset =!= anObject valueItemset)
		ifFalse: [ ^ false ].
		
	(self parentItemset =!= anObject parentItemset)
		ifFalse: [ ^ false ].
		
	^ self metricsValues = anObject metricsValues.
]

{ #category : #accessing }
APrioriAssociationRule >> confidence [
	^ metricsValues at: APrioriConfidenceMetric
]

{ #category : #accessing }
APrioriAssociationRule >> count [
	^ metricsValues at: APrioriCountMetric
]

{ #category : #initialization }
APrioriAssociationRule >> initialize [ 
	super initialize.
	metricsValues := Dictionary new.
]

{ #category : #'as yet unclassified' }
APrioriAssociationRule >> keyItemset [
	^ self key
]

{ #category : #accessing }
APrioriAssociationRule >> lift [
	^ metricsValues at: APrioriLiftMetric
]

{ #category : #accessing }
APrioriAssociationRule >> metricsValues [	
	^ metricsValues
]

{ #category : #'as yet unclassified' }
APrioriAssociationRule >> parentItemset [
	^ parentItemset
]

{ #category : #'as yet unclassified' }
APrioriAssociationRule >> parentItemset: anObject [
	parentItemset := anObject
]

{ #category : #printing }
APrioriAssociationRule >> printOn: aStream [
	self key printOn: aStream.
	aStream nextPutAll: ' => '.
	self value printOn: aStream.
]

{ #category : #accessing }
APrioriAssociationRule >> support [
	^ metricsValues at: APrioriSupportMetric
]

{ #category : #'as yet unclassified' }
APrioriAssociationRule >> valueItemset [
	^ self value
]
