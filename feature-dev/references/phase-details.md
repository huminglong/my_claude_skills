# Phase Details and Examples

This document provides detailed explanations and examples for each phase of the feature development workflow.

## Phase 1: Discovery - Detailed Examples

### Example 1: Clear Request

```
User: Add rate limiting to the API endpoints

Claude: Got it. You want to add rate limiting to API endpoints
to prevent abuse and ensure fair usage.

To confirm:
- Rate limit API endpoints
- Prevent abuse and ensure fair usage
- Need to determine rate limits and implementation approach

Is that correct?

User: Yes

Claude: Great, let's proceed to explore the codebase.
```

### Example 2: Unclear Request

```
User: Add caching

Claude: Let me understand what you need better:

**What should be cached?**
- API responses?
- Computed values?
- Database queries?
- Something else?

**What are your performance requirements?**
- How much speed improvement do you need?
- Are there specific slow operations?

**Do you have a preferred caching solution?**
- In-memory (Redis, Memcached)?
- File-based cache?
- Browser cache?

**How long should cache entries live?**
- Seconds? Minutes? Hours?

Please provide more details so I can design the right solution.

User: We need to cache API responses for 5 minutes to help with
slow endpoints

Claude: Got it. You want to cache API responses for 5 minutes
using Redis to improve performance for slow endpoints.

Is that correct?

User: Yes

Claude: Great, let's proceed to explore the codebase.
```

## Phase 2: Codebase Exploration - Examples

### Example: Finding Similar Features

**Agent Prompt**:
```
Find features similar to "rate limiting" in this codebase.
Focus on:
- How similar features are structured
- Patterns used for implementation
- Integration points with existing code
- Middleware or decorator patterns
- Configuration approach

Return:
- List of similar features with file:line references
- Key patterns used
- Integration requirements
```

**Expected Agent Output**:
```
Found similar features:

1. Authentication middleware (src/middleware/auth.ts:12-45)
   - Uses middleware pattern
   - Checks request headers
   - Returns 401 on failure
   - Configurable via environment variables

2. CORS handling (src/middleware/cors.ts:8-30)
   - Middleware pattern
   - Checks request origin
   - Returns 403 on forbidden origins
   - Configuration in config/cors.ts

3. Request logging (src/middleware/logger.ts:5-25)
   - Middleware pattern
   - Logs all requests
   - No filtering

Key patterns:
- Middleware functions in src/middleware/
- Configuration in src/config/
- Use of Express middleware pattern
- Error handling via next()

Files to read:
- src/middleware/auth.ts - Middleware pattern reference
- src/config/security.ts - Configuration pattern
- src/app.ts - Middleware registration
```

### Example: Mapping Architecture

**Agent Prompt**:
```
Map the architecture for API request handling.
Focus on:
- Request flow from entry to response
- Middleware layers and order
- Error handling approach
- Configuration management
- Dependencies

Return:
- Architecture diagram description
- Key files and their responsibilities
- Data flow
- Integration points
```

**Expected Agent Output**:
```
Architecture for API request handling:

Request Flow:
1. Entry: src/app.ts (Express app)
2. Middleware chain (in order):
   - src/middleware/logger.ts (logging)
   - src/middleware/cors.ts (CORS)
   - src/middleware/auth.ts (authentication)
   - src/middleware/rate-limit.ts (rate limiting - to be added)
3. Route handlers: src/routes/*.ts
4. Response: Sent back through middleware

Key Files:
- src/app.ts:12-50 - Express app setup, middleware registration
- src/middleware/*.ts - Individual middleware implementations
- src/config/*.ts - Configuration files
- src/routes/*.ts - Route handlers

Configuration Pattern:
- Environment variables in .env
- Configuration objects in src/config/
- Typed via TypeScript interfaces

Error Handling:
- Try-catch in route handlers
- Error middleware at end of chain
- src/middleware/error.ts:15-40

Integration Points:
- Add new middleware to src/app.ts:25-35
- Configuration in src/config/rate-limit.ts
- Use existing error handling pattern
```

## Phase 3: Clarifying Questions - Examples

### Example: Rate Limiting Questions

