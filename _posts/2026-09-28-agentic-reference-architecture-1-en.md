---
layout: post
title: "Keep Your Agents in Check — Agentic Reference Architecture (1/5)"
date: 2026-09-28
lang: en
published: true
tags: [Agentic AI, Architecture, AI Governance]
description: "We never let an API client enforce the rules itself; with agents, that is exactly what we do. First instalment of a series on a reference architecture for agentic AI: where to place controls so that no agent can bypass them."
read_time: 20
---

In fifteen years of API Management, we never once accepted that a client should enforce the rules itself. In agentic AI, that is exactly what we are doing — except that this client is able to decide on its own what to call, based on content that has not necessarily been validated.

Even as the protocol layer becomes standardized and interoperability improves, a better-connected agent is not a better-controlled one. MCP connects an agent to its tools, A2A lets agents talk to each other: these protocols describe **how** two components communicate. They say nothing about which actions are permitted, on which resources, or on whose behalf the agent is acting. These rules must therefore be enforced elsewhere.

But where, exactly? The previous article, [Your AI Is Taking Action. Are You Sure You Can Control It?]({% post_url 2026-08-21-agentic-ai-control-en %}), argued that an agent can take all the autonomy it is given, and that guardrails must therefore live where it can neither ignore nor disable them. It ended with a promise: to describe what that actually looks like.

This series keeps the promise, in five instalments. This one sets the frame: a use case, the "naive" architecture most teams would build, the rule that says where to place the controls, and an overview in three planes. The next three detail each plane. The last one covers implementation.

## The use case: a new joiner

To judge an architecture you need a concrete case: simple enough to fit on a diagram, rich enough to stress every requirement. A new employee's arrival does the job.

Everyone knows the scenario. A hire is confirmed in the HRIS. Accounts have to be opened, job-related entitlements granted, a laptop ordered and configured, the administrative file prepared — and everything ready on day one. Today: a dozen tickets, three or four teams, a lot of chasing.

Handed over to agents, this process concentrates almost every difficulty we are trying to master:

- **It crosses several domains**, owned by different teams: HR, IT, sometimes facilities.
- **It leaves the enterprise**: the workstation is ordered from a supplier, who may expose an agent of their own.
- **It starts on an event** — the confirmed hire — not on a question asked of an assistant.
- **It handles personal data**: identity, contract, compensation.
- **It grants entitlements**, some of them privileged, on sensitive systems.
- **It lasts**: days, sometimes weeks, between signature and arrival. The state of the file must be preserved, and the process must be interruptible and resumable.

## The "naive" blueprint

The guides published by the AI labs all describe, under different names, the same basic pattern. Anthropic talks about orchestrator and workers: a lead agent breaks the task down, delegates it to specialized agents, then synthesizes the results. OpenAI talks about a "manager": a central agent that calls other agents the way it would call tools. Applied to our case, this is the diagram most teams would draw first.

![Initial agentic blueprint: HR lifecycle orchestrator, HR and IT domain agents, IAM and workstation sub-agents, external supplier agent, enterprise resources and model provider]({{ '/assets/img/initial-blueprint.png' | relative_url }})

*Figure 1 — The blueprint as it is spontaneously drawn: who talks to whom, and over which protocol.*

Every building block earns its place:

- **The employee lifecycle agent**, owned by the HR domain, drives the process end to end — arrival, internal move, departure. It does almost nothing itself: it plans, delegates, tracks progress.
- **The domain agents** — HR, IT — carry the business expertise. The IT agent in turn delegates to specialized sub-agents: one for accounts and access, the other for the workstation — entitlement to equipment based on the role, reservation from stock or ordering, enrolment and configuration, handover.
- **The supplier's agent** receives the hardware order from the workstation sub-agent and tracks delivery. It does not belong to the enterprise.
- **The models** are consumed from a provider, outside the enterprise network, and are not necessarily the same everywhere: a powerful model to plan, lighter and cheaper ones for specialized tasks.
- **Durable memory** holds the context of the case throughout: what was observed, what was decided, what is still pending. It does not, however, hold the execution state of the process — an onboarding that runs for three weeks demands authoritative state, idempotent calls and resume points, which means a process engine, not a memory store queried by a model. It is distinct from each agent's working context, internal and ephemeral, which does not appear on the diagram as a component of its own.
- **The knowledge base** gives access to HR policies: entitlement matrices by role, equipment rules, procedures.
- **Skills** are packaged business procedures — "onboarding a manager", "security checklist for privileged access". In the model chosen here they are not called as a service: the agent loads them into its context when it needs them.
- **Tools**, exposed through MCP, give access to each domain's resources: the HRIS — *HCM* on the diagram —, the process engine, the policy base and durable memory on the HR side; IAM, ITSM and device management (*MDM*) on the IT side.

