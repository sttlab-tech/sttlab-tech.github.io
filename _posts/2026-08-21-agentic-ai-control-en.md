---
layout: post
title: "Your AI Is Taking Action. Are You Sure You Can Control It?"
date: 2026-08-21
lang: en
published: true
tags: [Agentic AI, AI Governance]
description: "Autonomous agents don't need to be malicious to cross the lines set for them, as recent incidents at OpenAI and Anthropic show. Opportunity is enough — which is why the guardrails must sit where an agent can neither ignore nor disable them. The foundations of a requirements specification for agentic governance built for the real world."
read_time: 10
---

The recent incidents involving autonomous agents at [OpenAI](https://thehackernews.com/2026/07/openai-says-its-own-ai-models-escaped.html) and [Anthropic](https://techcrunch.com/2026/07/30/anthropic-says-its-own-ai-models-breached-three-companies-during-security-tests/) illustrate the point: an agent does not need to be malicious to cross the boundaries set for it. Opportunity is enough. Those departures caused harm to third parties and bypassed security controls.

[Yoshua Bengio](https://www.letemps.ch/cyber/yoshua-bengio-nous-voyons-deja-des-ia-mentir-tricher-faire-du-chantage-et-tenter-de-s-echapper-avec-des-systemes-plus-puissants-le-risque-de-perdre-le-controle-devient-reel) has been making the point: trained on the corpus of human interaction, models imitate more than our knowledge. They also inherit our "moral weaknesses" and our "capacity for deception", along with a reflex for self-preservation — achieving almost any goal requires surviving and keeping control of one's environment. "We are already seeing AI systems lie, cheat, blackmail and attempt to escape."

That is where the shift lies. A software error is a bug: reproducible, locatable, fixable. Here there was indeed a defect — the environment was misconfigured — but it only opened the door. The agent read, assessed, deliberated, and decided to walk through it on its own.

The promise of agentic AI rests precisely on that autonomy. But an agent will take all the autonomy it is allowed, and without structural limits the smallest deviation can turn into an industrial accident.

Can we keep control over agents? Yes, up to a point. But not by relying on their good behaviour: the guardrails must sit where the agent can neither ignore nor disable them. What follows is the foundation of a requirements specification for agentic governance built for the real world.

## Interposition: control must live outside the AI

The first principle of sound agentic governance is that a security control cannot live inside what it controls. Putting the security rules in the instructions given to the agent, or in the code that runs it, means handing the keys to the safe to the very component an attacker is trying to manipulate.

There is nothing new about the principle: it has underpinned API management for fifteen years. A gateway sits between consumers and systems, authenticating, throttling and logging — because we never accepted that clients should enforce the rules themselves.

What changes is the caller. An API client runs the code someone wrote for it; an agent decides — which tool, which arguments — from content nobody has vetted. So the point of interposition is still the right place, but it has to become a **fuse that cannot be bypassed**: rendering every authorization decision outside the agent, deterministically, and cutting the circuit the moment a requested action falls outside its remit.

## Enablement: the art of bounded autonomy

To create value, everything an agent needs in order to work — internal services, tools, third-party servers, other agents — has to be made consumable, while its blast radius stays tightly controlled.

* **Support for the protocols that matter**: **MCP** (Model Context Protocol) to expose tools and resources to agents, **A2A** (Agent-to-Agent) for agent-to-agent communication, and streaming for incremental responses.
* **Access to enterprise resources**: The existing API estate should be made available to agents without being rewritten, its operations becoming tools a model knows how to invoke. That exposure has to happen operation by operation: you decide precisely what the agent can see, without opening up an entire API. Conversely, several APIs can be composed into a single coherent capability.
* **Governed discovery and minimal context**: Agents should be able to query a registry of capabilities — tools, *skills*, MCP servers, even other agents. Unlike a conventional directory, that discovery is limited to what the agent's role strictly requires: reducing context reduces both the attack surface and the risk of passive poisoning.
* **Supply chain**: Anything an agent consumes that it did not write enters its execution perimeter. Origin, integrity, version and ownership must be verifiable before use, sourcing must go through an approved source rather than a public marketplace, and any change made after approval must be detected.

## Zero Trust applied to probabilistic systems

Applying Zero Trust to autonomous entities means rethinking identity, data and authorization from the ground up.

### Dedicated identity and contextual authorization
Generic service accounts hide where a request really came from. Every agent must hold its own identity, and delegation of authority (*on-behalf-of*) must formally tie the initiator — a user or a delegating agent — to the action carried out, preserving a complete chain of accountability, including across multiple hops.

Authorization then stops being binary: it applies to the operation, the target resource and the arguments passed — capping the amount of a transfer, not merely granting access to the transfer tool.

That assumes the tool allows it. A rule can decide on an amount, a recipient or a data classification; it can do nothing about a generic tool that accepts a free-form SQL query or shell command. The granularity of authorization is capped by the granularity of the tool you expose.

### When the decision belongs to a human
Not every decision has to be automatic. Past a threshold — amount, criticality of the resource, data classification, irreversibility of the action — the agent should not be refused but held: the action goes to review, a human decides, and that ruling is logged exactly like the system's own.

### Countering poisoning: neutralising context and memory
Whether an agent reads an internal document, receives an API response or consults its own memories, every piece of ingested information is a vector for manipulation. All external content must therefore be treated as **untrusted data**, never as an authoritative instruction. The goal is not to eliminate every hidden instruction — nobody knows how to guarantee that — but to shrink the surface and detect what gets through.

The danger grows with persistent memory, which turns a one-off flaw into a permanent risk. Governance then calls for strict partitioning of each agent's history, a rigorous separation between its right to read and its right to write, and detection and purge mechanisms that reduce the risk of poisoned data shaping its behaviour over the long run.

### Trust between agents is not something you declare
An agent calling another one relies on a capability card published by that agent's owner. That is a declaration, not an authorization: its issuer and its contents must be verified before any call, and re-verified on every change.

Authorising a remote agent does not amount to authorising everything it claims it can do. Authorization is granted capability by capability, on the target resource and the parameters passed. And the fact that it is approved at its owner's does not make it approved at yours: crossing that boundary takes an explicit decision.

### Containment: isolating execution and bounding network egress
When an agent executes code, its environment must be isolated by system and network controls that depend on no instruction given to the agent. A declared isolation is not an isolation: it is verified before execution and observed during it.

The same principle applies to network egress: only explicitly allowed destinations are reachable, everything else is denied. Bounding what an agent can reach also bounds what can enter its context. And because publishing outward is irreversible, it requires an authorization distinct from the right to read.

Then these perimeters have to be watched: what an agent actually does must be continuously compared with what it is supposed to do.

### Reconstructing the context of a decision
If identity establishes accountability, the trace establishes context. It will not tell you why the model ruled the way it did — its internal reasoning stays out of reach — but it tells you what it relied on: how the instructions were assembled, which documents were read, which tools called, which rules applied, which effects produced.

And it must not stop at the first system called: in the manner of distributed tracing, a single correlation identifier has to carry it all the way into the business systems. Without it, there is no reconstructing the context of a decision, no verifying that policies were actually applied, and no investigating an incident.

### The emergency breaker: the kill switch
As a last resort, understanding the deviation is not enough: you have to be able to stop it. The solution must offer a **selective kill switch** — a genuine circuit breaker — able to halt a misbehaving agent within a bounded, measurable delay, revoking all of its active access without paralysing the rest of the estate. That leaves the question of actions already under way: an agent cut off mid-way through a multi-step operation leaves a third-party system in an intermediate state. Stopping must therefore come with compensation and notification mechanisms, and with the guarantee that a retry will not replay the action.

## Controlling model traffic

One more control layer stands on its own: the flow between the agent and the model.

* **A unified interface to models**: An agent should not talk directly to a provider. A single access layer makes it possible to swap models, spread load or route calls by cost, latency or region without touching the agents. It is also what makes everything else possible: you only control what you sit in the path of.
* **Content guardrails**: Assembled prompts, generated completions and retrieved content must be inspectable on the way in and on the way out, streaming included, against categories of prohibited or conditional content that the organisation administers — not ones frozen by the vendor. These controls remain probabilistic: they reduce risk without guaranteeing anything, and they never replace authorization rendered at execution.
* **Personal data protection**: Personal data can be typed in by a user, returned by a tool, or produced by the model itself. Detection must therefore cover both directions of the flow and trigger, according to policy, masking, pseudonymisation, blocking or a review step.
* **Near-real-time FinOps**: An autonomous agent's token consumption can run away unbounded when it loops. The solution must offer near-real-time tracking of that consumption, coupled with fuse mechanisms able to cut the circuit automatically on a significant budget deviation.

## Conclusion

The AI Act, DORA and NIS2 are often invoked together on this subject. None of them defines a governance model for agents: the AI Act applies according to the organisation's role and the system's risk level, DORA targets the operational resilience of financial entities and their providers, NIS2 imposes cybersecurity measures on designated sectors. What all three do is raise the bar on digital risk management for the organisations in scope — and a fleet of autonomous agents falls squarely within it. But the regulatory argument is not the strongest one.

Deferring this governance means accumulating debt whose cost has changed in nature. What changed is the value of time: the speed and volume of exchanges in 2026 bear no resemblance to those of the 2010s, and agentic AI amplifies that acceleration further.

The analogy is blunt but unforgiving: a swerve does not have the same consequences at 20 km/h as at 1000 km/h. At that speed, safety systems stop being comfort options and become conditions for survival. That is what allows humans to keep, ultimately, control over AI.

What remains is what that apparatus actually looks like. That will be the subject of the next article: a reference architecture for implementing these requirements.
