# Feature Development Workflows

This document provides detailed guidance for executing the 7-phase feature development workflow.

## Phase 1: Discovery

### When User Requests Feature

**If request is clear**:
- Restate the feature in your own words
- Confirm understanding with user
- Proceed to Phase 2

**If request is unclear**:
- Ask clarifying questions:
  - "What problem are you trying to solve?"
  - "What should the feature do?"
  - "Are there any constraints or requirements?"
  - "What does success look like?"
- Wait for answers
- Summarize understanding
- Confirm with user before proceeding

### Example Interaction

```
User: Add caching to the API
Claude: Let me understand what you need:
- What should be cached? (API responses, computed values, etc.)
- What are your performance requirements?
- Do you have a preferred caching solution?
- How long should cache entries live?

[User answers]

Claude: Got it. You want to cache API responses for 5 minutes
using Redis to improve performance for slow endpoints.
Is that correct?

User: Yes

Claude: Great, let's proceed to explore the codebase.
```

## Phase 2: Codebase Exploration

### Launching Explore Agents

Launch 2-3 explore-agent instances in parallel with different focuses:

**Agent 1**: Find similar features
```
"Find features similar to [feature name] and trace their implementation.
Focus on:
- How similar features are structured
- Patterns used for implementation
- Integration points with existing code
Return: List of similar features with file:line references and key patterns"
```

**Agent 2**: Map architecture
```
"Map the architecture and abstractions for [relevant area].
Focus on:
- Architectural layers and patterns
- Key abstractions and interfaces
- Data flow and transformations
- Dependencies and integrations
Return: Architecture diagram description, key files, and patterns"
```

**Agent 3**: Analyze related implementation
```
"Analyze the current implementation of [related feature].
Focus on:
- Entry points and call chains
- Data structures and transformations
- Error handling patterns
- Testing approach
Return: Implementation details with file:line references"
```

### Processing Agent Results

After agents return:

1. **Consolidate findings**:
   - Merge similar patterns
   - Identify key files mentioned by multiple agents
   - Note conflicting information

2. **Read key files**:
   - Read all files identified as critical
   - Take notes on patterns and conventions
   - Understand integration points

3. **Present summary**:
   - List similar features found
   - Describe architecture patterns
   - Identify key files with line numbers
   - Highlight integration requirements

## Phase 3: Clarifying Questions

### Identifying Ambiguities

Review codebase findings and feature request to identify:

**Technical ambiguities**:
- Error handling requirements
- Edge cases and boundary conditions
- Performance constraints
- Data validation needs

**Integration ambiguities**:
- How to integrate with existing systems
- Backward compatibility requirements
- Migration strategy if needed
- API surface changes

**Design ambiguities**:
- Naming conventions
- Code organization
- Abstraction level
- Testing strategy

### Presenting Questions

Organize questions logically:

```
Before designing the architecture, I need to clarify:

**Technical Requirements**:
1. [Question 1]
2. [Question 2]

**Integration**:
3. [Question 3]
4. [Question 4]

**Design Decisions**:
5. [Question 5]
6. [Question 6]

Please answer these questions so I can design the best solution.
```

### Handling User Responses

**If user answers all questions**:
- Proceed to Phase 4

**If user says "whatever you think is best"**:
- Make reasonable assumptions
- Document assumptions
- Proceed to Phase 4

**If user asks for your recommendation**:
- Provide recommendations based on codebase patterns
- Explain rationale
- Let user decide

## Phase 4: Architecture Design

### Designing Approaches

For each approach, define:

**Approach 1: Minimal Changes**
- Description: What changes are made
- Files affected: List of files to modify
- Pros: Benefits of this approach
- Cons: Drawbacks and limitations
- Risk level: Low/Medium/High

**Approach 2: Clean Architecture**
- Description: What changes are made
- Files affected: List of files to modify/create
- Pros: Benefits of this approach
- Cons: Drawbacks and limitations
- Risk level: Low/Medium/High