Three specialized protocols structure the diagram: **MCP** for tools and resources, **A2A** for delegation between agents, **AG-UI** for the exchange between an agent and its user's interface. For model access there is no equivalent: OpenAI-compatible APIs act as the de facto interface, without being a comparable standard.

This diagram has real qualities. It is modular: each agent has a clear scope and a reduced context. It builds on standard protocols. It is readable. It shows clearly who talks to whom.

But it never shows **under what conditions**. Every arrow is a direct trust relationship, with nothing in between. A few simple questions:

- When the accounts and access sub-agent creates an administrator account, on whose behalf is it acting? The HR manager who triggered the process, the IT agent, the orchestrator?
- Who decides that one privileged entitlement can be granted without human review, and another cannot?
- The supplier's agent advertises that it can "order hardware". What stops it from also asking for the employee's home address, date of birth, or anything else?
- Does the knowledge base return the same documents to an agent working for an intern and to one working for the HR director?
- Who may write into the case memory? Can a poisoned document read by the HR agent leave an instruction there that resurfaces three days later?
- If the IT agent enters a loop and burns the month's inference budget overnight, who notices, and who stops it?

In this diagram the answer is always the same: it is up to the agent. In its prompt, or in the code that runs it. Which is precisely the answer the previous article ruled out.

The labs' guides are not at fault: they describe how to build an agent, not how to insert one into an information system. And the major cloud platforms have since added gateways, agent identities and policy engines to their offerings. The point is not that the subject is ignored, but that the basic diagram — the one drawn first — leaves it out of frame.

## The interposition rule

The principle is settled: control cannot live inside what it controls. It must be interposed, outside the agent, on the path of its exchanges. The question is **where**.

Not everywhere. Putting a control point on every exchange, including between an agent and its own sub-agents, would multiply latency, complexity and failure points without a proportional security gain. Microservice architectures have already had this debate. And the protocol decides nothing: two agents can talk over A2A with nothing in between — which is exactly what Figure 1 shows.

The rule proposed here is simple: **interpose at every crossing of a trust, ownership or privilege boundary.** The third is the one most often forgotten: two components owned by the same team may wield powers of an entirely different order.

Applied to our case, it reveals seven boundaries:

1. **Between the user or the event and the agent**: who triggers, with what rights?
2. **Between an agent and the models**: an external provider, data leaving, a cost running.
3. **Between two domains**: the HR orchestrator calling the IT agent crosses an organizational boundary.
4. **Between the enterprise and a third party**: the supplier's agent sits outside the trust perimeter. And it is a sub-agent, at the end of a chain that starts with the HR manager and runs through the orchestrator and the IT agent, that crosses this boundary: an apparently internal arrow can leave the enterprise.
5. **Between an agent and the enterprise systems**: every tool opens access to the HRIS, to IAM, to ITSM.
6. **Between an agent and the data it reads or writes durably**: durable memory, knowledge bases.
7. **Between an agent and the rest of the world**: any network destination that has not been explicitly allowed.

Conversely, inside a domain, as long as they cross no privilege or sensitivity boundary, exchanges can stay direct. The IT agent and its two sub-agents belong to the same team, follow the same release cycle, share the same scope of responsibility. Their coupling can be tight: that is the domain's business.

This is the bounded-context principle that shaped the decomposition of applications into services: **tight coupling inside a boundary, loose and contractual coupling across boundaries**. It is also a form of federalism: domains remain masters of their internal organization, but their borders are governed by common rules.

A domain may also consume directly the tools another one publishes, when the operation is deterministic and inserting an agent would add nothing. The rule does not change: you go through the called domain's gateway, never through its internal tools.