```
Before designing the rate limiting architecture, I need to clarify:

**Rate Limits**:
1. What are the rate limits? (e.g., 100 requests per minute)
2. Should limits differ by endpoint or user role?
3. Should limits be per-IP, per-user, or per-API-key?

**Behavior**:
4. What happens when limit is exceeded? (429 error, queue, etc.)
5. Should rate limit headers be included in responses?
6. How should rate limits be reset? (sliding window, fixed window?)

**Storage**:
7. Where should rate limit data be stored? (Redis, memory, database?)
8. How long should rate limit data persist?

**Integration**:
9. Should rate limiting apply to all endpoints or specific ones?
10. Should there be whitelisted IPs or users?

Please answer these questions so I can design the right solution.
```

### Example: OAuth Authentication Questions

```
Before designing the OAuth architecture, I need to clarify:

**OAuth Providers**:
1. Which OAuth providers? (Google, GitHub, Microsoft, custom?)
2. Should we support multiple providers or just one?

**User Data**:
3. What user data should we store? (Profile, email, tokens?)
4. Should we store OAuth tokens or just user profile?
5. How should we handle token refresh?

**Integration**:
6. Should OAuth replace existing auth or add alongside?
7. How should OAuth sessions integrate with existing session management?
8. Should we support both OAuth and traditional auth?

**Security**:
9. How should we handle OAuth state to prevent CSRF?
10. What should happen if OAuth callback fails?

**UI/UX**:
11. Where should OAuth login buttons appear?
12. How should we handle new vs. returning users?

Please answer these questions so I can design the right solution.
```

## Phase 4: Architecture Design - Examples

### Example: Rate Limiting Approaches

```
I've designed 3 approaches for rate limiting:

**Approach 1: Minimal Changes**
- Use express-rate-limit middleware
- Add to src/app.ts after existing middleware
- Configure via environment variables
- Store in memory (simple, no Redis)

Files affected:
- src/app.ts (add middleware)
- .env (add rate limit config)

Pros:
- Fast to implement
- Minimal code changes
- Well-tested library

Cons:
- Memory storage (doesn't scale)
- No advanced features
- Limited configuration options

Risk: Low

**Approach 2: Clean Architecture**
- Create RateLimiter service with interface
- Implement Redis-based storage
- Separate configuration in src/config/rate-limit.ts
- Add custom middleware using service
- Support multiple rate limit strategies

Files affected:
- src/services/RateLimiter.ts (new)
- src/services/RateLimiterInterface.ts (new)
- src/middleware/rate-limit.ts (new)
- src/config/rate-limit.ts (new)
- src/app.ts (register middleware)
- .env (add Redis config)

Pros:
- Scalable (Redis storage)
- Testable (interface-based)
- Flexible configuration
- Easy to extend

Cons:
- More files to maintain
- Requires Redis
- More complex setup

Risk: Medium

**Approach 3: Pragmatic Balance**
- Use express-rate-limit with Redis store
- Add custom middleware wrapper for flexibility
- Configure in src/config/rate-limit.ts
- Support basic configuration options

Files affected:
- src/middleware/rate-limit.ts (new)
- src/config/rate-limit.ts (new)
- src/app.ts (add middleware)
- .env (add rate limit and Redis config)

Pros:
- Scalable (Redis storage)
- Simpler than Approach 2
- Leverages proven library
- Good balance of flexibility

Cons:
- Less testable than Approach 2
- Some coupling to express-rate-limit
- Limited customization

Risk: Low

**Recommendation**: Approach 3 - Pragmatic Balance

This approach gives you:
- Scalability with Redis storage
- Simplicity by using express-rate-limit
- Flexibility through custom wrapper
- Minimal refactoring needed
- Fits well with existing middleware pattern

Which approach would you like to use?
```

## Phase 5: Implementation - Examples

### Example: Todo List for Rate Limiting

```
Implementation tasks:

- [ ] Create src/config/rate-limit.ts with rate limit configuration
- [ ] Create src/middleware/rate-limit.ts with custom middleware
- [ ] Add Redis store configuration
- [ ] Register middleware in src/app.ts
- [ ] Add rate limit headers to responses
- [ ] Update .env with rate limit configuration
- [ ] Write tests for rate limiting
- [ ] Test with different rate limits
- [ ] Update documentation
```

### Example: Implementation Order

