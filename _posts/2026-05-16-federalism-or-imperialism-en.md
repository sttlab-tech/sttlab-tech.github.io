---
layout: post
title: "Modern IS governance: chosen federalism or imposed imperialism?"
date: 2026-05-16
lang: en
published: true
tags: [governance, federalism, sovereignty]
description: "Agile organizations and distributed architectures conquered the 2010s in the name of time-to-market. But the tightening environment — regulatory, economic, geopolitical — now demands more control. Federalism reconciled autonomy and unity in the political order: does it offer the same synthesis for information systems? Or are we heading toward an imperialist model, mirroring the world we live in today?"
read_time: 5
---


## The decade of autonomy

The 2010s were a decade of deliberate dispersion. Under the pressure of time-to-market and quality of service, companies dismantled their monoliths: autonomous teams, microservices, distributed ownership. More decoupling meant more speed — and speed was the competitive weapon. The model held as long as the cost of disorder stayed below the gain in velocity.

## The shift in context

That calculation reversed in the early 2020s, with COVID acting as a catalyst: it put **cost rationalization** back at the center of trade-offs and exposed the fragility of digital supply chains. What followed was a **regulatory inflation** that has become structural — DORA, NIS2, the Cyber Resilience Act, the AI Act — demanding traceability and risk control that dozens of fully autonomous teams cannot guarantee spontaneously. To this is added a **digital war** — data sovereignty, state-sponsored cyberattacks — that turns every extended information system into a surface to defend.

How do we keep the agility won in the 2010s while reintroducing the control the 2020s demand? Recentralizing would be a costly regression. We need another form.

## Federalism as a synthesis

That form exists in political science: federalism. Federated states retain broad autonomy, but within a common framework — a constitution that sets the **non-negotiable rules**, and **shared infrastructures** that no single state would build alone.

Transposed to the information system, the parallel is direct. The constitution is the set of IT standards: security, observability, compliance, interoperability. Autonomy is the freedom left to teams on everything that does not touch that foundation. The common infrastructures are the pooled capabilities: the network and its segmentation, the security foundation — identity, secrets and certificate management —, the exchange and observability platforms, the CI/CD tooling. Foundations it would be absurd — and risky — to reimplement in every team.

Two practices in particular embody this technical federalism.

- **Control-plane architectures**: the control plane centralizes policy while the data plane stays distributed — the rule is common, supervision is centralized, but execution stays local, exactly like federal law applied by the states.
- **Platform engineering**, which materializes the common infrastructures into *paved roads*: tooled, secure and compliant-by-construction paths, complemented by self-service capabilities that make autonomy real without making it anarchic.

## The platform must earn its users

We have to be lucid: IT federalism fails often. A poorly designed platform recreates the very bottleneck it claimed to remove — the paved road becomes mandatory, no one takes it willingly, teams route around it. You then get the worst of both worlds: the slowness of centralization without the promised coherence.

The principle that separates success from failure fits in one sentence: the platform must earn its users. Adoption is not decreed, it is won. A paved road is only legitimate if it is objectively easier, faster and safer than the alternative. If it is, compliance becomes a side effect of taking the simplest path. 

## The great return of empires

A question of scale remains. The geopolitical movement of the 2020s is not just a return of control: it is the great return of empires — vast, integrated wholes that offer **stability and protection in exchange for deep integration**.

The analogy imposes itself: the hyperscalers. They deliver, at planetary scale, what no single organization would produce alone. Are they the culmination of the federal model, or do they offer something else, something closer to imperialism?

This is not a value judgment. There are empires where peoples prosper, and deep integration is not an evil in itself. The criterion that distinguishes federalism from imperialism is neither the degree of control nor the quality of service: it is **reversibility**. A federated state retains, in principle, a right of secession; a subject of empire does not. The real question to ask the hyperscalers is therefore not "is their service good?" — it often is — but "can I still leave?". Is there still an exit, a bearable exit cost, a real freedom of choice?

It is a question of **sovereignty**. It is up to the organization to lay down its constitution — its standards of security, interoperability, portability — and up to the hyperscaler to comply with it as a mere provider of common infrastructures. Failing that, it is no longer a sovereign state, but a subject of empire.