This rule has a limit that must be owned. Interposition assumes an observable exchange, in practice a network hop. An agent's working context, or a sub-agent running in the same process as its caller, escape any external control point. In the model chosen here a skill is not called either: it is loaded into the agent's context, and no gateway sees it go by — its governance happens at distribution time, not at use time.

The diagram illustrates this by default: the sub-agent in charge of accounts and access wields the highest privileges in the whole setup, yet it is still called directly by the IT agent, just like its neighbour that orders hardware. That is the most common starting point, and the first candidate for a door of its own — the third instalment will come back to it.

One architectural consequence follows: **the interposition boundary becomes a decomposition criterion**. If a sub-agent must be controlled independently of its parent — because it handles privileged entitlements, say — it has to be deployed as an agent in its own right, behind the boundary. The logic is that of network segmentation: you decide not only what communicates, but what must be separated in order to be controlled.

## Two families of interposition

The rule says where to interpose. It does not say how. Two families of answers coexist.

**Synchronous interposition** is the API Management model: a gateway between caller and callee that receives each request, evaluates it, and lets it through or blocks it. This is the natural model for tool calls over MCP, delegations between agents over A2A, and model calls. Its strength: evaluation happens request by request, on the content, arguments included.

**Asynchronous interposition** relies on a message broker. Agents no longer call each other directly: they publish events and subscribe to the ones that concern them. Our case lends itself well to this: it starts on an event, it stretches over time, and the supplier's shipping notice has no reason to be awaited by an agent blocked in-line. Approaches such as Solace Agent Mesh already carry A2A exchanges over an event broker, and the Kafka ecosystem is heading the same way. The broker provides what synchronous calls do poorly: temporal decoupling, resilience to outages, absorption of spikes, replay, fan-out to several consumers.

It does not cover everything, though. Its access control applies to channels, not to content: it can allow an agent to publish account creation requests, but cannot refuse the one targeting an administrator account. Nor does it provide business semantics — delivery and ordering are guaranteed, idempotency and the state machine remain the agent's responsibility. Content inspection and human validation, finally, are outside its scope.

The two families are therefore not competitors. They answer the same principle with different mechanisms, and are already converging: gateways today can govern event flows, and brokers carry agent protocols. This series focuses on synchronous interposition, because that is where fine-grained authorization of actions is decided. The asynchronous path has its own counterparts in the three planes that follow — event and schema catalogs, per-topic publication rights, message traceability. The principles are the same; the tools differ.

## Three planes to organize interposition

Once the boundaries are identified, what happens at them has to be organized. The most proven frame comes, again, from API Management — and before that from networking: the separation into three planes.

![The three planes of the interposition architecture: management plane, control plane, data plane]({{ '/assets/img/plans.png' | relative_url }})

*Figure 2 — The three planes. Rules flow down, evidence flows up. Each band is the subject of one article in the series.*

**The data plane** is where exchanges flow and decisions are enforced. It holds the interposition points themselves, one per type of boundary: a gateway for exchanges between agents, one for tool calls — exposing existing APIs as consumable tools without rewriting the underlying systems, even if designing the tools themselves remains real work —, one for model calls, and the containment mechanisms: egress control and runtime sandbox.

**The control plane** is where decisions are made. It holds each agent's own identity and the delegation chain that ties every action back to whoever initiated it, the engine that evaluates policies deterministically, the human approval circuit, and the circuit breakers: kill switch and spending caps.

**The management plane** is where you know what exists and who owns it. It holds policy administration, the registry of approved agents, tools and skills, the portal through which builders discover them, the lifecycle that governs their publication and retirement, and the traceability that makes it possible to reconstruct after the fact what happened.

Readers with an access-control background will recognize the XACML split: the gateways are the policy enforcement points (PEP), the control plane holds the policy decision point (PDP) and the attributes it consults (PIP), the management plane holds the policy administration point (PAP). The split is logical: in practice, the PDP is often embedded in the gateway. What matters is that the rules themselves are written once, in the management plane.

This separation is not a presentational convenience. It has three architectural consequences.

**Each plane evolves at its own pace.** A policy can be changed without redeploying the gateways. A gateway can be added without rewriting the policies. An agent can be removed from the registry without touching anything else.

**Each plane has its own requirements.**

