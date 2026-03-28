# AGENTS.md - OpenCode Configuration Project

This is an OpenCode AI assistant configuration directory containing configuration
files and plugins for the OpenCode CLI tool.

## Project Structure

```
.
├── opencode.jsonc           # Main OpenCode configuration
├── tui.jsonc                # Terminal UI configuration (keybinds, theme)
├── package.json             # Plugin dependencies
├── bun.lock                 # Bun lockfile
├── skills/                  # Custom skills (specialized workflows)
│   ├── git-release/SKILL.md # Release and changelog automation
│   └── ir-a/SKILL.md        # Open URLs/paths skill
└── node_modules/@opencode-ai/
    ├── plugin/              # Plugin development SDK
    └── sdk/                 # Core SDK (client, server, types)
```

## Build/Lint/Test Commands

```bash
# Install dependencies (uses Bun)
bun install

# Add a plugin dependency
bun add <package-name>

# Type check (for plugin development)
bun run --filter @opencode-ai/plugin typecheck
```

No tests in this config directory - tests would be in plugin source repositories.

## Code Style Guidelines

### Module System
- Use ES Modules (`"type": "module"` in package.json)
- Use `.js` extensions in imports even for TypeScript files
- Re-export with `export * from "./module.js"`

### Imports Organization
1. External packages first (`zod`, `@opencode-ai/sdk`)
2. Node.js built-ins with `node:` prefix
3. Type imports with `import type` where possible
4. Local imports last

```typescript
import { z } from "zod";
import { spawn } from "node:child_process";
import type { Event, Config } from "@opencode-ai/sdk";
import { tool } from "./tool.js";
```

### Formatting
- **Indentation**: 4 spaces
- **Quotes**: Double quotes for strings
- **Semicolons**: Always use semicolons
- **Trailing commas**: Use in multi-line arrays/objects

### Type Definitions
- Use discriminated unions for state/status types
- Export types alongside implementations
- Event types follow pattern: `Event{Resource}{Action}`

```typescript
export type ToolState =
    | { status: "pending"; input: Record<string, unknown> }
    | { status: "running"; input: Record<string, unknown>; title?: string }
    | { status: "completed"; input: Record<string, unknown>; output: string }
    | { status: "error"; input: Record<string, unknown>; error: string };

export type SessionStatus =
    | { type: "idle" }
    | { type: "retry"; attempt: number; message: string; next: number }
    | { type: "busy" };
```

### Naming Conventions
- **Files**: lowercase with hyphens (`my-plugin.ts`, `server-sent-events.ts`)
- **Types/Interfaces**: PascalCase (`ToolContext`, `PluginInput`)
- **Functions**: camelCase (`createOpencodeClient`)
- **Constants**: camelCase or UPPER_SNAKE_CASE for true constants
- **Hooks**: quoted string keys (`"chat.message"`, `"tool.execute.before"`)
- **Config keys**: snake_case (`small_model`, `diff_style`)

### Error Handling
- Use discriminated unions for error types
- Return error objects rather than throwing when possible

```typescript
export type ProviderAuthError = { name: "ProviderAuthError"; data: { provider: string } };
export type UnknownError = { name: "UnknownError"; data: { message: string } };
export type ApiError = ProviderAuthError | UnknownError;
```

### Configuration Files (JSONC)
- Use JSONC for configuration files
- Include `$schema` for validation
- Use snake_case for configuration keys

## Plugin Development

### Creating a Plugin

```typescript
import { Plugin, tool } from "@opencode-ai/plugin";

export const MyPlugin: Plugin = async (ctx) => {
    return {
        tool: {
            mytool: tool({
                description: "Description for the AI",
                args: {
                    param: tool.schema.string().describe("Parameter description"),
                },
                async execute(args, context) {
                    return `Result: ${args.param}`;
                },
            }),
        },
        event: async ({ event }) => {
            if (event.type === "session.created") { /* handle */ }
        },
    };
};
```

### Tool Schema (Zod)
Use `tool.schema` (Zod v4) for parameter definitions:

```typescript
args: {
    name: tool.schema.string().describe("User name"),
    count: tool.schema.number().optional().describe("Optional count"),
    format: tool.schema.enum(["json", "text"]).describe("Output format"),
}
```

### Available Hooks
- `event` - React to system events
- `config` - Modify configuration
- `tool` - Define custom tools
- `auth` - Custom authentication
- `chat.message` - Intercept messages
- `chat.params` - Modify LLM parameters
- `permission.ask` - Handle permission requests
- `tool.execute.before/after` - Tool execution hooks
- `shell.env` - Modify shell environment

### Context Properties
- `context.directory` - Project directory (prefer over `process.cwd()`)
- `context.worktree` - Git worktree root
- `context.sessionID`, `context.messageID`, `context.agent`
- `context.abort` - AbortSignal for cancellation
- `context.metadata()` - Set tool metadata
- `context.ask()` - Request permissions

## Skills Development

Skills are specialized workflows in `skills/<name>/SKILL.md`. Format:

```markdown
# Skill: skill-name

## Description
What this skill does.

## When to Use
Trigger conditions for the agent.

## Workflow
Step-by-step instructions for the agent.
```

Skills can include bundled resources in subdirectories (scripts/, templates/).

## Configuration Reference

### opencode.jsonc
- `model` / `small_model` - Default models
- `permission` - Tool permissions (ask/allow/deny)
- `agent` - Agent configurations
- `provider` - Custom provider settings
- `mcp` - MCP server configurations
- `lsp` - Language server configurations

### tui.jsonc
- `theme` - Color theme name
- `keybinds` - Custom keybindings
- `diff_style` - Diff display mode (`auto` | `stacked`)

## Dependencies

- **Bun** - Package manager and runtime
- **@opencode-ai/plugin** - Plugin development SDK
- **@opencode-ai/sdk** - OpenCode client/server SDK
- **zod** - Schema validation (v4.x)
- **TypeScript** - Type checking (v5.8+)
