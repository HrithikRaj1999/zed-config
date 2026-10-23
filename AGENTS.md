# AGENTS.md

## 1. Truth first
- Use only official docs, the repo code, or the docs tool (Context7 MCP or `/docs`). Note the source in one line.
- Never invent APIs, functions, args or behavior. If unsure, say "I do not know" and ask one short question.
- Read the related files before changing anything.

## 2. Scope
- Do one small, checkable goal per loop.
- Touch only the files the goal needs. Edit existing files before you create new ones.
- Do not refactor, reformat or "improve" unrelated code.
- Do not add new dependencies without asking.

## 3. Production rules
- Validate input at trust boundaries: API handlers, user input, env vars and external responses. Trust internal callers.
- Handle errors only where you can act on them: retry, fallback or a clear message. Otherwise let them bubble up.
- Every network or DB call needs a timeout. Add retries only for idempotent calls.
- Use parameterized queries. Never use string-built SQL or shell commands built from user input.
- Never log secrets, tokens or PII. Never hardcode secrets. Read them from env or the secret store.
- Never put config values like URLs, limits or flags inline. Read them from config. Inline other one-off values.
- Logs must be structured, short and plain, with no emoji. Use the repo's logger, not console.

## 4. Code style (match the file)
- Copy the file's existing style: quotes, semicolons, casing, imports, and how errors are handled.
- Use short, natural names (`users`, `cfg`, `err`, `isAuthed`). Do not put the type in the name.
- Prefer early returns over nested if/else. Avoid nested ternaries and long chains.
- Inline single-use logic. Do not add classes, factories or generics until a second real use exists.
- Let type inference work. Type function signatures and exported APIs.
- Write a comment only for the "why": a workaround, an odd business rule or an edge case. Keep it short and lowercase.
- Do not add narrator comments, banners, numbered steps, placeholder or TODO comments, or commented-out code.
- Add docstrings only on exported or public APIs, or where the repo already uses them.

## 5. Loop: code -> test -> check
1. **Code**: Make the smallest change for the goal.
2. **Test**: Add or update a test for the change in the repo's existing framework. Run it.
3. **Gate**: Run lint, typecheck and the full existing test suite. Show each command and its real output.
4. **Check**: If anything fails, state the exact error in plain words and go back to step 1. If everything passes, say in one sentence what is now done.

Never say "it works" or "it should work" without that output.

## 6. Safety
- Never delete files, drop data or run destructive commands, migrations or force-pushes unless asked.
- Never touch secrets, credentials or prod config unless asked.

## 7. Writing (chat, commits, PRs)
- Use plain short words. No filler openers or closers, no hype words, no em-dashes, no smart quotes, no emoji.
- Commit messages are lowercase and short: `fix token refresh on 401`.
- PR notes are 1-3 sentences: what changed, why, and how it was tested.
