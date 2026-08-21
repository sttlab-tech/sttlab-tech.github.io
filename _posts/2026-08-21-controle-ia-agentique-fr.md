---
layout: post
title: "Vos IA passent à l'action. Êtes-vous certain de pouvoir les contrôler ?"
date: 2026-08-21
lang: fr
published: true
tags: [IA agentique, Gouvernance IA]
description: "Un agent autonome n'a pas besoin d'être malveillant pour franchir les limites qu'on lui a fixées, comme le montrent les récents incidents chez OpenAI et Anthropic. L'occasion suffit — d'où la nécessité de placer les garde-fous là où l'agent ne peut ni les ignorer ni les désactiver. Les fondements du cahier des charges d'une gouvernance agentique conçue pour le monde réel."
read_time: 10
---

Les récents incidents impliquant les agents autonomes d'[OpenAI](https://thehackernews.com/2026/07/openai-says-its-own-ai-models-escaped.html) et d'[Anthropic](https://techcrunch.com/2026/07/30/anthropic-says-its-own-ai-models-breached-three-companies-during-security-tests/) l'illustrent : un agent n'a pas besoin d'être malveillant pour franchir les limites qu'on lui a fixées. L'occasion suffit. Ces sorties de route ont causé des dommages à des tiers et contourné des garde-fous de sécurité.

[Yoshua Bengio](https://www.letemps.ch/cyber/yoshua-bengio-nous-voyons-deja-des-ia-mentir-tricher-faire-du-chantage-et-tenter-de-s-echapper-avec-des-systemes-plus-puissants-le-risque-de-perdre-le-controle-devient-reel) le rappelle : entraînés sur le corpus des interactions humaines, les modèles n'imitent pas que notre savoir. Ils héritent aussi de nos « faiblesses morales » et de notre « potentiel de tromperie », et d'un réflexe de conservation — atteindre presque n'importe quel objectif suppose de survivre et de garder le contrôle de son environnement. « Nous voyons déjà des IA mentir, tricher, faire du chantage et tenter de s'échapper. »

Le changement de paradigme est là. Une erreur logicielle est un bug : reproductible, localisable, corrigeable. Ici, il y a bien eu un défaut — l'environnement était mal configuré — mais il n'a fait qu'ouvrir la porte. L'agent, lui, a lu, évalué, délibéré, et décidé de la franchir en toute autonomie.

La promesse de l'IA agentique repose justement sur cette autonomie. Mais un agent prendra toute celle qu'on acceptera de lui laisser, et sans limites structurelles la moindre digression peut devenir un accident industriel.

Est-ce qu'on peut garder le contrôle sur les agents ? Oui, jusqu'à un certain point. Mais pas en comptant sur leur bonne volonté : les garde-fous doivent être placés là où l'agent ne peut ni les ignorer ni les désactiver. Voici les fondements du cahier des charges d'une gouvernance agentique conçue pour le monde réel.

## L'interposition : le contrôle doit vivre en dehors de l'IA

Le premier principe d'une gouvernance agentique robuste est que le contrôle de sécurité ne peut pas résider à l'intérieur de ce qu'il contrôle. Placer les règles de sécurité dans les consignes données à l'agent, ou dans le code qui l'exécute, revient à confier les clés du coffre à un composant que l'attaquant cherche précisément à manipuler. 

Ce principe n'a rien de nouveau : il fonde l'API Management depuis quinze ans. Une passerelle interposée entre les consommateurs et les systèmes, qui authentifie, limite et journalise — parce qu'on n'a jamais accepté que le client applique lui-même les règles.

Ce qui change, c'est l'appelant : un client d'API exécute le code qu'on lui a écrit, un agent décide — quel outil, quels arguments — à partir de contenus que personne n'a validés. Le point d'interposition reste donc le bon endroit, mais il doit devenir un **fusible incontournable**, capable de rendre chaque décision d'autorisation à l'extérieur de l'agent, de façon déterministe, et de couper le circuit dès que l'action demandée sort de son cadre.

## Enablement : l'art de l'autonomie bornée

Pour créer de la valeur, il faut rendre consommable par les agents tout ce dont ils ont besoin pour travailler — services internes, outils, serveurs tiers, autres agents — tout en maîtrisant strictement leur rayon d'action.

* **Support des protocoles du marché** : **MCP** (Model Context Protocol) pour exposer outils et ressources aux agents, **A2A** (Agent-to-Agent) pour la communication entre agents, le streaming pour les réponses progressives.
* **Accès aux ressources de l'entreprise** : Le patrimoine d'APIs existant doit pouvoir être offert aux agents sans être réécrit, ses opérations devenant des outils qu'un modèle sait invoquer. Cette exposition doit se faire opération par opération : on décide précisément de ce que l'agent peut voir, sans pour autant lui ouvrir une API entière. Plusieurs APIs peuvent à l'inverse être composées en une capacité unique et cohérente.
* **Découverte gouvernée et moindre contexte** : Les agents doivent pouvoir interroger un registre de capacités — outils, *skills*, serveurs MCP, jusqu'aux autres agents. Contrairement aux annuaires classiques, cette découverte se limite à ce qui est strictement nécessaire au rôle de l'agent : réduire le contexte, c'est réduire la surface d'attaque et les risques d'empoisonnement passif.
* **Chaîne d'approvisionnement** : Tout ce qu'un agent consomme sans l'avoir écrit entre dans son périmètre d'exécution. L'origine, l'intégrité, la version et le propriétaire doivent être vérifiables avant usage, l'approvisionnement passer par une source approuvée plutôt qu'une place de marché publique, et toute modification après approbation être détectée.

## Zero Trust appliqué aux systèmes probabilistes

Appliquer le paradigme Zero Trust à des entités autonomes nécessite d'adapter profondément la gestion des identités, des données et de l'autorisation.

### Identité dédiée et autorisation contextuelle
Les comptes de service génériques masquent l'origine réelle des requêtes. Chaque agent doit posséder sa propre identité, et la délégation d'autorité (*on-behalf-of*) lier formellement l'initiateur — utilisateur ou agent délégant — à l'action exécutée, pour conserver une chaîne de responsabilité complète y compris sur plusieurs sauts.

L'autorisation cesse alors d'être binaire : elle porte sur l'opération, la ressource visée et les arguments transmis — plafonner le montant d'un virement, et pas seulement donner accès à l'outil de virement.

Encore faut-il que l'outil s'y prête. Une règle peut trancher sur un montant, un destinataire ou une classification de donnée ; elle ne peut rien sur un outil générique qui accepte une requête SQL ou une commande shell en texte libre. La granularité de l'autorisation est plafonnée par celle de l'outil exposé.

### Quand la décision revient à un humain
Toute décision n'a pas à être automatique. Au-delà d'un seuil — montant, criticité de la ressource, classification de la donnée, caractère irréversible de l'action — l'agent ne doit pas être refusé mais mis en attente : l'action part en revue, un humain tranche, et son arbitrage est tracé au même titre que celui du système.

### Lutte contre l'empoisonnement : neutraliser le contexte et la mémoire
Qu'un agent lise un document d'entreprise, reçoive le retour d'une API ou consulte ses propres souvenirs, chaque information ingérée est un vecteur de manipulation. Tout contenu externe doit donc être traité comme une **donnée non fiable** et jamais comme une instruction prioritaire. L'enjeu n'est pas d'éliminer toute instruction cachée — personne ne sait le garantir — mais de réduire la surface et de détecter ce qui passe.

Le danger s'amplifie avec la mémoire persistante, qui transforme une faille ponctuelle en risque permanent. La gouvernance exige alors un cloisonnement strict des historiques de chaque agent, une séparation rigoureuse entre son droit de lire et d'écrire, ainsi que des mécanismes de détection et de purge réduisant le risque qu'une donnée empoisonnée pèse durablement sur sa conduite.

### La confiance entre agents ne se déclare pas
Un agent qui en appelle un autre se fie à une fiche de capacités publiée par le propriétaire de ce dernier. C'est une déclaration, pas une autorisation : son émetteur et son contenu doivent être vérifiés avant tout appel, et revérifiés à chaque modification.

Autoriser un agent distant ne revient pas à autoriser tout ce qu'il annonce savoir faire. L'autorisation se donne capacité par capacité, sur la ressource visée et les paramètres transmis. Et qu'il soit approuvé chez son propriétaire ne l'approuve pas chez vous : franchir cette frontière demande une décision explicite.

### Le confinement : isoler l'exécution et borner les sorties réseau
Quand un agent exécute du code, son environnement doit être isolé par des contrôles système et réseau qui ne dépendent d'aucune consigne donnée à l'agent. Une isolation déclarée n'est pas une isolation : elle se vérifie avant l'exécution et s'observe pendant.

Le même principe vaut pour les sorties réseau : seules les destinations explicitement autorisées sont joignables, tout le reste est refusé. Borner ce que l'agent peut atteindre borne aussi ce qui peut entrer dans son contexte. Et publier vers l'extérieur étant irréversible, cela demande une autorisation distincte du droit de lecture.

Reste à surveiller ces périmètres : ce qu'un agent fait réellement doit être comparé en continu à ce qu'il est censé faire.

### Reconstituer le contexte d'une décision
Si l'identité établit la responsabilité, la trace établit le contexte. Elle ne dira pas pourquoi le modèle a tranché comme il l'a fait — son raisonnement interne reste hors de portée — mais elle dit ce sur quoi il s'est appuyé : comment les consignes ont été construites, quels documents ont été lus, quels outils appelés, quelles règles appliquées, quels effets produits.

Encore faut-il qu'elle ne s'interrompe pas au premier système appelé : à la manière des traces distribuées, un identifiant de corrélation unique doit la propager jusque dans les systèmes métiers. Sans elle, impossible de reconstituer le contexte d'une décision, de vérifier que les politiques ont bien été appliquées, ni d'instruire un incident.

### Le disjoncteur d'urgence : le Kill Switch
En dernier recours, comprendre la déviation ne suffit pas : il faut pouvoir l'arrêter. La solution doit offrir un **Kill Switch sélectif** (un véritable disjoncteur) capable d'interrompre un agent fautif dans un délai borné et mesurable, en révoquant l'ensemble de ses accès actifs sans paralyser le reste de l'infrastructure. Reste la question des actions déjà engagées : un agent coupé au milieu d'une opération en plusieurs étapes laisse un système tiers dans un état intermédiaire. L'arrêt doit donc s'accompagner de mécanismes de compensation, de notification, et de la garantie qu'une reprise ne rejouera pas l'action.

## Contrôle du trafic modèle

Reste une couche de contrôle à part entière : le flux entre l'agent et le modèle.

* **Interface unifiée vers les modèles** : Un agent ne doit pas s'adresser directement à un fournisseur. Une couche d'accès unique permet de changer de modèle, d'en répartir la charge ou d'en router les appels selon le coût, la latence ou la région, sans toucher aux agents. C'est aussi ce qui rend possible tout ce qui suit : on ne contrôle que ce que l'on traverse.
* **Garde-fous de contenu** : Les prompts construits, les complétions produites et les contenus récupérés doivent pouvoir être inspectés en entrée comme en sortie, y compris en streaming, selon des catégories de contenus interdits ou soumis à condition administrables par l'organisation — et non figées par l'éditeur. Ces contrôles restent probabilistes : ils réduisent le risque sans le garantir, et ne remplacent jamais l'autorisation rendue côté exécution.
* **Protection des données personnelles** : Une donnée personnelle peut être saisie par un utilisateur, restituée par un outil ou produite par le modèle lui-même. Sa détection doit donc porter sur les deux sens du flux et déclencher, selon la politique applicable, un masquage, une pseudonymisation, un blocage ou une mise en approbation.
* **FinOps en quasi temps réel** : La consommation de tokens d'un agent autonome peut filer sans borne en cas de boucle. La solution doit offrir un suivi de cette consommation en quasi temps réel, couplé à des mécanismes de fusible capables de couper automatiquement le circuit en cas de déviation budgétaire significative.

## Conclusion

L'AI Act, DORA et NIS2 sont souvent invoqués ensemble sur ce sujet. Aucun ne définit pourtant une gouvernance des agents : l'AI Act s'applique selon le rôle de l'organisation et le niveau de risque du système, DORA vise la résilience opérationnelle des entités financières et de leurs prestataires, NIS2 impose des mesures de cybersécurité à des secteurs désignés. Ce qu'ils font tous les trois, c'est relever l'exigence de maîtrise du risque numérique pour les organisations concernées — et une flotte d'agents autonomes y entre de plein droit. Mais l'argument réglementaire n'est pas le plus fort.

Reporter cette gouvernance, c'est accumuler une dette dont le coût a changé de nature. Ce qui a changé, c'est la valeur du temps : la vitesse et le volume des échanges en 2026 n'ont plus rien à voir avec ceux des années 2010, et l'agentique amplifie encore cette accélération.

L'analogie est brutale mais implacable : un écart de conduite n'a pas les mêmes conséquences à 20 km/h qu'à 1000 km/h. À cette vitesse, les dispositifs de sécurité cessent d'être des options de confort pour devenir des conditions de survie. C'est à cette condition que l'humain garde, in fine, le contrôle sur l'IA.

Reste à savoir à quoi ressemble concrètement ce dispositif. Ce sera l'objet du prochain article : une architecture de référence pour mettre en œuvre ces exigences.