```
Starting implementation...

1. Creating configuration (src/config/rate-limit.ts)
   - Define rate limit interface
   - Add environment variable parsing
   - Set default values

2. Creating middleware (src/middleware/rate-limit.ts)
   - Import express-rate-limit
   - Create custom wrapper
   - Add Redis store
   - Configure rate limit headers
   - Handle errors

3. Registering middleware (src/app.ts)
   - Import rate limit middleware
   - Add to middleware chain
   - Place after auth middleware

4. Testing
   - Write unit tests
   - Write integration tests
   - Test with different scenarios

5. Documentation
   - Update README
   - Add configuration guide
   - Document API changes
```

## Phase 6: Quality Review - Examples

### Example: Code Review Findings

```
Code Review Results:

**Critical Issues**:
1. Memory leak in rate limit middleware (src/middleware/rate-limit.ts:45)
   - Redis connections not being closed properly
   - Fix: Add connection cleanup in middleware

2. Race condition in rate limit check (src/middleware/rate-limit.ts:67)
   - Multiple concurrent requests can bypass limit
   - Fix: Use Redis atomic operations

**High Priority**:
1. Missing error handling for Redis connection failure (src/middleware/rate-limit.ts:23)
   - App crashes if Redis is unavailable
   - Fix: Add try-catch and fallback to memory store

2. Rate limit headers not set on 429 responses (src/middleware/rate-limit.ts:89)
   - Clients can't see their rate limit status
   - Fix: Add headers to error response

**Medium Priority**:
1. Configuration validation missing (src/config/rate-limit.ts:15)
   - Invalid values can cause runtime errors
   - Fix: Add validation with error messages

2. Tests don't cover edge cases (tests/rate-limit.test.ts:45)
   - No tests for concurrent requests
   - Fix: Add more test cases

All tests pass. Code follows project conventions.

What would you like to do?
- Fix all issues now
- Fix critical/high priority now, medium later
- Proceed as-is
```

## Phase 7: Summary - Examples

### Example: Rate Limiting Summary

```
Feature Complete: Rate Limiting

**What was built**:
- Rate limiting middleware using express-rate-limit
- Redis-based storage for scalability
- Configurable rate limits via environment variables
- Rate limit headers in responses (X-RateLimit-Limit, X-RateLimit-Remaining)
- Fallback to memory store if Redis unavailable

**Key decisions**:
- Used Pragmatic Balance approach: express-rate-limit with Redis store
- Placed middleware after auth to rate limit authenticated requests
- Added fallback to memory store for resilience
- Configured 100 requests per 15 minutes default limit
- Different limits for admin users (1000 requests per 15 minutes)

**Files modified**:
- src/middleware/rate-limit.ts (new)
- src/config/rate-limit.ts (new)
- src/app.ts (modified)
- .env (modified)
- tests/rate-limit.test.ts (new)
- README.md (updated)

**Suggested next steps**:
- Add rate limit configuration per endpoint
- Implement rate limit analytics dashboard
- Add rate limit bypass for internal services
- Set up Redis monitoring and alerts
- Add more comprehensive tests for edge cases

**Known issues**:
None - all issues from code review have been fixed.

Feature is ready for testing in staging environment.
```

### Example: OAuth Authentication Summary

```
Feature Complete: OAuth Authentication

**What was built**:
- OAuth provider abstraction supporting Google and GitHub
- OAuth routes (/auth/google, /auth/github, /auth/callback)
- OAuth middleware for token validation
- User profile synchronization from OAuth providers
- Token refresh mechanism
- Session integration with existing session management
- OAuth state management for CSRF protection

**Key decisions**:
- Used Clean Architecture approach with OAuthService interface
- Added OAuth alongside existing auth (not replacement)
- Stored OAuth tokens for API calls, not just profile
- Integrated with existing Redis session management
- Added OAuth state with HMAC signature for CSRF protection
- Implemented token refresh with automatic retry

**Files modified**:
- src/services/OAuthProvider.ts (new)
- src/services/OAuthService.ts (new)
- src/routes/auth.ts (modified - added OAuth routes)
- src/middleware/oauth.ts (new)
- src/models/User.ts (modified - added OAuth fields)
- src/config/oauth.ts (new)
- .env (modified - added OAuth credentials)
- tests/oauth.test.ts (new)
- README.md (updated)

**Suggested next steps**:
- Add more OAuth providers (Microsoft, Apple)
- Add OAuth administration UI
- Implement OAuth token revocation
- Add OAuth usage analytics
- Add tests for token refresh edge cases
- Update API documentation with OAuth endpoints

**Known issues**:
None - all issues from code review have been fixed.

Feature is ready for testing in staging environment.
```