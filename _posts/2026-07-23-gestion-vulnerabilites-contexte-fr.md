---
layout: post
title: "Vulnérabilités : le scanner ne pense pas à votre place"
date: 2026-07-23
lang: fr
published: true
tags: [Gestion des vulnérabilités, IA agentique, Sécurité]
description: "Les scanners recrachent des milliers de CVE classées par un score CVSS qui mesure une gravité théorique, pas votre exposition réelle. Sans contexte, les équipes subissent le volume ou patchent tout dans l'urgence. Quatre questions transforment cette liste brute en décisions fondées sur le risque."
read_time: 6
---

## Un médicament dangereux n'est pas un poison

Ouvrez la notice d'un médicament courant : déconseillé aux femmes enceintes, contre-indiqué en cas d'insuffisance cardiaque, à éviter avec tel autre traitement. Une liste d'avertissements parfois impressionnante. Et pourtant il est prescrit chaque jour à des millions de personnes, sans danger — parce qu'un risque n'existe jamais dans l'absolu : il dépend du patient, de la dose, des interactions. Le médecin contextualise par réflexe avant de décider.

La gestion des vulnérabilités logicielles fait trop souvent l'inverse. Elle traite chaque faille comme un poison absolu, alors qu'une vulnérabilité est avant tout un risque, et qu'un risque se pondère avec des données de contexte.

## Le problème : la CVE brute, prise pour un verdict

Le schéma habituel est connu : on lance un scanner, il recrache une liste de CVE, et on considère l'analyse terminée. Reste un fatras de centaines ou de milliers de failles, ordonnées au mieux par leur score CVSS.

Or le CVSS de base mesure une gravité *intrinsèque et théorique* — la sévérité d'un exploit réussi, dans des conditions idéales pour l'attaquant. Il ne dit rien de votre exposition réelle. Ses métriques temporelles et environnementales, précisément conçues pour ajuster ce score, sont presque toujours ignorées. On se retrouve donc à piloter la remédiation sur un indicateur qui, par construction, n'a jamais eu vocation à mesurer *votre* risque.

Les conséquences s'enchaînent mécaniquement. Le volume devient ingérable, et la poignée de failles réellement dangereuses se noie dans le bruit de fond. Quand tout est « critique », plus rien ne l'est : la priorisation s'effondre, et l'on corrige au hasard des tickets plutôt que par ordre de risque.

Faute de tri, deux réflexes s'installent, aussi coûteux l'un que l'autre :

- **Subir le volume.** Les équipes s'usent (*alert fatigue*), le temps d'ingénierie part en fumée sur du bruit, et la sécurité, à force de crier au loup, perd la crédibilité qui la ferait écouter.
- **Sur-réagir.** On patche tout, tout de suite. Or le patching n'est pas neutre — c'est une intervention qui porte son propre risque : un correctif mal évalué introduit des régressions, casse une dépendance, provoque une indisponibilité. Corriger en urgence, au prix d'une panne, une faille inexploitable dans votre contexte : le remède devient pire que le mal.

Dans les deux cas, on finit par piloter un chiffre — le nombre de CVE fermées — au lieu d'une exposition réelle, dans une posture dictée par la peur ou la conformité plutôt que par le risque.

## Contextualiser : quatre questions à poser

Sortir de ce fatras ne demande pas plus de scan, mais plus de contexte. Ce contexte se ramène à quatre questions, dont les réponses viennent de sources différentes — l'éditeur, votre déploiement, vos enjeux, la menace — qu'aucun acteur ne détient à lui seul. Les croiser transforme une liste brute en décisions.

