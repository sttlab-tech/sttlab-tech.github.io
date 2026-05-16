---
layout: post
title: "Gouvernance moderne des SI : fédéralisme assumé ou impérialisme subi ?"
date: 2026-05-16
lang: fr
published: true
tags: [gouvernance, fédéralisme, souveraineté]
description: "Les organisations agiles et les architectures distribuées ont conquis les années 2010 au nom du time-to-market. Mais le durcissement de l'environnement — réglementaire, économique, géopolitique — réclame désormais davantage de contrôle. Le fédéralisme, qui a su concilier autonomie et unité dans l'ordre politique, offre-t-il la synthèse pour les systèmes d'information ? Ou se dirige-t-on vers un modèle impérialiste, à l'image du monde dans lequel nous vivons aujourd'hui ?"
read_time: 5
---


## La décennie de l'autonomie

Les années 2010 ont été celles de la dispersion assumée. Sous la pression du time-to-market et de la qualité de service, les entreprises ont démantelé leurs monolithes : équipes autonomes, microservices, ownership distribué. Plus de découplage, c'était plus de vitesse — et la vitesse était l'arme concurrentielle. Le modèle tenait tant que le coût du désordre restait inférieur au gain de vélocité.

## Le retournement du contexte

Ce calcul s'est inversé au début des années 2020, avec le COVID en rôle de catalyseur : il a remis la **rationalisation des coûts** au centre des arbitrages et révélé la fragilité des chaînes numériques. S'en est suivie une **inflation réglementaire** devenue structurelle — DORA, NIS2, Cyber Resilience Act, AI Act — exigeant une traçabilité et une maîtrise des risques que des dizaines d'équipes pleinement autonomes ne garantissent pas spontanément. S'y ajoute enfin une **guerre numérique** — souveraineté des données, cyberattaques d'État — qui fait de chaque SI étendu une surface à défendre.

Comment garder l'agilité des années 2010 tout en réintroduisant le contrôle qu'exige la décennie 2020 ? Recentraliser serait une régression coûteuse. Il faut une autre forme.

## Le fédéralisme comme synthèse

Cette forme existe en science politique : le fédéralisme. Les États fédérés conservent une large autonomie, mais dans un cadre commun — une constitution qui fixe les **règles non négociables**, et des **infrastructures partagées** qu'aucun État ne produirait seul.

Transposé au SI, le parallèle est direct. La constitution, ce sont les standards IT : sécurité, observabilité, conformité, interopérabilité. L'autonomie, c'est la liberté laissée aux équipes sur tout ce qui ne touche pas à ce socle. Les infrastructures communes, ce sont les capacités mutualisées : le réseau et sa segmentation, le socle de sécurité — gestion des identités, des secrets, des certificats —, les plateformes d'échange et d'observabilité, le tooling CI/CD. Autant de fondations qu'il serait absurde — et risqué — de réimplémenter dans chaque équipe.

Deux pratiques en particulier incarnent ce fédéralisme technique.

- Les **architectures à plan de contrôle** : le plan de contrôle centralise la politique pendant que le plan de données reste distribué — la règle est commune, la supervision centralisée, mais l'exécution reste locale, exactement comme la loi fédérale appliquée par les États.
- Le **platform engineering** ensuite, qui matérialise les infrastructures communes en *paved roads* : des chemins outillés, sécurisés et conformes par construction, complétés par du self-service qui rend l'autonomie réelle sans la rendre anarchique.

## La plateforme doit mériter ses utilisateurs

Il faut être lucide : le fédéralisme IT échoue souvent. Une plateforme mal pensée recrée le goulot d'étranglement qu'elle prétendait supprimer — la route pavée devient obligatoire, personne ne l'emprunte volontiers, les équipes la contournent. On obtient alors le pire des deux mondes : la lenteur de la centralisation sans la cohérence promise.

Le principe qui sépare le succès de l'échec tient en une phrase : la plateforme doit mériter ses utilisateurs. L'adoption ne se décrète pas, elle se gagne. Une route pavée n'est légitime que si elle est objectivement plus facile, plus rapide et plus sûre que l'alternative. Si elle l'est, la conformité devient un effet de bord du chemin le plus simple. 

## Le grand retour des empires

Reste une question d'échelle. Le mouvement géopolitique des années 2020 n'est pas seulement un retour du contrôle : c'est le grand retour des empires — des ensembles vastes et intégrés qui offrent **stabilité et protection en échange d'une intégration profonde**.

L'analogie s'impose : les hyperscalers. Ils fournissent à l'échelle planétaire ce qu'aucune organisation ne produirait seule. Sont-ils l'aboutissement du modèle fédéral, ou proposent-ils autre chose, qui s'apparenterait à de l'impérialisme ?

Ce n'est pas un jugement de valeur. Il existe des empires où les peuples prospèrent, et l'intégration profonde n'est pas un mal en soi. Le critère qui distingue le fédéralisme de l'impérialisme n'est ni le degré de contrôle ni la qualité du service : c'est la **réversibilité**. Un État fédéré garde, en principe, un droit de sécession ; un sujet d'empire, non. La vraie question aux hyperscalers n'est donc pas « leur service est-il bon ? » — il l'est souvent — mais « puis-je encore partir ? ». Reste-t-il une porte de sortie, un coût de sortie supportable, une liberté de choix réelle ?

C'est une question de **souveraineté**. À l'organisation de poser sa constitution — ses standards de sécurité, d'interopérabilité, de portabilité — et à l'hyperscaler de s'y conformer comme un simple fournisseur d'infrastructures communes. Faute de quoi elle n'est plus un État souverain, mais un sujet d'empire.
