---
layout: post
title: "Integration, the Blind Spot of Agentic AI"
date: 2026-06-02
lang: en
published: true
tags: [Agentic AI, Integration]
description: "Agentic AI is everywhere: in keynotes, in 2026 budgets, in roadmaps. Yet when we look closely at what current enterprise projects are actually delivering, the picture is often disappointing: most of them are, in reality, little more than improved systems of insights."
read_time: 5
---

An agent that summarizes the Q3 sales report is useful. An agent that rebalances inventory across warehouses in real time when a stockout is looming is transformative. The promise of agentic AI lies precisely in that gap — between observing and acting. And that is exactly where most projects stop today.

## The agent is only the tip of the iceberg

As long as an agent operates in a silo, disconnected from the ERP, CRM, product databases, HR tools, and logistics platforms, it cannot place an order, update a customer record, or trigger a business workflow. It observes, describes, suggests. It does not act.

In many ways, agentic AI revives the ambition of BPMS: orchestrating end-to-end business actions. But whereas BPMS required processes to be explicitly modeled, agents promise to dynamically compose actions based on an intent, a context, and a set of available tools. That is precisely what makes them powerful — and harder to govern.

The real challenge of agentic AI, therefore, is not the choice of model, nor even the sophistication of the orchestration framework. It lies in the ability to connect these agents to the enterprise’s legacy resources — core applications, data, processes — in a reliable, secure, and governed way.

Yet these resources were never designed for this. They were designed for human users, batch integrations, and identified partners. Not for autonomous agents that reason, decide, and trigger actions on the fly, at unpredictable frequencies and with sometimes ambiguous intent. Therefore, alongside the construction of the agents themselves, enterprises must rethink how their information systems are exposed: making these resources accessible to agents, *while* strictly controlling their use.

## A familiar pattern

When enterprises opened their information systems to digital channels — e-commerce, mobile, partners — the same question emerged: *how do we securely and governably connect these new touchpoints to the legacy information system?* Back then, everyone was talking about REST APIs. Today, everyone is talking about MCP servers and *tools*. MCP, for *Model Context Protocol*, aims to standardize this new entry point for agents into the legacy information system: access to tools, data, applications, and business processes.

History repeats itself. The fear of being disrupted pushes enterprises to innovate faster than they would like, often taking shortcuts — usually without realizing it — that create technical debt at best, and major operational and security risks at worst. The anti-patterns are the same as before, but they take on a new form in agentic PoCs:

- **Data made accessible to an agent — and therefore potentially to its user — that should not be accessible**, because access controls have not been adapted to this new mode of interaction.
- **Backends brought to their knees** by bursts of calls from overly curious agents, when existing systems had been sized for human usage or predictable application flows.
- **Sequences of actions that are individually authorized but collectively risky**: checking inventory, changing a priority, triggering a transfer, notifying a customer — all legitimate actions which, when combined without business guardrails, can produce an unintended outcome.

## Yesterday’s recipes still work

The good news is that the principles established to address the challenges of digital channels remain perfectly valid for agentic AI:

- **Expose interfaces that build on the existing estate**, rather than rewriting everything. An agent does not need to understand a mainframe; it needs a contractual, semantically clear interface that abstracts the underlying complexity.
- **Govern these interfaces through gateways**, in order to enforce authentication, authorization, user-context propagation, rate limiting, audit, sensitive-data redaction, and now agent-specific controls: intent validation, business guardrails, decision traceability.
- **Socialize these interfaces** — make them discoverable and usable — through portals and registries. Yesterday, for e-commerce developers; today, for agents and their designers.

The API Management we all know, with the necessary technological evolutions to handle specific protocols — MCP foremost among them — and new concerns — prompt governance, observability of agent chains, inference cost control — is fully capable of de-risking agentic AI. One could even say, without exaggeration, that agentic AI confirms the omnipresence of APIs in enterprise architecture.

## And after APIs? Event-driven architecture

But APIs do not win alone. A few years ago, architects quickly recognized their limits: when system A queries system B, which queries system C, the failure of a single component can destabilize the entire chain. This is why so-called “event-driven” architectures emerged to complement APIs. The principle is simple: instead of constantly querying every system to find out whether something has changed, you are simply notified when an interesting event occurs. The result: more flexibility, more resilience, and the ability to absorb spikes in activity without breaking anything.

Agentic AI is now following exactly the same path. Agents are becoming event-driven too: they react to events emitted by the information system — and tomorrow by operational systems, including IoT sensors — rather than waiting to be prompted. Better still, we are seeing frameworks emerge that replace traditional HTTP flows with message-oriented flows. The consequence is clear: event-driven skills, long confined to the world of architects, are becoming a prerequisite for anyone who wants to industrialize agentic AI.

## Tomorrow, information systems will speak AI natively

One final, highly probable prediction: legacy systems themselves will evolve to become natively *AI ready*. As these systems are modernized to reflect the new reality, the need to expose MCP servers on top of APIs, themselves layered over older integration stacks, will gradually fade. The generational gap between the teams driving AI projects and those maintaining the existing estate will narrow at the same time.

Until then, the message to CIOs and architects is unambiguous. Opening the information system to digital channels created integration debt that many enterprises took years to pay down. Agentic AI is moving even faster, and the window to establish the right principles will be narrower.

Agents will not transform the enterprise because they can talk. They will transform it when they can act — on the right systems, with the right permissions, at the right time, and under control.

Integration is therefore not a peripheral topic in agentic AI. It is the condition for scaling it. If we treat it as an afterthought, we will spend the end of the decade fixing what we were perfectly equipped not to break.