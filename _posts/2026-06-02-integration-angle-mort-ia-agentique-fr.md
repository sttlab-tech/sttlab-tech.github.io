---
layout: post
title: "L’intégration, angle mort de l’IA agentique"
date: 2026-06-02
lang: fr
published: true
tags: [IA agentique, Intégration]
description: "L’IA agentique est partout. Dans les keynotes, dans les budgets 2026, dans les roadmaps. Pourtant, lorsque l’on regarde de près ce que produisent réellement les projets en cours dans les entreprises, le constat est souvent décevant : la majorité d’entre eux ne sont, au fond, que des systems of insights améliorés."
read_time: 5
---

Un agent qui résume le rapport de ventes du Q3, c’est bien. Un agent qui rééquilibre les stocks entre entrepôts en temps réel quand une rupture se profile, c’est transformateur. C’est dans cet écart — entre observer et agir — que se joue la promesse de l’agentique. Et c’est précisément là que la plupart des projets s’arrêtent aujourd’hui.

## L’agent n’est que la partie émergée

Tant qu’un agent évolue en silo, déconnecté de l’ERP, du CRM, des bases produits, des outils RH, des plateformes logistiques, il ne peut ni passer une commande, ni mettre à jour un dossier client, ni déclencher un workflow métier. Il observe, il décrit, il suggère. Il n’agit pas.

À bien des égards, l’IA agentique rejoue l’ambition des BPMS : orchestrer des actions métier de bout en bout. Mais là où les BPMS exigeaient de modéliser explicitement les processus, les agents promettent de composer dynamiquement des actions à partir d’une intention, d’un contexte et d’un ensemble d’outils disponibles. C’est précisément ce qui les rend puissants — et plus difficiles à gouverner.

Le véritable enjeu de l’agentique ne se joue donc pas dans le choix du modèle, ni même dans la sophistication du framework d’orchestration. Il se joue dans la capacité à connecter ces agents aux ressources patrimoniales de l’entreprise — applications cœur, données, processus — de manière fiable, sécurisée et gouvernée.

Or ces ressources n’ont jamais été conçues pour cela. Elles ont été pensées pour des utilisateurs humains, pour des intégrations batch, pour des partenaires identifiés. Pas pour des agents autonomes qui raisonnent, décident et déclenchent des actions à la volée, à des fréquences imprévisibles et avec une intentionnalité parfois floue. Il faut donc, en parallèle de la construction des agents eux-mêmes, repenser la manière dont le SI s’expose : rendre ces ressources accessibles aux agents, *et* encadrer strictement leur utilisation.

## Un air de déjà-vu

Au moment où les entreprises ont ouvert leur SI aux canaux digitaux — e-commerce, mobile, partenaires — la même question s’est posée : *comment connecter de manière sécurisée et gouvernée ces nouveaux points de contact avec le SI patrimonial ?* À l’époque, tout le monde parlait d’APIs REST. Aujourd’hui, tout le monde parle de serveurs et de *tools* MCP. MCP, pour *Model Context Protocol*, vise à standardiser cette nouvelle porte d’entrée des agents vers le SI patrimonial : l’accès aux outils, aux données, aux applications et aux processus métier.

L’histoire bégaie. La peur d’être disrupté force les entreprises à innover plus vite qu’elles ne le voudraient, en prenant — le plus souvent sans en avoir conscience — des raccourcis qui génèrent au mieux de la dette technique, au pire des risques opérationnels et de sécurité majeurs. Les anti-patterns sont les mêmes qu’à l’époque, mais prennent une forme nouvelle dans les PoC agentiques :

- **Des données rendues accessibles à un agent — et donc potentiellement à son utilisateur — qui ne devraient pas l’être**, faute de contrôles d’accès adaptés à ce nouveau mode d’interaction.
- **Des backends mis à genoux** par les rafales d’appels d’agents trop curieux, là où les systèmes existants avaient été dimensionnés pour des usages humains ou des flux applicatifs prévisibles.
- **Des enchaînements d’actions individuellement autorisées, mais collectivement risquées** : consulter un stock, modifier une priorité, déclencher un transfert, notifier un client — autant d’actions légitimes qui, combinées sans garde-fous métier, peuvent produire un effet non désiré.

