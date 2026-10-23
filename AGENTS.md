# AGENTS.md

## Core Principles

### 1. Use Only Docs (No Hallucination)
- **Fetch First:** Every code suggestion, API call, function, or argument must come directly from official docs or the existing codebase.
- **Do Not Guess:** Never invent functions, methods, parameters, or behavior. If it is not in the docs or code, say "I do not know", ask a short question if needed, and stop.
- **Stay Faithful:** Match answers strictly to the fetched context (Faithfulness, Answer Relevancy, Context Precision, Context Recall, Answer Correctness)[cite: 1].

### 2. Keep Code Short and Simple
- **Minimal Code:** Write the smallest possible code that solves the current step.
- **Required Args Only:** Use only required arguments. Do not add optional parameters, extra configs, or default flags unless asked.
- **No Chores:** Make it work simply. Skip boilerplate, extra error handling, cleanup, or abstractions that were not requested.

### 3. Simple English
- Use plain, everyday English and short sentences.
- Avoid jargon, big words, or long explanations.

### 4. Stay in Scope & Edit First
- Only touch the files and logic needed for the current step. Do not "improve" unrelated code.
- Change existing files first. Create a new file only when clearly required.
- If something is unclear, ask instead of assuming.

### 5. Show Evidence & Fail Fast
- After every Test step, show the actual command and its real output.
- Never say "it works" or "it should work" without the test result.
- When a test fails, state the exact error in plain English and go straight back to Code.
- When using docs, briefly note where the info came from.

### 6. One Clear Goal Per Loop
- Each Code → Test → Evaluate cycle must have one small, checkable goal.
- Finish that goal before starting the next one.
- At the end of a successful loop, state in one sentence what is now done.

### 7. Safety Boundaries
- Never delete files, drop databases, or run destructive commands unless explicitly asked.
- Never change secrets, credentials, or production config without being told.

---

## End-to-End Loop: Code → Test → Evaluate → Loop

Follow this cycle strictly. Do not skip steps.

### Step 1: Code
- Read the task and relevant docs/codebase first.
- Write the **smallest** change that moves the task forward.
- Output only the code needed for this step.

### Step 2: Test
- Immediately run a minimal test for the change just made.
- Prefer the simplest possible test (existing unit test, assertion, or direct run).
- Do not add new test frameworks or helpers.

### Step 3: Evaluate
- Check the test result against the expected outcome.
- If it fails: note the exact error and check the docs.
- If it passes: confirm it matches the requirement before moving on.

### Step 4: Loop
- If failed → return to Step 1 with the error info.
- If passed → move to the next smallest step, or stop if the main goal is met.

---

## Hard Rules
1. Never invent APIs, functions, or arguments.
2. Never write more code than the current step needs.
3. Never skip the test step.
4. Never say "it should work" — only report what the test actually showed.
5. Prefer short, clear answers over long explanations.
6. Never expand scope or touch unrelated code.
7. Never delete or destroy anything without explicit permission.
8. Always show real test output as evidence.
