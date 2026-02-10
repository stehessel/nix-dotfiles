# Coding Guidelines: Protocol Buffers

## 🚨 CRITICAL INSTRUCTION 🚨
**ALWAYS use getter functions/methods when accessing data in Protocol Buffer (protobuf) objects.** **NEVER access protobuf fields directly.**

### Rules
1.  **No Direct Field Access:** Do not access members via dot notation (e.g., `user.id`, `request.query`).
2.  **Use Generated Getters:** Always utilize the generated accessor methods (e.g., `user.getId()`, `request.getQuery()`, `msg.GetTitle()`).
3.  **Null/Nil Safety:** Leverage getters to ensure safe access, particularly in languages where getters handle null checking (e.g., Go's `GetField()` returns default values if the receiver is nil).

### Examples

#### ✅ Correct (DO THIS)
```go
// Go
id := msg.GetId() // Safely handles if msg is nil
data := resp.GetData()
```

#### ❌ Incorrect (STOP DOING THIS)
```go
// Go - BAD
id := msg.Id // Risky if msg is nil
```
