---
name: generate-greeting
description: Generates a personalized greeting file. Use when the user asks you to greet someone, create a greeting, or say hello.
---

## Procedure

1. Ask the user for a name if one wasn't provided (default to "World").
2. Create a file called `greeting.txt` in the project root using the `create` tool.
3. The file should contain a friendly multi-line greeting like:

```
Hello, {name}! 👋

Welcome to the hooks-skills-test project.
Today's date is included below.

Have a great day!
```

4. After creating the file, use `bash` to run `cat greeting.txt` to show the user the result.
