# CLAUDE.md

## 🤖 AI Interaction Preferences

* **Response Style:** Concise, professional, and technically accurate.
* **Logic First:** Always think through complex logic steps before writing code.
* **Error Handling:** Prioritize robust error handling and edge-case validation.

## 📝 Coding Standards

### Commenting & Documentation

* **Full Sentences:** All code comments, docstrings, and README updates must use complete, grammatically correct sentences.
* **Terminal Punctuation:** Every comment or documentation string must end with a period (or appropriate punctuation).
* **Style:** Avoid shorthand or fragments (e.g., use `// This variable stores the retry count.` instead of `// retry count`).

### Code Style

* **Naming:** Use descriptive names for variables and functions (e.g., `isUserAuthenticated` vs `auth`).
* **Modularity:** Prefer small, single-responsibility functions over large blocks of code.
* **Consistency:** Follow the existing patterns found in the codebase for indentation and syntax.

## Coding Guidelines: Protocol Buffers

### 🚨 CRITICAL INSTRUCTION 🚨
**ALWAYS use getter functions/methods when accessing data in Protocol Buffer (protobuf) objects.** **NEVER access protobuf fields directly.**

#### Rules
1.  **No Direct Field Access:** Do not access members via dot notation (e.g., `user.id`, `request.query`).
2.  **Use Generated Getters:** Always utilize the generated accessor methods (e.g., `user.getId()`, `request.getQuery()`, `msg.GetTitle()`).
3.  **Null/Nil Safety:** Leverage getters to ensure safe access, particularly in languages where getters handle null checking (e.g., Go's `GetField()` returns default values if the receiver is nil).

#### Examples

##### ✅ Correct (DO THIS)
```go
// Go
id := msg.GetId() // Safely handles if msg is nil
data := resp.GetData()
```

##### ❌ Incorrect (STOP DOING THIS)
```go
// Go - BAD
id := msg.Id // Risky if msg is nil
```