## Les recettes d’hier fonctionnent encore

La bonne nouvelle, c’est que les principes posés à l’époque pour répondre aux défis des canaux digitaux restent parfaitement valables pour l’agentique :

- **Exposer des interfaces qui capitalisent sur l’existant**, plutôt que tout réécrire. Un agent n’a pas besoin de comprendre un mainframe ; il a besoin d’une interface contractuelle, sémantiquement claire, qui abstrait la complexité sous-jacente.
- **Gouverner ces interfaces via des gateways**, pour appliquer authentification, autorisation, propagation du contexte utilisateur, rate limiting, audit, redaction des données sensibles, et désormais des contrôles spécifiques aux agents : validation des intentions, garde-fous métier, traçabilité des décisions.
- **Socialiser ces interfaces** — les rendre découvrables et utilisables — via portails et registres. Hier les développeurs e-commerce, aujourd’hui les agents et leurs concepteurs.

L’API Management que nous connaissons tous, moyennant des évolutions technologiques pour gérer les protocoles spécifiques — MCP en tête — et les nouvelles problématiques — gouvernance des prompts, observabilité des chaînes d’agents, contrôle des coûts d’inférence —, est tout à fait à même de dérisquer l’agentique. On peut même affirmer, sans excès, que l’IA agentique consacre l’omniprésence des APIs dans l’architecture d’entreprise.

## Et après les APIs ? L’événementiel

Mais les APIs ne gagnent pas seules. Il y a quelques années, les architectes ont rapidement perçu leurs limites : quand un système A interroge un système B qui interroge un système C, la panne d’un seul fait vaciller toute la chaîne. C’est pour cette raison que les architectures dites « événementielles » sont venues compléter les APIs. Le principe est simple : au lieu d’interroger en permanence chaque système pour savoir si quelque chose a changé, on se contente d’être prévenu quand un événement intéressant se produit. Résultat : plus de souplesse, plus de résilience, et la capacité à absorber des pics d’activité sans rien casser.

L’agentique suit aujourd’hui exactement le même chemin. Les agents deviennent eux aussi événementiels : ils réagissent aux événements émis par le SI — et demain par les systèmes opérationnels, capteurs IoT compris — plutôt que d’attendre d’être sollicités. Mieux : on voit apparaître des frameworks qui remplacent les flux HTTP classiques par des flux orientés messages. La conséquence est claire : les compétences event-driven, longtemps cantonnées au cercle des architectes, deviennent un prérequis pour quiconque veut industrialiser l’agentique.

## Demain, les SI parleront AI nativement

Une dernière prédiction, hautement probable : les systèmes patrimoniaux eux-mêmes vont évoluer pour devenir nativement *AI ready*. À mesure que ces systèmes seront rénovés en prenant en compte la nouvelle donne, la nécessité d’exposer des serveurs MCP par-dessus des APIs elles-mêmes posées sur des couches d’intégration plus anciennes s’estompera. Le fossé générationnel entre les équipes qui pilotent les projets AI et celles qui maintiennent le patrimoine se résorbera dans le même mouvement.

D’ici là, le message aux DSI et aux architectes est sans ambiguïté. L’ouverture du SI aux canaux digitaux a généré une dette d’intégration que beaucoup d’entreprises ont mis des années à résorber. L’IA agentique évolue plus vite encore, et la fenêtre pour poser les bons principes sera plus étroite.

Les agents ne transformeront pas l’entreprise parce qu’ils savent parler. Ils la transformeront lorsqu’ils pourront agir — sur les bons systèmes, avec les bons droits, au bon moment, et sous contrôle.

L’intégration n’est donc pas un sujet périphérique de l’IA agentique. C’en est la condition de passage à l’échelle. Si nous la traitons comme un problème d’après-coup, nous passerons la fin de la décennie à réparer ce que nous étions parfaitement équipés pour ne pas casser.