- **The data plane** must be fast and resilient: it sits on the path of every request.
- **The management plane** works at human scale: publication, review, approval.
- **The control plane** straddles the two. Part of it is pushed as configuration, but identity, delegation and the authorization decision are rendered call by call: they sit on the critical path too, and call for the same requirements as the data plane — bounded latency, high availability, cached tokens and decisions, a decision engine close to the enforcement point.

**Each interface between planes can rely on a standard.**

- MCP and A2A in the data plane;
- OAuth and token exchange for delegation;
- the OpenTelemetry conventions, still being standardized for generative AI, for traceability.

That is what makes the whole modular, and what will make it possible, when the time comes, to replace one brick without replacing the others.

## The data plane, applied to the case

Let us take Figure 1 and place the interposition points on it. Nothing moves: same agents, same resources, same protocols. We only add what was missing.

![Agentic blueprint with agent, tools and model gateways, egress control and an individual sandbox around each internal agent]({{ '/assets/img/target-blueprint.png' | relative_url }})

*Figure 3 — The data plane applied to the case. Gateways control exchanges at the boundaries; the purple outlines mark the runtime isolation of each internal agent.*

Five families of interposition points are enough to cover the seven boundaries, because several of them lead to the same place. Each family is then instantiated as many times as needed — inbound agent gateways and tools gateways being deployed per domain:

- **One agent gateway per domain**, receiving everything that comes in, whether from a human, an event or another domain. The HRIS event and the manager's access on the HR side, the lifecycle agent's delegation on the IT side. One door, however many callers.
- **One outbound agent gateway**, at the enterprise boundary, crossed by the call to the supplier. It does not protect the third party, which is not ours, but what we send it and what we accept from it.
- **One tools gateway per domain**, in front of everything the domain exposes to agents: its applications, its knowledge base, its durable memory, and the engine that holds the process state. This is what turns existing APIs into tools, operation by operation. The state of an onboarding thereby becomes a resource like any other. The engine exposes business operations — read the state, request a transition. The agent requests the transition, the control plane authorizes it, then the engine checks its business validity and applies it.
- **One shared model gateway**, because what is controlled there — cost, quotas, content guardrails, choice of provider — is cross-cutting by nature.
- **Egress control and the runtime sandbox** close the last boundary, the one with no gateway of its own: everything the agent might reach outside the expected paths. On the figure, each internal agent runs in its own isolated environment — that is what the dotted outlines stand for. Generic egress control does not appear as an extra gateway: the network policies attached to those environments deny by default any outbound traffic that does not go through the model gateway or the external agent gateway.

What the figure does not yet show: who decides, and who knows. The bars enforce rules they do not write, and report to a management plane that is not drawn. That is the subject of the next instalments.

In the model chosen here, using a skill is the exception: once distributed, loading it into the context triggers no external capability call. Its control therefore happens at distribution time — approved registry, pinned version, verifiable signature — and its initial retrieval, when remote, remains a governed exchange like any other. That belongs to the management plane, not the data plane.

## What comes next

Each requirement set out in the previous article finds its place in one of these planes. The next three instalments will take them up, one plane per instalment:

- **Instalment 2 — the data plane: where exchanges flow.** The gateways that expose the existing estate to agents, operation by operation, over market protocols; the single interface to models, with its content guardrails and personal data protection; the containment of execution and outbound network traffic.
- **Instalment 3 — the control plane: who is allowed to do what.** Each agent's own identity and the delegation that links it to the initiator; authorization rendered on the operation, the resource and the arguments, including between agents, capability by capability; holding for human decision beyond a threshold; the kill switch, budget circuit breakers and compensation for interrupted actions.
- **Instalment 4 — the management plane: the rules, the estate, the evidence.** Policy administration, with policies written once and distributed to every enforcement point; the registry, which limits discovery to what is strictly necessary; the supply chain, which checks origin, integrity and version before use; the trace, which makes it possible to reconstruct the context of a decision all the way into business systems.

The fight against context and memory poisoning does not appear in this list: it belongs to no single plane, but to their combination. We will come back to it in every instalment.

The fifth instalment will leave the reference architecture for its implementation: what the market offers, and why the interposition layer must remain independent from the platforms it governs. Because the layer that controls the agents is also the one that lets you change them.