**Le composant vulnérable est-il seulement utilisé ?** Qu'une dépendance porte une CVE ne signifie pas que sa fonction vulnérable soit atteinte dans votre chemin d'exécution. Cette réponse vient de l'éditeur, via un VEX (*Vulnerability Exploitability eXchange*) — un document où il déclare l'exploitabilité de la faille *dans son produit* (`not_affected`, `affected`, `fixed`…), assertion intrinsèque au produit donc portable. À défaut, vous la reconstituez par une analyse de *reachability* : un outil de SCA trace le graphe d'appels et vérifie s'il existe un chemin vers la fonction visée — pas de chemin, faille inatteignable donc inoffensive. Réserve : cette analyse peut relever de la rétro-ingénierie sur le binaire d'un composant tiers, avec les limites légales que cela suppose.

**La faille est-elle exposée dans votre déploiement ?** La même CVE n'a pas le même poids selon *où* et *comment* le composant tourne. Une RCE (*Remote Code Execution*, exécution de code à distance) non authentifiée sur un service en frontal Internet n'a rien à voir avec la même faille sur un composant interne, segmenté, option vulnérable désactivée, derrière une authentification forte. Parfois la faille n'est même pas applicable : une CVE spécifique à Windows ne concerne pas une image Linux tournant dans Kubernetes, quand bien même le scanner la remonte. Exposition réseau, plateforme d'exécution, configuration, contrôles compensatoires : ces données ne peuvent venir que de vous, car l'éditeur ignore votre architecture. Corollaire : elles ne valent que pour *ce* déploiement et doivent être ré-évaluées à chaque environnement.

**L'actif touché compte-t-il pour vous ?** Une faille sur un service secondaire ne pèse pas comme une faille sur un système qui manipule des données sensibles ou soutient un processus métier vital. C'est la logique des *CIA requirements* — le niveau de confidentialité, d'intégrité et de disponibilité exigé de l'actif — que le CVSS lui-même intègre via ses métriques environnementales (CR/IR/AR) pour repondérer le score de base. Cette criticité relève de vos priorités métier, et de personne d'autre.

**La faille est-elle réellement exploitée ?** Une donnée extérieure, cette fois, et partagée par tous. L'EPSS estime une probabilité d'exploitation à 30 jours ; le catalogue KEV de la CISA recense les CVE dont l'exploitation est avérée. Ces signaux réorientent l'effort vers ce qui est activement attaqué, et non vers ce qui affiche seulement un CVSS élevé. À manier toutefois avec prudence : l'EPSS est un modèle probabiliste calé sur l'historique, et l'accélération du développement d'exploits par l'IA raccourcit les délais au point de fragiliser des prédictions bâties sur le passé.

Croisées, ces quatre réponses font fondre le volume : sur des milliers d'alertes, seule une poignée cumule code atteignable, déploiement exposé, actif critique et exploitation avérée. Ce sont celles-là qu'on traite en premier — et sans délai.

## La riposte sera agentique

Contextualiser à ce niveau a un coût : collecter des données de sources hétérogènes — SBOM, VEX, inventaire d'actifs, EPSS, KEV, topologie réseau —, les recouper et trancher, faille par faille. À la main, c'est intenable ; c'est même pourquoi tant d'équipes renoncent et s'en tiennent au tri paresseux par CVSS. Le *risk-based vulnerability management* reste alors un principe qu'on approuve sans jamais l'appliquer.

C'est précisément ce que débloque l'IA agentique : un agent interroge les sources, réconcilie les statuts VEX avec l'état réel du déploiement, signale les incohérences et propose un tri argumenté — l'humain gardant la décision. Le pilotage par le risque cesse d'être un vœu pieux pour devenir opérable à l'échelle.

Et ce n'est pas un luxe. La même IA qui accélère le développement d'exploits — celle qui périme déjà les probabilités de l'EPSS — rebat les cartes du côté des attaquants. IA à l'attaque, IA à la riposte : dans cette course, la contextualisation agentique n'est plus une commodité, c'est la condition pour rester dans la partie. Le but n'a jamais été de tout patcher — seulement de protéger ce qui compte, et désormais, d'aller assez vite pour y arriver.
