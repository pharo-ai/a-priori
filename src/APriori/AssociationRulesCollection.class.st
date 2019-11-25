Class {
	#name : #AssociationRulesCollection,
	#superclass : #OrderedCollection,
	#instVars : [
		'count',
		'support',
		'confidence',
		'lift'
	],
	#category : #APriori
}

{ #category : #'as yet unclassified' }
AssociationRulesCollection >> gtInspectorAssociationRulesIn: composite [
	<gtInspectorPresentationOrder: 0>

	^ composite fastTable
		title: 'Association Rules';
		display: [ self ];
		beMultiple;
		enableElementIndex;
		wantsAutomaticRefresh: true;
		column: 'Index' evaluated: [ :rule :idex | idex asString ] width: 50;
		column: 'Antecedent' evaluated: [ :rule | rule key asString ];
		column: '' evaluated: [ :rule | '=>' ] width: 15;
		column: 'Consequent' evaluated: [ :rule | rule value asString ];
		column: 'Count' evaluated: [ :rule | rule count asString ] width: 50;
		column: 'Support' evaluated: [ :rule | rule support asFloat asString ] width: 60;
		column: 'Confidence' evaluated: [ :rule | rule confidence asFloat asString ] width: 55;
		column: 'Lift' evaluated: [ :rule | rule lift asFloat asString ] width: 50;
		send: [ :result | 
			"withSmalltalkSearch;
		showOnly: 50;
		helpMessage: 'Quick selection field. Given your INPUT, it executes: self select: [:each | INPUT ]'."
			result
				ifNil: [ nil ]
				ifNotNil: [ result size = 1
						ifTrue: [ result anyOne ]
						ifFalse: [ self species withAll: result ]
					]
			]
]