**Approach 3: Pragmatic Balance**
- Description: What changes are made
- Files affected: List of files to modify/create
- Pros: Benefits of this approach
- Cons: Drawbacks and limitations
- Risk level: Low/Medium/High

### Presenting Approaches

```
I've designed 3 approaches:

**Approach 1: Minimal Changes**
[Details with pros/cons]

**Approach 2: Clean Architecture**
[Details with pros/cons]

**Approach 3: Pragmatic Balance**
[Details with pros/cons]

**Recommendation**: Approach 3 - [reasoning]

Which approach would you like to use?
```

### Getting User Approval

**If user selects an approach**:
- Confirm choice
- Proceed to Phase 5

**If user asks for modifications**:
- Refine approach based on feedback
- Present updated approach
- Get approval

**If user wants hybrid approach**:
- Combine elements from multiple approaches
- Present hybrid approach
- Get approval

## Phase 5: Implementation

### Pre-Implementation Checklist

Before writing code:

- [ ] User approved architecture
- [ ] Read all relevant files
- [ ] Understand codebase conventions
- [ ] Created todo list for implementation tasks
- [ ] Identified test requirements

### Implementation Strategy

1. **Create todo list**:
   ```
   - [ ] Create new file X
   - [ ] Modify file Y
   - [ ] Add tests for Z
   - [ ] Update documentation
   ```

2. **Implement in order**:
   - Start with core abstractions
   - Implement main logic
   - Add integration code
   - Write tests
   - Update documentation

3. **Follow conventions**:
   - Use existing patterns
   - Match code style
   - Follow naming conventions
   - Use existing utilities

4. **Track progress**:
   - Mark todos as in_progress when starting
   - Mark as completed when done
   - Add new todos if needed

### Code Quality Standards

- **Simplicity**: Use straightforward logic
- **DRY**: Don't repeat yourself
- **Readability**: Clear variable names and structure
- **Documentation**: Add comments for non-obvious logic
- **Error handling**: Handle edge cases gracefully

## Phase 6: Quality Review

### Launching Debugger Agent

```
"Review the recent code changes for:
1. Bugs and functional correctness issues
2. Code quality problems (complexity, duplication)
3. Convention violations
4. Security vulnerabilities
5. Performance issues

Focus on high-confidence issues (>=80% confidence).
Return findings with file:line references and severity levels."
```

### Categorizing Issues

**Critical** (must fix):
- Functional bugs
- Security vulnerabilities
- Data corruption risks

**High Priority** (should fix):
- Performance issues
- Logic errors in edge cases
- Major code quality problems

**Medium Priority** (nice to fix):
- Minor code quality issues
- Convention violations
- Documentation gaps

### Presenting Findings

```
Code Review Results:

**Critical Issues**:
1. [Issue] - file:line - [description]

**High Priority**:
2. [Issue] - file:line - [description]

**Medium Priority**:
3. [Issue] - file:line - [description]

What would you like to do?
- Fix all issues now
- Fix critical/high priority now, medium later
- Proceed as-is
```

### Handling User Decision

**Fix now**:
- Fix all identified issues
- Re-run review if needed
- Proceed to Phase 7

**Fix later**:
- Document issues to fix
- Proceed to Phase 7
- Note issues in summary

**Proceed as-is**:
- Accept risks
- Proceed to Phase 7
- Document decision

## Phase 7: Summary

### Summary Template

```
Feature Complete: [Feature Name]

**What was built**:
- [Component 1]
- [Component 2]
- [Component 3]

**Key decisions**:
- [Decision 1]: [Rationale]
- [Decision 2]: [Rationale]

**Files modified**:
- [file1] (new/modified)
- [file2] (new/modified)
- [file3] (new/modified)

**Suggested next steps**:
- [Step 1]
- [Step 2]
- [Step 3]

**Known issues** (if any):
- [Issue 1]: [Description]
- [Issue 2]: [Description]
```

### Marking Completion

- Mark all todos as completed
- Provide final summary
- Ask if user needs anything else
- Offer to run tests or build if applicable